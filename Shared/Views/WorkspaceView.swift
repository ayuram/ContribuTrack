//
//  WorkspaceView.swift
//  contributrack
//
//  Created by Ayush Raman on 9/6/21.
//

import SwiftUI

struct WorkspaceView: View {
    @EnvironmentObject var workspace: Workspace
    var body: some View {
            Form {
                Section(header: Text("Workspace")) {
                    TextField("Name", text: $workspace.name)
                    Button("Create New Unit") {
                        
                    }
                }
                Section(header: Text("Privileges")) {
                    
                }
                
            }
    }
}

struct WorkspaceView_Previews: PreviewProvider {
    static var previews: some View {
        WorkspaceView()
            .environmentObject(Workspace.def)
    }
}
