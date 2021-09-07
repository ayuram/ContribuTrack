//
//  PersonView.swift
//  contributrack
//
//  Created by Ayush Raman on 9/2/21.
//

import SwiftUI
import SwiftUICharts

struct MemberView: View {
    let member: Person
    @EnvironmentObject var workspace: Workspace
    init(member: Person) {
        self.member = member
    }
    var body: some View {
        return VStack {
            TransactionStepper(rtdb.child("0"), unit: workspace.unit)
            BarGraph(name: "Median", val: workspace.getUsers().getStatistic(median) ?? 0, max: workspace.getUsers().getStatistic(max) ?? 0)
        }.navigationBarTitle(member.name)
    }
}

struct MemberView_Previews: PreviewProvider {
    static let workspace = Workspace.def
    static var previews: some View {
        MemberView(member: workspace.getTopUser() ?? Person(name: "France", type: .member))
            .environmentObject(workspace)
    }
}
