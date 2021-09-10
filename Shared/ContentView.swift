//
//  ContentView.swift
//  Shared
//
//  Created by Ayush Raman on 8/31/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @ObservedObject var workspaceRepository: WorkspaceRepositoryViewModel
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: WorkspaceView().environmentObject(Workspace.def),
                    label: {
                        /*@START_MENU_TOKEN@*/Text("Navigate")/*@END_MENU_TOKEN@*/
                    })
                ForEach(workspaceRepository.workspaces) { workspace in
                    WorkspaceTab(workspace: workspace)
                }
            }
            .navigationBarTitle("Workspaces")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(workspaceRepository: WorkspaceRepositoryViewModel())
            .preferredColorScheme(.dark)
    }
}
