//
//  ContentView.swift
//  Friendface
//
//  Created by Uriel Ortega on 08/06/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var users = [User]()
    
    var body: some View {
        NavigationStack {
            Group {
                if users.isEmpty {
                    Text("No data available")
                } else {
                    List(users) { user in
                        NavigationLink {
                            DetailView(user: user)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(user.name)
                                    .font(.headline)
                                Text(user.isActive ? "Online 👋🏼" : "Offline 💤")
                                    .foregroundColor(.secondary)
                            }
                            .padding(3)
                        }
                    }
                }
            }
            .navigationTitle("Friendface")
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard users.isEmpty else { return }
        
        do {
            // Creating the URL we want to read.
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            
            // Fetching the data for the URL.
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decoding the result of the data into a User array
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            users = try decoder.decode([User].self, from: data)
            
            await MainActor.run {
                updateCache(with: users)
            }
        } catch {
            print("Download failed.")
        }
    }
    
    func updateCache(with downloadedUsers: [User]) {
        for user in downloadedUsers {
            let cachedUser = CachedUser(context: moc)
            
            cachedUser.id = user.id
            cachedUser.isActive = user.isActive
            
            cachedUser.name = user.name
            cachedUser.age = Int16(user.age)
            cachedUser.company = user.company
            cachedUser.email = user.email
            cachedUser.address = user.address
            cachedUser.about = user.about
            cachedUser.registered = user.registered
            cachedUser.tags = user.tags.joined(separator: ",")
            
            for friend in user.friends {
                let cachedFriend = CachedFriend(context: moc)
                cachedFriend.id = friend.id
                cachedFriend.name = friend.name
                
                cachedUser.addToFriends(cachedFriend)
            }
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
