//
//  contributrackApp.swift
//  Shared
//
//  Created by Ayush Raman on 8/31/21.
//

import SwiftUI
import UIKit
import Firebase

let systemUser: User? = .none

@main
struct contributrackApp: App {
    init() {
        FirebaseApp.configure()
        Auth.auth().addStateDidChangeListener { auth, user in
            
        }
    }
    var body: some Scene {
        WindowGroup {
            AuthWrapper()
        }
    }
}

struct AuthWrapper: View {
    var body: some View {
        switch systemUser {
            case .none: LoginView()
            default: TabView {
                ContentView()
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
            }
        }
    }
}
