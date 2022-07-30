//
//  CachedUser+CoreDataProperties.swift
//  ChallengeDay60NetworkApp
//
//  Created by Noah Glaser on 7/27/22.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var friends: NSSet?

    var wrappedId: UUID {
        id ?? UUID()
    }
    
    var wrapppedName: String {
        name ?? "Unknown Name"
    }
    
    var wrappedComppany: String {
        company ?? "Unknown Company"
    }
    
    var wrappedAbout: String {
        about ?? ""
    }
    
    var wrappedRegistered: Date {
        registered ?? Date()
    }
    
    var wrappedTags: [String] {
        if let tags = tags {
            return tags.components(separatedBy: ",")
        }
        
        return []
    }
    
    public var wrappedFriends: [CachedFriend] {
        let set = friends as! Set<CachedFriend>

        return set.sorted {
            $0.wrapppedName < $1.wrapppedName
        }
        
    }
    
    
}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
