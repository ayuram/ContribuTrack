//
//  TypeCasts.swift
//  contributrack
//
//  Created by Ayush Raman on 9/2/21.
//

import Foundation
import FirebaseDatabase
import Firebase

extension Int {
    func toDouble() -> Double {
        Double(self)
    }
    func notation(withUnits unit: Unit) -> String {
        unit.getString(num: self)
    }
}

extension Double {
    func toInt() -> Int {
        Int(self)
    }
    func notation(withUnits unit: Unit) -> String {
        unit.getString(num: self.toInt())
    }
}

extension ArraySlice {
    func toArray() -> [Element] {
        Array(self)
    }
}

extension Dictionary.Keys {
    func toArray() -> [Element] {
        Array(self)
    }
}

extension Dictionary {
    func getKeys() -> [Key] {
        Array(self.keys)
    }
    func getValues() -> [Value] {
        Array(self.values)
    }
}

extension Array where Element == Person {
    func getStatistic(_ operation: ([Double]) -> Double?) -> Double? {
        operation(self.map { $0.contribution.toDouble() })
    }
}

extension Categories {
//    func toJSON() -> [String:[String:Any]] {
//        let json = [String:[String:Any]]()
//        self.forEach { key, users in
//            users.forEach { user in
//                json[key][user.id][]
//            }
//        }
//    }
}

extension Workspace {
    public static let def = Workspace(withUnits: Unit.income, withUsers: [
        "Software" : [
        Person(name: "Bob", type: .member),
        Person(name: "Ayush", type: .leader),
        Person(name: "James", type: .member),
        Person(name: "Carl", type: .member)
            ],
        "Hardware" : [
        Person(name: "Joseph", type: .member),
        Person(name: "Allen", type: .leader),
        Person(name: "Gavin", type: .member),
        Person(name: "Emily", type: .member)
            ]
    ], name: "Workspace")
}

extension Unit {
    public static let income = Unit(notation: "$", name: "Income", prefixed: true, increment: 1, decrement: 1)
}

extension DatabaseReference {
    static func -=(lhs: DatabaseReference, rhs: Int) {
        lhs.decrement(rhs)
    }
    static func +=(lhs: DatabaseReference, rhs: Int) {
        lhs.increment(rhs)
    }
    static postfix func ++(lhs: DatabaseReference) {
        lhs.increment()
    }
    static postfix func --(lhs: DatabaseReference) {
        lhs.decrement()
    }
    
    private func increment(_ val: Int = 1) {
        runTransactionBlock { mutableData in
            if let curr = mutableData.value as? Int{
                mutableData.value = curr + 1
                return TransactionResult.success(withValue: mutableData)
            } else{
                return TransactionResult.success(withValue: mutableData)
            }
        }
    }
    
    private func decrement(_ val: Int = 1) {
        runTransactionBlock { mutableData in
            if let curr = mutableData.value as? Int{
                mutableData.value = curr - 1
                return TransactionResult.success(withValue: mutableData)
            } else{
                return TransactionResult.success(withValue: mutableData)
            }
        }
    }
}
