//
//  ContentView.swift
//  Shared
//
//  Created by Ayush Raman on 8/31/21.
//

import SwiftUI

struct ContentView: View {
    let workspace = Workspace(withUnits: Unit(notation: "$", name: "Income", prefixed: true, increment: 2.0, decrement: 2.0), withUsers: [
        User(name: "Bob", type: .member),
        User(name: "Ayush", type: .lead),
        User(name: "James", type: .member),
        User(name: "Carl", type: .member)
    ], name: "Workspace")
    var body: some View {
        NavigationView {
            List {
                ForEach(workspace.getUsers(), id: \.self) { user in
                    NavigationLink(
                        destination: UserView(user: user)
                            .environmentObject(workspace)
                    ) {
                        UserTab(user)
                    }
                }
            }
        }
        .navigationTitle(workspace.name)
        .navigationBarItems(trailing: Text("Hello"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
