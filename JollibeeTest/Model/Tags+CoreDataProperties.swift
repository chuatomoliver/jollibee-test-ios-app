//
//  Tags+CoreDataProperties.swift
//  JollibeeTest
//
//  Created by Tom Chua on 9/21/25.
//
//

import Foundation
import CoreData


extension Tags {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tags> {
        return NSFetchRequest<Tags>(entityName: "Tags")
    }

    @NSManaged public var id: Int64
    @NSManaged public var tagName: String?

}

extension Tags : Identifiable {

}
