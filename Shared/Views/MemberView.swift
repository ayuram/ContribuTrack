//
//  PersonView.swift
//  contributrack
//
//  Created by Ayush Raman on 9/2/21.
//

import SwiftUI
import SwiftUICharts
import FirebaseFirestore

struct MemberView: View {
    let member: Person
    @EnvironmentObject var workspace: Workspace
    init(member: Person) {
        self.member = member
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text(now())
                .font(.title)
            HStack {
                BarChartView(data: ChartData(points: workspace.getUsers().map { $0.contribution.toDouble() }), title: "\(workspace.unit.name) (\(workspace.unit.notation))", style: Styles.barChartStyleNeonBlueDark, form: ChartForm.extraLarge, cornerImage: .none)
                BarGraph(name: "Median", val: workspace.getUsers().getStatistic(median) ?? 0, max: workspace.getUsers().getStatistic(max) ?? 0)
            }
            .bottomPad()
            // TransactionStepper(rtdb.child("0"), unit: workspace.unit)
        }
        .navigationBarTitle(member.name)
    }
    func now() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let dateString = formatter.string(from: Date())
        return dateString
    }
}

struct MemberView_Previews: PreviewProvider {
    static let workspace = Workspace.def
    static var previews: some View {
        MemberView(member: workspace.getTopUser() ?? Person(name: "France", type: .member))
            .environmentObject(workspace)
            .preferredColorScheme(.dark)
    }
}
