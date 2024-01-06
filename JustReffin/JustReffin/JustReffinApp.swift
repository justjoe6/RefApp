//
//  JustReffinApp.swift
//  JustReffin
//
//  Created by Joseph Ranieri on 11/12/23.
//

import SwiftUI

@main
struct JustReffinApp: App {
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Match Info", systemImage:"figure.soccer")
                    }
                TimerView()
                    .tabItem {
                        Label("Timer", systemImage: "stopwatch")
                    }
                GameLogsView()
                    .tabItem {
                        Label("Game Logs", systemImage:"list.clipboard")
                    }
            }
        }
    }
}
