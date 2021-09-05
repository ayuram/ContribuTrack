//
//  backend.swift
//  contributrack
//
//  Created by Ayush Raman on 8/31/21.
//
import Firebase
import FirebaseDatabase

import Foundation

struct Unit {
    let notation: String
    let name: String
    let prefixed: Bool
    var increment: Int
    var decrement: Int
    func getString(num: Int) -> String {
        if (prefixed) {
            return notation + " \(num)"
        } else {
            return "\(num) " + notation
        }
    }
}

enum UserType {
    case member, leader
}

struct Person : Hashable, Identifiable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.id == rhs.id
    }
    let id: String
    let pfp: String?
    var name: String
    var type: UserType
    init(uid: String? = .none, pfp: String? = .none, name: String, type: UserType) {
        self.id = uid ?? UUID().uuidString
        self.pfp = pfp
        self.name = name
        self.type = type
    }
    init() {
        self.id = UUID().uuidString
        self.pfp = .none
        self.name = ""
        self.type = .member
    }
}

let rtdb = Database.database().reference()

typealias QuantityMap = [Person:Double]

class Workspace : ObservableObject, Identifiable {
    let id: String
    var name: String
    var unit: Unit
    var users = QuantityMap()
    var categories = [String : QuantityMap]()
    init(withUnits unit: Unit, withUsers users: [Person]? = .none, name: String) {
        self.unit = unit
        self.name = name
        for user in users ?? [] {
            self.users[user] = 0.0
        }
        id = UUID().uuidString
    }
    func addUser(user: Person) {
        guard user.type == .member else {
            return
        }
        users[user] = 0.0
    }
    func getTopUser() -> Person? {
        users.max { maxUser, currUser in currUser.value < maxUser.value }?.key
    }
    func getUsers() -> [Person] {
        users.getKeys()
    }
    func getStatistic(_ operation: ([Double]) -> Double?) -> Double? {
        operation(users.values.sorted())
    }
}
