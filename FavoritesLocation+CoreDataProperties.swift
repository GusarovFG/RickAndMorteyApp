//
//  FavoritesLocation+CoreDataProperties.swift
//  
//
//  Created by Фаддей Гусаров on 31.10.2021.
//
//

import Foundation
import CoreData


extension FavoritesLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritesLocation> {
        return NSFetchRequest<FavoritesLocation>(entityName: "FavoritesLocation")
    }

    @NSManaged public var name: String?

}
