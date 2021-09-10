//
//  contributrackApp.swift
//  Shared
//
//  Created by Ayush Raman on 8/31/21.
//

import SwiftUI
import UIKit
import Firebase

var systemUser: User? = .none

@main
struct contributrackApp: App {
    init() {
        FirebaseApp.configure()
        Auth.auth().addStateDidChangeListener { _, user in
            systemUser = user
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
            case .none:
                ContentView(workspaceRepository: WorkspaceRepositoryViewModel())
            default: ContentView(workspaceRepository: WorkspaceRepositoryViewModel())
        }
    }
}
