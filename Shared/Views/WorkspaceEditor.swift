//
//  WorkspaceView.swift
//  contributrack
//
//  Created by Ayush Raman on 9/6/21.
//

import SwiftUI

struct WorkspaceEditor: View {
    @EnvironmentObject var workspace: Workspace
    @State var showUnitSheet = false
    var body: some View {
            Form {
                Section(header: Text("Workspace")) {
                    TextField("Name", text: $workspace.name)
                    Button("Create New Unit") {
                        showUnitSheet.toggle()
                    }
                }
                Section(header: Text("Permissions")) {
                    
                }
                
            }
            .sheet(isPresented: $showUnitSheet) {
                UnitCreator(workspace.unit) {
                    showUnitSheet.toggle()
                }
                    .environmentObject(workspace)
            }
            .navigationBarTitle(workspace.name)
    }
}

struct WorkspaceEditor_Previews: PreviewProvider {
    static var previews: some View {
        WorkspaceEditor()
            .environmentObject(Workspace.def)
    }
}
