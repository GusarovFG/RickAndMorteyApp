//
//  Marker+CoreDataProperties.swift
//  
//
//  Created by Фаддей Гусаров on 05.11.2021.
//
//

import Foundation
import CoreData


extension Marker {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Marker> {
        return NSFetchRequest<Marker>(entityName: "Marker")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longtitude: Double

}
