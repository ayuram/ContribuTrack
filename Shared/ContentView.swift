//
//  ContentView.swift
//  Shared
//
//  Created by Ayush Raman on 8/31/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    let workspace = Workspace.def
    var body: some View {
        NavigationView {
            List {
                ForEach(workspace.getSections(), id: \.self) { section in
                    Section(header: Text(section)){
                        ForEach(workspace.categories[section] ?? []) {
                            UserTab($0)
                                .environmentObject(workspace)
                        }
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle(Text(workspace.name))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
