//
//  MenuView.swift
//  vdule
//
//  Created by apple on 2024/02/10.
//

import Foundation

import SwiftUI

struct MenuView: View {
    @ObservedObject var loader: LoadSchedule
    @Environment(\.openURL) private var openURL
    var body: some View {
        let util = ScheduleUtils(schedules: loader.schedules)
        let schedules = util.getEventAfter()
        Label("Live Schedule", systemImage: "")
        ForEach((0..<schedules.count), id: \.self) { index in
            let s = schedules[index]
            let title = getLiveTitle(schedule: s)
            let imageUrl = URL(string: "https://s2.i32.jp/?url=\(s.channel.icon_image)")
            let keys = [
                KeyEquivalent("0"),
                KeyEquivalent("1"),
                KeyEquivalent("2"),
                KeyEquivalent("3"),
                KeyEquivalent("4"),
                KeyEquivalent("5"),
                KeyEquivalent("6"),
                KeyEquivalent("7"),
                KeyEquivalent("8"),
                KeyEquivalent("9")
            ]
            Button(action: {
                if let url = URL(string: "https://www.youtube.com/watch?v=\(s.id)") {
                    openURL(url)
                }
            }) {
                HStack {
                    AsyncImage(url: imageUrl) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }.frame(width: 30, height: 30).id(imageUrl)
                    Text(title)
                }
            }.keyboardShortcut(index>9 ?"-":keys[index], modifiers: [.option])
        }
        Divider()
        Label("Website and settings", systemImage: "")
        Button(action: {}) {
            HStack {
                Image(systemName: "gearshape")
                Text("Settings")
            }
        }.keyboardShortcut(",")
        Button(action: {
            if let url = URL(string: "http://127.0.0.1:3001") {
                openURL(url)
            }
        }) {
            HStack {
                Image(systemName: "network")
                Text("Website")
            }
        }.keyboardShortcut("o")
        Divider()
        Button(action: {
            NSApplication.shared.terminate(nil)
        }) {
            HStack {
                Image(systemName: "delete.forward")
                Text("Quit")
            }
        }.keyboardShortcut("q")
    }
}
