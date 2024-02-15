//
//  vtuber.swift
//  vdule
//
//  Created by apple on 2024/02/15.
//

import Foundation

class LoadVtuber: ObservableObject {
    @Published var vtubers = [Vtuber]()
    func get() {
        guard let url = URL(string: "http://127.0.0.1:8081/vtubers") else {
            print("Error Load Vtuber: Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { (res, _, err) in
            if let e = err {
                print("Error Load Vtuber: \(e.localizedDescription)")
                return
            }
            guard let res = res else {
                print("Error Load Vtuber: Invalid data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let raw = try decoder.decode([Vtuber].self, from: res)
                DispatchQueue.main.async {
                    self.vtubers = raw
                }
            } catch let e {
                print("Error Load Vtuber Data: \(e.localizedDescription)")
            }
        }.resume()
    }
    init() {
        self.get()
    }
}
