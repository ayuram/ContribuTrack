//
//  TransactionStepper.swift
//  contributrack
//
//  Created by Ayush Raman on 9/5/21.
//

import SwiftUI
import FirebaseDatabase

struct TransactionStepper: View {
    let ref: DatabaseReference
    let unit: Unit
    @State var value = 0.0
    init(_ ref: DatabaseReference, unit: Unit) {
        self.ref = ref
        self.unit = unit
    }
    
    func incrementStep() {
        ref += unit.increment
    }
    
    func decrementStep() {
        ref -= unit.decrement
    }
    
    
    var body: some View {
        ref.observe(DataEventType.value) { snapshot in
            value = snapshot.value as! Double
        }
        return Stepper(
            onIncrement: incrementStep,
            onDecrement: decrementStep,
            label: {
                Text(value.toInt().notation(withUnits: unit))
            })
    }
}

struct TransactionStepper_Previews: PreviewProvider {
    static var previews: some View {
        TransactionStepper(rtdb.child("0"), unit: Unit.income)
    }
}
