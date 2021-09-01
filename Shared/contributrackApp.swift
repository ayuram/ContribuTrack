//
//  contributrackApp.swift
//  Shared
//
//  Created by Ayush Raman on 8/31/21.
//

import SwiftUI

@main
struct contributrackApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
            }
        }
    }
}
