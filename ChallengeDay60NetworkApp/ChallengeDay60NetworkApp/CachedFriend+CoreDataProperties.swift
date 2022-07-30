//
//  CachedFriend+CoreDataProperties.swift
//  ChallengeDay60NetworkApp
//
//  Created by Noah Glaser on 7/29/22.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var cachedFriendId: UUID?
    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var cachedUser: CachedUser?
    
    var wrapppedName: String {
        name ?? "Unknown Name"
    }
}

extension CachedFriend : Identifiable {

}
