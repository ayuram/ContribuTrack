//
//  backend.swift
//  contributrack
//
//  Created by Ayush Raman on 8/31/21.
//
import Firebase
import FirebaseDatabase
import Combine

import Foundation
import FirebaseFirestoreSwift

struct Unit : Codable {
    var notation: String
    var name: String
    var prefixed: Bool
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
    @DocumentID var id: String?
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

class Category : Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var members: [Person]
    init (id: String?, name: String, members: [Person]) {
        self.id = id
        self.name = name
        self.members = members
    }
}

let rtdb = Database.database().reference()
let firestore = Firestore.firestore()


class Workspace : ObservableObject, Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var unit: Unit
    var categories = [Category]()
    init(withUnits unit: Unit, withUsers users: [Category] = [], name: String) {
        self.unit = unit
        self.name = name
        self.categories = users
        id = UUID().uuidString
    }
    func addUser(user: Person, category: Category) {
        guard user.type == .member else {
            return
        }
        categories.first(where: { $0.id == category.id })?.members.append(user)
    }
    func getUsers() -> [Person] {
        categories
            .flatMap { $0.members.compactMap { $0 } }
    }
    func getTopUser() -> Person? {
        getUsers()
            .max(by: <)
    }
    func getSections() -> [String] {
        categories
            .map { $0.name }
            .sorted()
    }
}

class WorkspaceRepository : ObservableObject {
    @Published var workspaces: [Workspace] = []
    init() {
        // get(completionHandler)
    }
    func get(_ completionHandler: @escaping ([String]?) -> Void) {
        var keys: [String] = []
        firestore
            .collection("users")
            .document("\(String(describing: systemUser?.uid))")
            .getDocument(source: .default) { document, error in
                if let document = document {
                    keys = document.data()?["workspaces"] as! [String]
                } else {
                    print("Document does not exist in cache")
                }
                DispatchQueue.main.async {
                    if keys.isEmpty {
                        completionHandler(.none)
                    } else {
                        completionHandler(keys)
                    }
                }
                
            }
        
        

    }
    func completionHandler(_ keys: [String]?) {
        workspaces = []
        keys?.forEach { key in
            firestore
                .collection("workspaces")
                .document(key)
                .getDocument(source: .default) { document, error in
                    if let document = document {
                        if let workspace = try? document.data(as: Workspace.self){
                            self.workspaces.append(workspace)
                        }
                    } else {
                        print("Document does not exist")
                    }
                }
        }
    }
    func add(_ workspace: Workspace) {
        let ref = firestore
            .collection("users")
            .document("\(String(describing: systemUser?.uid))")
        firestore.runTransaction({ (transaction, errorPointer) -> Any? in
            let document: DocumentSnapshot
                do {
                    try document = transaction.getDocument(ref)
                } catch let fetchError as NSError {
                    errorPointer?.pointee = fetchError
                    return .none
                }
            guard var workspaces = document.data()?["workspaces"] as? [String] else {
                let error = NSError(
                    domain: "AppErrorDomain",
                    code: -1,
                    userInfo: [
                        NSLocalizedDescriptionKey: "Unable to retrieve workspaces from snapshot \(document)"
                    ]
                )
                errorPointer?.pointee = error
                return .none
            }
            if let id = workspace.id {
                workspaces.append(id)
            }
            
            transaction.updateData(["workspaces" : workspaces], forDocument: ref)
            return .none
        }, completion: { (_, error) in
            if let error = error {
                print("Transaction failed: \(error)")
            } else {
                print("Transaction successfully committed!")
            }
        })
    }
}
