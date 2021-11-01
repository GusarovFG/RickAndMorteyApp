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

    func fetchContextTimer() -> FavoritesCharacter?{
        let chars = FavoritesCharacter()
        let fetchRequest: NSFetchRequest<FavoritesCharacter> = FavoritesCharacter.fetchRequest()

        do {
            let chars = try self.persistentContainer.viewContext.fetch(fetchRequest)
            print(chars)
        } catch {
            let error = error as NSError
            print(error)
        }
        return chars
    }

    func fetchCharacters() -> [FavoritesCharacter] {
        let fetchRequest: NSFetchRequest<FavoritesCharacter> = FavoritesCharacter.fetchRequest()
        let objects = (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
        return objects
    }

    func insertInEntity(char: Character){

        guard let entity = NSEntityDescription.entity(forEntityName: "FavoritesCharacter", in: persistentContainer.viewContext) else { return }
        let favChar = FavoritesCharacter(entity: entity, insertInto: persistentContainer.viewContext)
        favChar.id = Int16(char.id)
        favChar.name = char.name
        favChar.gender = char.gender
        favChar.species = char.species
        favChar.status = char.status
        favChar.image = char.image

        saveContext()
    }

    func delete(entity: String){
        guard let entity = NSEntityDescription.entity(forEntityName: entity, in: persistentContainer.viewContext) else { return }
        let favChar = FavoritesCharacter(entity: entity, insertInto: persistentContainer.viewContext)
        persistentContainer.viewContext.delete(favChar)
        saveContext()
    }

    func saveContext () {
        let context = persistentContainer.viewContext
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
