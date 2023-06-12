//
//  CachedFriend+CoreDataProperties.swift
//  Friendface
//
//  Created by Uriel Ortega on 12/06/23.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var user: CachedUser?
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
}

extension CachedFriend : Identifiable {

}
