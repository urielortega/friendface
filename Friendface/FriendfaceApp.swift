//
//  FriendfaceApp.swift
//  Friendface
//
//  Created by Uriel Ortega on 08/06/23.
//

import SwiftUI

@main
struct FriendfaceApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext) // Injecting dataController into the environment.
        }
    }
}
