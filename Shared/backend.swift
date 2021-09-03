//
//  backend.swift
//  contributrack
//
//  Created by Ayush Raman on 8/31/21.
//
import Firebase

import Foundation

struct Unit {
    let notation: String
    let name: String
    let prefixed: Bool
    var increment: Double
    var decrement: Double
}

enum UserType {
    case lead, member
}

struct User : Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.uid == rhs.uid
    }
    let uid: String
    let pfp: String?
    var name: String
    var type: UserType
    init(uid: String? = .none, pfp: String? = .none, name: String, type: UserType) {
        self.uid = uid ?? UUID().uuidString
        self.pfp = pfp
        self.name = name
        self.type = type
    }
    init() {
        self.uid = UUID().uuidString
        self.pfp = .none
        self.name = ""
        self.type = UserType.member
    }
}



class Workspace {
    private var name: String
    private var unit: Unit
    private var users = [User:Double]()
    init(withUnits unit: Unit, withUsers users: [User]? = .none, name: String) {
        self.unit = unit
        self.name = name
        for user in users ?? [] {
            self.users[user] = 0.0
        }
    }
    func addUser(user: User) {
        guard user.type == .member else {
            return
        }
        users[user] = 0.0
    }
    func getTopUser() -> User? {
        users.max { maxUser, currUser in currUser.value < maxUser.value }?.key
    }
    func getStatistic(fun operation: ([Double]) -> Double?) -> Double? {
        operation(users.values.sorted())
    }
}
