import CoreData

struct PersistenceController {
    // The shared singleton instance of the persistence controller
    static let shared = PersistenceController()

    // The NSPersistentContainer, which encapsulates the Core Data stack
    let container: NSPersistentContainer

    // The initializer for the persistence controller
    init(inMemory: Bool = false) {
        // Create the container, which loads the data model
        container = NSPersistentContainer(name: "jollibee-test-app") // 1

        // If 'inMemory' is true, use a temporary in-memory store for testing
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        // Load the persistent stores
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Handle the error gracefully
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        // Automatically merge changes from the parent context
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // MARK: - Core Data Saving support

    // A function to save the Core Data context if there are changes
    static func saveContext() {
        let context = shared.container.viewContext
        // Check if there are pending changes to save
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Handle the error appropriately
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
