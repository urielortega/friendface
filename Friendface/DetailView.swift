//
//  DetailedView.swift
//  Friendface
//
//  Created by Uriel Ortega on 08/06/23.
//

import SwiftUI

struct AttributeRow: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .foregroundColor(.primary)
                .font(.headline)
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}

struct DetailView: View {
    let user: CachedUser
    
    struct Attribute {
        let label: String
        let value: String
    }
    
    var attributes: [Attribute] {
        [
            Attribute(label: "Age", value: String(user.age)),
            Attribute(label: "Company", value: user.wrappedCompany),
            Attribute(label: "Email", value: user.wrappedEmail),
            Attribute(label: "Address", value: user.wrappedAddress),
            Attribute(label: "About", value: user.wrappedAbout),
            Attribute(label: "Registered on", value: user.formattedRegisterDate),
        ]
    }
    
    var body: some View {
        List {
            Section {
                ForEach(attributes, id: \.label) { attribute in
                    AttributeRow(label: attribute.label, value: attribute.value)
                }
            }
            
            Section("Tags") {
                ForEach((user.tags?.components(separatedBy: ","))!, id: \.self) { tag in
                    Text(tag)
                }
            }
            
            Section("Friends") {
                ForEach(user.friendsArray) { friend in
                    Text(friend.wrappedName)
                }
            }
        }
        .navigationTitle(user.wrappedName + (user.isActive ? " 👋🏼" : " 💤"))
    }
}
