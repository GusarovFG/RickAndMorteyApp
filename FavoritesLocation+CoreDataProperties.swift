//
//  FavoritesLocation+CoreDataProperties.swift
//  
//
//  Created by Фаддей Гусаров on 05.11.2021.
//
//

import Foundation
import CoreData


extension FavoritesLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritesLocation> {
        return NSFetchRequest<FavoritesLocation>(entityName: "FavoritesLocation")
    }

    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var dimension: String?
    @NSManaged public var residents: [String]?
    @NSManaged public var url: String?
    @NSManaged public var created: String?

}
