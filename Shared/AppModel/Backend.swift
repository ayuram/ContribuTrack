//
//  backend.swift
//  contributrack
//
//  Created by Ayush Raman on 8/31/21.
//
import Firebase
import FirebaseDatabase

import Foundation

struct Unit : Codable {
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

enum UserType : String, Codable {
    case member, leader
}

struct Person : Hashable, Identifiable, Codable, Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.contribution < rhs.contribution
    }
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.contribution == rhs.contribution
    }
    let id: String
    let pfp: String?
    var name: String
    var type: UserType
    var contribution = 0
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
let firestore = Firestore.firestore()

typealias Categories = [String : [Person]]

class Workspace : ObservableObject, Identifiable, Codable {
    let id: String
    var name: String
    var unit: Unit
    var categories = Categories()
    init(withUnits unit: Unit, withUsers users: Categories? = .none, name: String) {
        self.unit = unit
        self.name = name
        self.categories = users ?? [:]
        id = UUID().uuidString
    }
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case unit
        case categories
    }
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        unit = try container.decode(Unit.self, forKey: .unit)
        categories = try container.decode(Categories.self, forKey: .categories)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(unit, forKey: .unit)
        try container.encode(categories, forKey: .categories)
    }
    func toJSON() -> Data? {
        try? JSONEncoder().encode(self)
    }
    func addUser(user: Person, category: String) {
        guard user.type == .member else {
            return
        }
        categories[category]?.append(user)
    }
    func getUsers() -> [Person] {
        categories
            .flatMap { $0.value.compactMap { $0 } }
    }
    func getTopUser() -> Person? {
        getUsers()
            .max(by: <)
    }
    func getSections() -> [String] {
        categories.getKeys().sorted()
    }
}
