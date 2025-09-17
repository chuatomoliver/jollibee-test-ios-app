//
//  PersistenceController.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/17/25.
//

import Foundation
import CoreData

struct PersistenceController {
    // A singleton instance to access the persistence controller throughout the app.
    static let shared = PersistenceController()

    // The persistent container for your Core Data database.
    let container: NSPersistentContainer

    init() {
        // Initialize the container with the name of your Core Data model file.
        // The name "JollibeeTest" should match the name of your .xcdatamodeld file.
        container = NSPersistentContainer(name: "JollibeeTest")
        
        // Load the persistent stores.
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                // Handle the error appropriately, for example, by logging it.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    // A function to save changes to the Core Data context.
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
