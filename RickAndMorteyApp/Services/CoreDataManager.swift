//
//  CoreDataManager.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 29.10.2021.
//

import Foundation
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "RickAndMorteyApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func fetchCharacters() -> [FavoritesCharacter] {
        let fetchRequest: NSFetchRequest<FavoritesCharacter> = FavoritesCharacter.fetchRequest()
        let objects = (try? self.persistentContainer.viewContext.fetch(fetchRequest)) ?? []
        return objects
    }

    func saveCharacter(char: Character) {

        let favoriteCharacter = FavoritesCharacter(context: persistentContainer.viewContext)

        favoriteCharacter.id = Int16(char.id)
        favoriteCharacter.name = char.name
        favoriteCharacter.gender = char.gender
        favoriteCharacter.species = char.species
        favoriteCharacter.status = char.status
        favoriteCharacter.image = char.image
        favoriteCharacter.episode = char.episode as NSObject
        //        favoriteCharacter.location = char.location
        favoriteCharacter.url = char.url

        saveContext()

    }

    func saveEpisode(episode: Episode){
        let favoriteEpisode = FavoritesEpisodes(context: persistentContainer.viewContext)

        favoriteEpisode.name = episode.name
        favoriteEpisode.episode = episode.episode
        favoriteEpisode.date = episode.date
        favoriteEpisode.characters = episode.characters as NSObject
        
        saveContext()
    }

    func fetchEpisodes() -> [FavoritesEpisodes]{
        let fetchRequest: NSFetchRequest<FavoritesEpisodes> = FavoritesEpisodes.fetchRequest()
        let objects = (try? self.persistentContainer.viewContext.fetch(fetchRequest)) ?? []
        return objects
    }

    func saveLocation(location: Location) {
        let favoriteLocation = FavoritesLocation(context: persistentContainer.viewContext)

        favoriteLocation.name = location.name
        favoriteLocation.created = location.created
        favoriteLocation.dimension = location.dimension
        favoriteLocation.url = location.url
        favoriteLocation.type = location.type

        saveContext()

    }

    func fetchLocations() -> [FavoritesLocation] {
        let fetchRequest: NSFetchRequest<FavoritesLocation> = FavoritesLocation.fetchRequest()
        let objects = (try? self.persistentContainer.viewContext.fetch(fetchRequest)) ?? []
        return objects
    }

    func setTimerCount(count: Int64) {

        let fetchRequest: NSFetchRequest<TimerCount> = TimerCount.fetchRequest()
        let objects = (try? self.persistentContainer.viewContext.fetch(fetchRequest)) ?? []

        if objects.isEmpty {
            let timers = NSEntityDescription.insertNewObject(forEntityName: "TimerCount", into: self.persistentContainer.viewContext)
            timers.setValue(count, forKey: "timerCount")
        } else {
            objects.first?.timerCount = count
        }

        saveContext()
    }

    func fetchTimerCount() -> Int64 {
        let fetchRequest: NSFetchRequest<TimerCount> = TimerCount.fetchRequest()
        let objects = (try? self.persistentContainer.viewContext.fetch(fetchRequest)) ?? []

        return objects.first?.timerCount ?? 0

    }

    func deleteCharacter(index: Int){
        let fetchRequest: NSFetchRequest<FavoritesCharacter> = FavoritesCharacter.fetchRequest()
        let objects = (try? self.persistentContainer.viewContext.fetch(fetchRequest)) ?? []
        print(objects)
        self.persistentContainer.viewContext.delete(objects[index])
        saveContext()
    }

    func deleteLocation(index: Int){
        let fetchRequest: NSFetchRequest<FavoritesLocation> = FavoritesLocation.fetchRequest()
        let objects = (try? self.persistentContainer.viewContext.fetch(fetchRequest)) ?? []
        print(objects)
        self.persistentContainer.viewContext.delete(objects[index])
        saveContext()
    }

    func deleteEpisode(index: Int){
        let fetchRequest: NSFetchRequest<FavoritesEpisodes> = FavoritesEpisodes.fetchRequest()
        let objects = (try? self.persistentContainer.viewContext.fetch(fetchRequest)) ?? []
        print(objects)
        self.persistentContainer.viewContext.delete(objects[index])
        saveContext()
    }

    func addMarker(latitude: Double, lontitude: Double) {
        let marker = Marker(context: persistentContainer.viewContext)
        marker.latitude = latitude
        marker.longtitude = lontitude

        saveContext()

    }

    func fetchMarkers() -> [Marker] {
        let fetchRequest: NSFetchRequest<Marker> = Marker.fetchRequest()
        let objects = (try? self.persistentContainer.viewContext.fetch(fetchRequest)) ?? []
        return objects
    }

    func saveContext () {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
