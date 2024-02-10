//
//  vduleApp.swift
//  vdule
//
//  Created by apple on 2024/02/10.
//

import SwiftUI

class LoadSchedule: ObservableObject {
    @Published var schedules = [Schedule]()
    func get() {
        guard let url = URL(string: "http://127.0.0.1:8081/schedule") else {
            print("Error: Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { (res, _, err) in
            if let e = err {
                print("Error: \(e.localizedDescription)")
                return
            }
            guard let res = res else {
                print("Error: Invalid data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let raw = try decoder.decode(RawResponseSchedule.self, from: res)
                DispatchQueue.main.async {
                    self.schedules = raw.videos
                }
            } catch let e {
                print("Error: \(e.localizedDescription)")
            }
        }.resume()
    }
    init() {
        let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {time in
            self.get()
        })
    }
}

class ScheduleUtils: ObservableObject {
    @Published var schedules = [Schedule]()
    func getSchedules() -> [Schedule] {
        return self.schedules
    }
    func getSortedSchedule() -> [Schedule] {
        return quickSort(arr: getSchedules()) { a, b in
            return a.date.hour ?? 0 < b.date.hour ?? 0
        }
    }
    func filterSchedule(hour: Int) -> [Schedule] {
        return getSchedules().filter { s in
            return s.date.hour ?? -1 > hour
        }
    }
    func getRecentEvent(hour: Int) -> Schedule? {
        let res = filterSchedule(hour: hour)
        if res.count == 0 {
            return nil
        }
        return filterSchedule(hour: hour)[0]
    }
    func getRecentEvent() -> Schedule? {
        let hour = Calendar.current.component(.hour, from: Date())
        return getRecentEvent(hour: hour)
    }
    init(schedules: [Schedule] = [Schedule]()) {
        self.schedules = schedules
    }
}

func getRelativeScheduleDateLabel(date: ScheduleDate) -> String {
    let n_hour = Calendar.current.component(.hour, from: Date())
    let n_minute = Calendar.current.component(.minute, from: Date())
    let startTime = DateComponents(hour: n_hour, minute: n_minute)
    let endTime = DateComponents(hour: date.hour, minute: date.minute)
    let startDate = Calendar.current.date(from: startTime)!
    let endDate = Calendar.current.date(from: endTime)!
    let components = Calendar.current.dateComponents([.hour, .minute], from: startDate, to: endDate)
    let hour = components.hour!
    let minute = components.minute!
    return "\(hour)時間\(minute)分"

}

func getLiveTitle(schedule: Schedule) -> String {
    return "\(schedule.channel.name)･あと\(getRelativeScheduleDateLabel(date: schedule.date))"
}

@main
struct vduleApp: App {
    @ObservedObject var loader = LoadSchedule()
    @AppStorage("hide") private var hide = true
    var body: some Scene {
        let util = ScheduleUtils(schedules: loader.schedules)
        let live = util.getRecentEvent()
        let title = live == nil ? "ライブはありません" : getLiveTitle(schedule: live!)
    
        MenuBarExtra(isInserted: $hide) {
            MenuView(loader: loader)
        } label: {
            Text(title)
        }
    }
}
