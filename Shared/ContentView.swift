//
//  ContentView.swift
//  Shared
//
//  Created by Ayush Raman on 8/31/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    let workspace = Workspace(withUnits: Unit(notation: "$", name: "Income", prefixed: true, increment: 2, decrement: 2), withUsers: [
        Person(name: "Bob", type: .member),
        Person(name: "Ayush", type: .leader),
        Person(name: "James", type: .member),
        Person(name: "Carl", type: .member)
    ], name: "Workspace")
    var body: some View {
        NavigationView {
            List {
                ForEach(workspace.getUsers()) { user in
                    NavigationLink(
                        destination: MemberView(member: user)
                            .environmentObject(workspace)
                    ) {
                        UserTab(user)
                    }
                }
            }
        }
        .navigationBarTitle(workspace.name)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
