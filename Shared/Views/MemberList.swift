//
//  MemberList.swift
//  contributrack
//
//  Created by Ayush Raman on 9/9/21.
//

import SwiftUI

struct MemberList: View {
    @EnvironmentObject var workspace: Workspace
    var body: some View {
        List {
            ForEach(workspace.categories) { category in
                Section(header: Text(category.name) ) {
                    ForEach(category.members) { member in
                        UserTab(member)
                            .environmentObject(workspace)
                    }
                }
            }
        }
        .listStyle(SidebarListStyle())
        .navigationBarTitle(workspace.name)
    }
}

struct MemberList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MemberList()
                .environmentObject(Workspace.def)
        }
    }
}
