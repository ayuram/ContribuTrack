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
}

extension Double {
    func toInt() -> Int {
        Int(self)
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
