//
//  User.swift
//  Friendface
//
//  Created by Uriel Ortega on 08/06/23.
//

import Foundation

struct User: Codable, Identifiable {
    struct Friend: Codable {
        var id: String
        var name: String
    }
    
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
    
    var formattedRegisterDate: String {
        registered.formatted(date: .abbreviated, time: .omitted)
    }
}
