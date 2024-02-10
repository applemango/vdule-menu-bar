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
    /*let imageUrl = URL(string: "https://s2.i32.jp/679fe1a3-c7cc-429c-a5f2-4d9fac76ce10")*/
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
            }.keyboardShortcut(keys[index], modifiers: [.option])
            /*Link(title, destination: URL(string: "https://www.youtube.com/watch?v=\(s.id)")!)*/
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
        /*Button("Settings"){
            
        }.keyboardShortcut("s")*/
        /*AsyncImage(url: imageUrl) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }.frame(width: 640, height: 478).id(imageUrl)*/
        //Text("Hello, Swift!")
    }
}

/*struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}*/
