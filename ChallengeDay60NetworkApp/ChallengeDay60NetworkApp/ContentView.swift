//
//  ContentView.swift
//  ChallengeDay60NetworkApp
//
//  Created by Noah Glaser on 7/25/22.
//

import SwiftUI

import CoreData



struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State var cachedUsers = [CachedUser]()
    
    
    var body: some View {
        NavigationView {
            VStack {
                UserListView(users: cachedUsers, displayUsers: cachedUsers)
            }
            .onAppear {
                if cachedUsers.isEmpty {
                    Task {
                        let internetUsers = await getUserData()
                        await MainActor.run {
                            do {
                                let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CachedUser")
                                
                                
                                if !internetUsers.isEmpty {
                                    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                                    try moc.execute(deleteRequest)
                                    print("Deleted Cached Users")
                                    for user in internetUsers {
                                        let cachedUser = CachedUser(context: moc)
                                        cachedUser.tags = user.tags.joined(separator: ",")
                                        cachedUser.registered = user.registered
                                        cachedUser.about = user.about
                                        cachedUser.id = user.id
                                        cachedUser.company = user.company
                                        cachedUser.age = Int16(user.age)
                                        cachedUser.isActive = user.isActive
                                        cachedUser.name = user.name
                                        for friend in user.friends {
                                            let cachedFriend = CachedFriend(context: moc)
                                            cachedFriend.name = friend.name
                                            cachedFriend.cachedFriendId = friend.id
                                            cachedFriend.id = UUID()
                                            cachedUser.addToFriends(cachedFriend)
                                        }
                                        
                                        try moc.save()
                                    }
                                }
                                
                                if let freshCachedUsers =  try moc.fetch(fetchRequest) as? [CachedUser] {
                                    cachedUsers = freshCachedUsers
                                }
                            } catch {
                                print("ERROR")
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }.navigationTitle("Friends List")
        }
        
        
    }
    
    func getUserData() async -> [User]  {
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!))
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            return try decoder.decode([User].self, from: data)
        } catch {
            print("INTERNET FETCH FAILED")
        }
        
        return []
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
