//
//  TypeCasts.swift
//  contributrack
//
//  Created by Ayush Raman on 9/2/21.
//

import Foundation

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
