//
//  DetailView.swift
//  ChallengeDay60NetworkApp
//
//  Created by Noah Glaser on 7/25/22.
//

import SwiftUI

struct DetailView: View {
        
    let user: User
    
    let users: [User]
    
    var displayUsers: [User] {
        let friendUUIDs = user
            .friends
            .map{ $0.id.uuidString}
        return users.filter{ u in
            friendUUIDs.contains(u.id.uuidString)
        }
    }
    
    var body: some View {
            VStack(alignment: .leading, spacing: 10) {

                Text("Company: \(user.company)")
                    Text("Age: \(user.age)")
                    Text(user.about)
                        .multilineTextAlignment(.leading)
                Spacer()
                UserListView(users: users, displayUsers: displayUsers)
                
            }
            .navigationTitle(user.name)
                .navigationBarTitleDisplayMode(.inline)
            .padding()
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(user: User(id: UUID(), name: "Bill", age: 20, company: "Acme", about: "about this", registered: Date(), tags: [], isActive: true, friends: []), users: [])
    }
}
