//
//  CoreDataManager.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/19/25.
//

import Foundation
import CoreData

final class CoreDataManager: ObservableObject {
    let container: NSPersistentContainer = NSPersistentContainer(name: "Database")

    init() {
        container.loadPersistentStores { descriptor, error in
            debugPrint(descriptor.url?.absoluteString)
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
