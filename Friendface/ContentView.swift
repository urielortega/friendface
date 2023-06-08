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
            List(users) { user in
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    Text(user.isActive ? "Online 👋🏼" : "Offline 💤")
                }
                .padding(3)
            }
            .navigationTitle("Friendface")
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        // Creating the URL we want to read.
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
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
