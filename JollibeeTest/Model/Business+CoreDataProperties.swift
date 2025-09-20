//
//  Business+CoreDataProperties.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/21/25.
//
//

import Foundation
import CoreData


extension Business {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Business> {
        return NSFetchRequest<Business>(entityName: "Business")
    }

    @NSManaged public var id: Int64
    @NSManaged public var businessName: String?
    @NSManaged public var businessEmail: String?
    @NSManaged public var categories: String?
    @NSManaged public var tags: String?

}

extension Business : Identifiable {

}
