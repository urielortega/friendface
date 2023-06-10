//
//  CachedFriend+CoreDataProperties.swift
//  Friendface
//
//  Created by Uriel Ortega on 10/06/23.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var userFriend: NSSet?

    public var wrappedId: String {
        id ?? "Unknown Id"
    }
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var userFriendArray: [CachedUser] {
        let set = userFriend as? Set<CachedUser> ?? [] // If the conversion to Set<CachedUser> fails, return an empty set.
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for userFriend
extension CachedFriend {

    @objc(addUserFriendObject:)
    @NSManaged public func addToUserFriend(_ value: CachedUser)

    @objc(removeUserFriendObject:)
    @NSManaged public func removeFromUserFriend(_ value: CachedUser)

    @objc(addUserFriend:)
    @NSManaged public func addToUserFriend(_ values: NSSet)

    @objc(removeUserFriend:)
    @NSManaged public func removeFromUserFriend(_ values: NSSet)

}

extension CachedFriend : Identifiable {

}
