//
//  vduleApp.swift
//  vdule
//
//  Created by apple on 2024/02/10.
//

import SwiftUI

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
