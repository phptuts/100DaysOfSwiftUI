//
//  DetailView.swift
//  ChallengeDay60NetworkApp
//
//  Created by Noah Glaser on 7/25/22.
//

import SwiftUI

struct DetailView: View {
        
    let user: CachedUser
    
    let users: [CachedUser]
    
    var displayUsers: [CachedUser] {
        let friendUUIDs = user.wrappedFriends.map { $0.cachedFriendId?.uuidString }
        return users.filter { u in
            return friendUUIDs.contains(u.id?.uuidString ?? "")
        }
    }
    
    var body: some View {
            VStack(alignment: .leading, spacing: 10) {

                Text("Company: \(user.wrappedComppany)")
                    Text("Age: \(user.age)")
                    Text(user.wrappedAbout)
                        .multilineTextAlignment(.leading)
                Spacer()
                UserListView(users: users, displayUsers: displayUsers)
                
            }
            .navigationTitle(user.wrapppedName)
                .navigationBarTitleDisplayMode(.inline)
            .padding()
        
    }
}


