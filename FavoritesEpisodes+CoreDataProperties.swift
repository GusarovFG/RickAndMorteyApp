//
//  FavoritesEpisodes+CoreDataProperties.swift
//  
//
//  Created by Фаддей Гусаров on 31.10.2021.
//
//

import Foundation
import CoreData


extension FavoritesEpisodes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritesEpisodes> {
        return NSFetchRequest<FavoritesEpisodes>(entityName: "FavoritesEpisodes")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: String?
    @NSManaged public var episode: String?
    @NSManaged public var characters: [FavoritesCharacter]

}
