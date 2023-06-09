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
    let user: User
    
    struct Attribute {
        let label: String
        let value: String
    }
    
    var attributes: [Attribute] {
        [
            Attribute(label: "Age", value: String(user.age)),
            Attribute(label: "Company", value: user.company),
            Attribute(label: "Email", value: user.email),
            Attribute(label: "Address", value: user.address),
            Attribute(label: "About", value: user.about),
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
                ForEach(user.tags, id: \.self) { tag in
                    Text(tag)
                }
            }
            
            Section("Friends") {
                ForEach(user.friends, id: \.id) { friend in
                    Text(friend.name)
                }
            }
        }
        .navigationTitle(user.name + (user.isActive ? " 👋🏼" : " 💤"))
    }
}
