//
//  WorkspaceTab.swift
//  contributrack
//
//  Created by Ayush Raman on 9/9/21.
//

import SwiftUI

struct WorkspaceTab: View {
    var workspace: Workspace
    var body: some View {
        NavigationLink(destination: WorkspaceView().environmentObject(workspace)) {
                Text(workspace.name)
                    .padding()
        }
    }
}

struct WorkspaceTab_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        WorkspaceTab(workspace: Workspace.def)
        }
    }
}
