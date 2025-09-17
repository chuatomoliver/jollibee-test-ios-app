//
//  People+CoreDataProperties.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/18/25.
//
//

import Foundation
import CoreData


extension People {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<People> {
        return NSFetchRequest<People>(entityName: "People")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var business: String?
    @NSManaged public var tags: String?

}

extension People : Identifiable {

}
