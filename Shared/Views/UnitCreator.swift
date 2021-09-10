//
//  UnitCreator.swift
//  contributrack
//
//  Created by Ayush Raman on 9/6/21.
//

import SwiftUI

struct UnitCreator: View {
    @EnvironmentObject var workspace: Workspace
    @State var newUnit: Unit
    @State var num = 0
    var exitingFunc: () -> Void
    init(_ currentUnit: Unit = Unit.income, action: @escaping () -> Void) {
        newUnit = currentUnit
        exitingFunc = action
    }
    var body: some View {
        Form {
            Section {
                Stepper(onIncrement: increment, onDecrement: decrement) {
                    Text("\(newUnit.name) : \(newUnit.getString(num: num))")
                }
            }
            Section {
                TextField("Name", text: $newUnit.name)
                TextField("Shorthand Notation", text: $newUnit.notation)
                Toggle("Shorthand Prefixed", isOn: $newUnit.prefixed)
                Stepper("Increment Value : \(newUnit.increment)", value: $newUnit.increment, in: 0...Int.max)
                Stepper("Decrement Value : \(newUnit.decrement)", value: $newUnit.decrement, in: 0...Int.max)
            }
            Section {
                Button("Save") {
                    workspace.unit = newUnit
                    exitingFunc()
                }
            }
        }
    }
    func increment() {
        num += newUnit.increment
    }
    func decrement() {
        guard num - newUnit.decrement >= 0 else {
            return num = 0
        }
        num -= newUnit.decrement
    }
}

struct UnitCreator_Previews: PreviewProvider {
    static let workspace = Workspace.def
    static var previews: some View {
        UnitCreator(workspace.unit) {
            
        }
            .environmentObject(workspace)
    }
}
