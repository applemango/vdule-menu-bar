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
        Label("Live Schedule", systemImage: "")
        ForEach(util.getEventAfter(), id: \.id) { s in
            let title = getLiveTitle(schedule: s)
            let imageUrl = URL(string: "https://s2.i32.jp/?url=\(s.channel.icon_image)")
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
            }.keyboardShortcut("o")
        }
        Divider()
        Label("Website and settings", systemImage: "")
        Button(action: {}) {
            HStack {
                Image(systemName: "gearshape")
                Text("Settings")
            }
        }.keyboardShortcut("s")
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
    }
}

