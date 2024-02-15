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
    var body: some View {
        TabView {
            Form {
                Section(header: Text("Subscribe Vtubers")) {
                    Toggle("Filter Vtuber", isOn: $filterVtubers)
                    List {
                        Toggle("Filter Vtuber Not working", isOn: $filterVtubers)
                        Toggle("Filter Vtuber Not working", isOn: $filterVtubers)
                        Toggle("Filter Vtuber Not working", isOn: $filterVtubers)
                    }
                }
            }.padding(8).tabItem {Label("General", systemImage: "gearshape")}
            Form {
                
            }.padding(8).tabItem {Label("Advanced", systemImage: "slider.horizontal.3")}
        }.frame(width: 460, height: 600)
    }
}
