//
//  UserTab.swift
//  contributrack
//
//  Created by Ayush Raman on 9/2/21.
//

import SwiftUI

struct UserTab: View {
    let user: Person
    init(_ user: Person) {
        self.user = user
    }
    var body: some View {
        HStack {
            Image(systemName: "person")
                .padding()
            Text(user.name)
            Spacer()
            getLabel()
                .accentColor(.red)
                .padding()
        }
    }
    func getLabel() -> Image {
        switch user.type {
            case .member:
                return Image(systemName: "person.3.fill")
            default:
                return Image(systemName: "person.crop.circle.fill")
        }
    }
}

struct UserTab_Previews: PreviewProvider {
    static let user = Person(name: "Bob", type: .member)
    static var previews: some View {
        UserTab(user)
    }
}
