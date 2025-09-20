//
//  Category+CoreDataProperties.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/21/25.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: Int64
    @NSManaged public var categoryName: String?

}

extension Category : Identifiable {

}
