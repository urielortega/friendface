//
//  ContentView.swift
//  Friendface
//
//  Created by Uriel Ortega on 08/06/23.
//

import SwiftUI

struct ContentView: View {
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
            
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                users = decodedResponse
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
