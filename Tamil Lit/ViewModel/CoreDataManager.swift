//
//  CoreDataManager.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//

import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer

    static func printCoreDataStoreURL() {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        if let applicationSupportDirectory = urls.last {
            let storeURL = applicationSupportDirectory.appendingPathComponent("TamilLitDB.sqlite")
            print("Core Data Store URL: \(storeURL)")
        }
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "TamilLitDB")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        CoreDataManager.printCoreDataStoreURL()
    }

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func fetchMainCategories() -> [MainCategory] {
        let fetchRequest: NSFetchRequest<MainCategory> = MainCategory.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "number", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching main categories: \(error)")
            return []
        }
    }
    
    func fetchSubCategories(for mainCategory: MainCategory) -> [SubCategory] {
        let fetchRequest: NSFetchRequest<SubCategory> = SubCategory.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "number", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "mainCategory == %@", mainCategory)
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching sub categories: \(error)")
            return []
        }
    }
    
    func fetchSections(for subCategory: SubCategory) -> [Section] {
        let fetchRequest: NSFetchRequest<Section> = Section.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "number", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "subCategory == %@", subCategory)
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching sections: \(error)")
            return []
        }
    }
    
    func fetchPoems(for section: Section) -> [Poem] {
        let fetchRequest: NSFetchRequest<Poem> = Poem.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "number", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "section == %@", section)
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching poems: \(error)")
            return []
        }
    }
    
    func fetchExplanations(for poem: Poem) -> [Explanation] {
        let fetchRequest: NSFetchRequest<Explanation> = Explanation.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "order", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "poem == %@", poem)
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching explanations: \(error)")
            return []
        }
    }
}
