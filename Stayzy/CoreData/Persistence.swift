//
//  Persistence.swift
//  DigiHunt
//
//  Created by Sahil ChowKekar on 3/10/25.
//

import Foundation
import CoreData

// A singleton class to manage Core Data stack with iCloud support using NSPersistentCloudKitContainer
struct PersistenceController{
    static let shared = PersistenceController()
    
    
    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        // Initialize the container with the name of the data model file (LocalStorage.xcdatamodeld)
        container = NSPersistentCloudKitContainer(name: "LocalStorage")
        if inMemory {
            
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        // Load the persistent stores (backed by SQLite and optionally synced with iCloud)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
