//
//  WorkspaceView.swift
//  contributrack
//
//  Created by Ayush Raman on 9/9/21.
//

import SwiftUI

struct WorkspaceView: View {
    @EnvironmentObject var workspace: Workspace
    var body: some View {
        TabView {
            MemberList()
                .tabItem {
                    Label("Members", systemImage: "list.dash")
                }
            WorkspaceEditor()
                .tabItem {
                    Label("Workspace", systemImage: "person.circle")
                }
        }
        .navigationBarTitle(workspace.name)
        .environmentObject(workspace)
    }
}

struct WorkspaceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkspaceView()
                .environmentObject(Workspace.def)
        }
    }
}
