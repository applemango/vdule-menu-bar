//
//  SettingsView.swift
//  vdule
//
//  Created by apple on 2024/02/15.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @AppStorage("filterVtubers") var filterVtubers: Bool = false
    @ObservedObject var loader: LoadVtuber
    var body: some View {
        let vtubers = loader.vtubers
        let _ = print(vtubers.count)
        TabView {
            Form {
                Section(header: Text("Subscribe Vtubers")) {
                    Toggle("Filter Vtuber", isOn: $filterVtubers)
                    List {
                        ForEach(vtubers, id: \.id) { vtuber in
                            Toggle(vtuber.name, isOn: $filterVtubers)
                        }
                    }
                }
            }.padding(8).tabItem {Label("General", systemImage: "gearshape")}
            Form {
                
            }.padding(8).tabItem {Label("Advanced", systemImage: "slider.horizontal.3")}
        }.frame(width: 460, height: 600)
    }
}
