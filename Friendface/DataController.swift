//
//  DataController.swift
//  Friendface
//
//  Created by Uriel Ortega on 12/06/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    // This container prepares CoreData to load the data in Friendface datamodel.
    let container = NSPersistentContainer(name: "Friendface") // This means: Use Friendface.xcdatamodel
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        }
    }
}
