//
//  FavoritesCharacter+CoreDataProperties.swift
//  
//
//  Created by Фаддей Гусаров on 31.10.2021.
//
//

import Foundation
import CoreData


extension FavoritesCharacter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritesCharacter> {
        return NSFetchRequest<FavoritesCharacter>(entityName: "FavoritesCharacter")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var status: String?
    @NSManaged public var species: String?
    @NSManaged public var gender: String?
    @NSManaged public var image: String?

}
