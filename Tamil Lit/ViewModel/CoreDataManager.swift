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
    
    
    init() {
        persistentContainer = NSPersistentContainer(name: "TamilLitDB") // Use the name of your Core Data model
        
        let description = persistentContainer.persistentStoreDescriptions.first
        
        // Ensure the URL for the existing database
        if let url = existingDatabaseURL() {
            description?.url = url
        } else {
            fatalError("Failed to locate the existing SQLite database.")
        }
        
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        
        CoreDataManager.printCoreDataStoreURL()
    }
    
    private func existingDatabaseURL() -> URL? {
        let fileManager = FileManager.default
        let appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let persistentStoreURL = appSupportURL.appendingPathComponent("TamilLitDB.sqlite") // Ensure the path matches your existing database
        
        if fileManager.fileExists(atPath: persistentStoreURL.path) {
            return persistentStoreURL
        } else {
            // Attempt to copy from the bundle
            if let bundleURL = Bundle.main.url(forResource: "TamilLitDB", withExtension: "sqlite") {
                do {
                    try fileManager.createDirectory(at: appSupportURL, withIntermediateDirectories: true, attributes: nil)
                    try fileManager.copyItem(at: bundleURL, to: persistentStoreURL)
                    
                    // Copy -wal and -shm files if they exist
                    if let walURL = Bundle.main.url(forResource: "TamilLitDB", withExtension: "sqlite-wal") {
                        let destinationURL = appSupportURL.appendingPathComponent("TamilLitDB.sqlite-wal")
                        try fileManager.copyItem(at: walURL, to: destinationURL)
                    }
                    if let shmURL = Bundle.main.url(forResource: "TamilLitDB", withExtension: "sqlite-shm") {
                        let destinationURL = appSupportURL.appendingPathComponent("TamilLitDB.sqlite-shm")
                        try fileManager.copyItem(at: shmURL, to: destinationURL)
                    }
                    
                    return persistentStoreURL
                } catch {
                    fatalError("Error copying SQLite database: \(error)")
                }
            }
        }
        return nil
    }
    
    /*
    init() {
        persistentContainer = NSPersistentContainer(name: "TamilLitDB")
        
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.url = existingDatabaseURL()
        
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        CoreDataManager.printCoreDataStoreURL()
    }
    
    private func existingDatabaseURL() -> URL? {
        let fileManager = FileManager.default
        let appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let persistentStoreURL = appSupportURL.appendingPathComponent("TamilBookDB.sqlite") // Ensure the path matches your existing database
        
        if fileManager.fileExists(atPath: persistentStoreURL.path) {
            return persistentStoreURL
        } else {
            // Copy the existing database from the bundle to the documents directory if it doesn't exist
            if let bundleURL = Bundle.main.url(forResource: "TamilLitDB", withExtension: "sqlite") {
                do {
                    try fileManager.copyItem(at: bundleURL, to: persistentStoreURL)
                    return persistentStoreURL
                } catch {
                    fatalError("Error copying SQLite database: \(error)")
                }
            }
        }
        return nil
    }
    */
    
    /*
    private init() {
        persistentContainer = NSPersistentContainer(name: "TamilLitDB")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        CoreDataManager.printCoreDataStoreURL()
    }
    */

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
    
    func fetchPoemsBySection(_ section: Section) -> [Poem] {
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
    
    func fetchPoemsByCategory(_ category: MainCategory) -> [Poem] {
        let fetchRequest: NSFetchRequest<Poem> = Poem.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "number", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "mainCategory == %@", category)
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

extension CoreDataManager {
    func fetchBook(for bookname: String) -> Book? {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", bookname)
        do {
            return try viewContext.fetch(fetchRequest).first!
        } catch {
            print("Error fetching book info: \(error)")
        }
        
        return nil
    }
    
    func fetchMainCategories(for bookname: String) -> [MainCategory] {
        let fetchRequest: NSFetchRequest<MainCategory> = MainCategory.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "number", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "bookname == %@", bookname)
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching main categories: \(error)")
            return []
        }
    }

    func fetchAllSubCategories(for bookname: String) -> [SubCategory] {
        let fetchRequest: NSFetchRequest<SubCategory> = SubCategory.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "number", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "bookname == %@", bookname)
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching subcategories: \(error)")
            return []
        }
    }

    func fetchAllSections(for bookname: String) -> [Section] {
        let fetchRequest: NSFetchRequest<Section> = Section.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "number", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "bookname == %@", bookname)
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching sections: \(error)")
            return []
        }
    }

    func fetchAllPoems(for bookname: String) -> [Poem] {
        let fetchRequest: NSFetchRequest<Poem> = Poem.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "number", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "book.name == %@", bookname)
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching poems: \(error)")
            return []
        }
    }
}
