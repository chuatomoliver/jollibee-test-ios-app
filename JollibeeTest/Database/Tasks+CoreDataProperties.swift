//
//  Tasks+CoreDataProperties.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/19/25.
//
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var task_name: String?
    @NSManaged public var company_for: String?
    @NSManaged public var status: String?

}

extension Tasks : Identifiable {

}
