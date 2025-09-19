import Foundation
import CoreData

extension NSManagedObjectContext {
    /**
     Generates the next available auto-incrementing ID for a specific `NSManagedObject` subclass.

     This function fetches the entity with the highest ID value and returns that value plus one.
     If no entities are found, it returns `1`.

     - Parameters:
       - entityType: The `NSManagedObject` subclass to fetch from (e.g., `Tasks.self`).
       - idKey: The key for the ID attribute (e.g., "id").

     - Returns: The next available `Int64` ID.
     */
    func getNextAutoIncrementId<T: NSManagedObject>(for entityType: T.Type, idKey: String) -> Int64 {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entityType))
        let sortDescriptor = NSSortDescriptor(key: idKey, ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchLimit = 1

        do {
            let results = try self.fetch(fetchRequest)
            // Use key-value coding to safely get the ID from the fetched object
            if let lastObject = results.first,
               let maxId = lastObject.value(forKey: idKey) as? Int64 {
                return maxId + 1
            } else {
                return 1
            }
        } catch {
            print("Error fetching max ID for \(String(describing: entityType)): \(error)")
            return 1
        }
    }
}
