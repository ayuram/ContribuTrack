//
//  UserView.swift
//  contributrack
//
//  Created by Ayush Raman on 9/2/21.
//

import SwiftUI

struct UserView: View {
    let user: User
    @EnvironmentObject var workspace: Workspace
    init(user: User) {
        self.user = user
    }
    var body: some View {
        VStack {
            
        }.navigationTitle(user.name)
    }
}

struct UserView_Previews: PreviewProvider {
    static let workspace = Workspace(withUnits: Unit(notation: "$", name: "Income", prefixed: true, increment: 2.0, decrement: 2.0), withUsers: [
        User(name: "Bob", type: .member),
        User(name: "Ayush", type: .lead),
        User(name: "James", type: .member),
        User(name: "Carl", type: .member)
    ], name: "Workspace")
    static var previews: some View {
        UserView(user: workspace.getTopUser() ?? User(name: "France", type: .member))
            .environmentObject(workspace)
    }
}
