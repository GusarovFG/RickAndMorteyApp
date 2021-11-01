//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by Фаддей Гусаров on 29.10.2021.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var timerCount: Int16 = 0

}
