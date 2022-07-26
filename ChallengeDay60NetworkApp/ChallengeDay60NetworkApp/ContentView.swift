//
//  ContentView.swift
//  ChallengeDay60NetworkApp
//
//  Created by Noah Glaser on 7/25/22.
//

import SwiftUI

func getUserData() async throws -> [User] {
    let (data, _) = try await URLSession.shared.data(for: URLRequest(url: URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!))
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    return try decoder.decode([User].self, from: data)
}

struct ContentView: View {
    @State var users: [User] = []
    
    var body: some View {
        NavigationView {
            VStack {
                UserListView(users: users, displayUsers: users)
            }
            .onAppear {
                if users.isEmpty {
                    Task {
                        do {
                            users = try await getUserData()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }.navigationTitle("Friends List")
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
