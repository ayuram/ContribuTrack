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
            BarGraph(name: "Median", val: workspace.getStatistic(median) ?? 0, max: workspace.getStatistic(max) ?? 0)
        }.navigationBarTitle(member.name)
    }
}

struct MemberView_Previews: PreviewProvider {
    static let workspace = Workspace(withUnits: Unit(notation: "$", name: "Income", prefixed: true, increment: 2, decrement: 2), withUsers: [
        Person(name: "Bob", type: .member),
        Person(name: "Ayush", type: .leader),
        Person(name: "James", type: .member),
        Person(name: "Carl", type: .member)
    ], name: "Workspace")
    static var previews: some View {
        MemberView(member: workspace.getTopUser() ?? Person(name: "France", type: .member))
            .environmentObject(workspace)
    }
}
