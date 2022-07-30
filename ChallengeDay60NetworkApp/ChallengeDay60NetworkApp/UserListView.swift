//
//  UserList.swift
//  ChallengeDay60NetworkApp
//
//  Created by Noah Glaser on 7/25/22.
//

import SwiftUI

struct UserListView: View {    
    let users: [CachedUser]
    
    let displayUsers: [CachedUser]
    
    var body: some View {
        List {
            ForEach(displayUsers, id: \.id) { user in
                NavigationLink {
                    DetailView(user: user, users: users)
                } label: {
                    HStack {
                        Text(user.wrapppedName)
                        Spacer()
                        Text(user.wrappedComppany)
                    }
                }
            }
        }
    }
}

struct UserList_Previews: PreviewProvider {
    static var previews: some View {
        UserListView( users: [], displayUsers: [])
    }
}
