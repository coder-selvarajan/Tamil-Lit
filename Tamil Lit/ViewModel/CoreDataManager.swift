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
        persistentContainer = NSPersistentContainer(name: "TamilLitDB")
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
    
    func fetchPoemsByBook(_ bookName: String) -> [Poem] {
        let fetchRequest: NSFetchRequest<Poem> = Poem.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "number", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "bookname == %@", bookName)
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching poems: \(error)")
            return []
        }
    }
    
    func fetchPoemByBookNumber(_ bookName: String, _ number: Int) -> Poem? {
        let fetchRequest: NSFetchRequest<Poem> = Poem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "bookname == %@ AND number == %d", bookName, number)
        
        do {
            return try viewContext.fetch(fetchRequest).first
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
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
    
    func fetchAllFavPoems(excludingBookNames excludedBookNames: [String]) -> [FavouritePoem] {
        let fetchRequest: NSFetchRequest<FavouritePoem> = FavouritePoem.fetchRequest()
        
        if !excludedBookNames.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "NOT (bookname IN %@)", excludedBookNames)
        }
        
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching poems: \(error)")
            return []
        }
    }
    
    func fetchFavPoemsByBook(for bookname: String) -> [FavouritePoem] {
        let fetchRequest: NSFetchRequest<FavouritePoem> = FavouritePoem.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "book.name == %@", bookname)
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching poems: \(error)")
            return []
        }
    }
    
    func isPoemBookmarked(bookname: String, number: Int) -> Bool {
        let fetchRequest: NSFetchRequest<FavouritePoem> = FavouritePoem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "bookname == %@ AND number == %d", bookname, number)
        
        do {
            let existingPoems = try viewContext.fetch(fetchRequest)
            return !existingPoems.isEmpty
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func randomDateWithinLastFiveDays() -> Date {
        let now = Date()
        let dayInSeconds: TimeInterval = 24 * 60 * 60
        let randomInterval = TimeInterval(arc4random_uniform(5)) * dayInSeconds
        let randomDate = now.addingTimeInterval(-randomInterval)
        return randomDate
    }
    
    func saveFavPoem(bookname: String, number: Int16,
                     poem: String, title: String,
                     mainCategory: String, subCategory: String, section: String) -> Bool {
        
        // Create a new Poem entity
        let entity = NSEntityDescription.entity(forEntityName: "FavouritePoem", in: viewContext)!
        let favPoem = NSManagedObject(entity: entity, insertInto: viewContext)
        
        // Set the attributes
        favPoem.setValue(UUID(), forKey: "id")
        favPoem.setValue(bookname, forKeyPath: "bookname")
        favPoem.setValue(number, forKey: "number")
        favPoem.setValue(poem, forKey: "poem")
        favPoem.setValue(title, forKey: "title")
        favPoem.setValue(mainCategory, forKey: "maincategoryname")
        favPoem.setValue(subCategory, forKey: "subcategoryname")
        favPoem.setValue(section, forKey: "sectionname")
//        favPoem.setValue(Date(), forKey: "timestamp")
        
        let randomDate = randomDateWithinLastFiveDays()
        favPoem.setValue(randomDate, forKey: "timestamp")
        
        // Save the context
        do {
            try viewContext.save()
            print("Poem bookmarked successfully")
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func removeFavPoem(bookname: String, number: Int16) -> Bool {
        let fetchRequest: NSFetchRequest<FavouritePoem> = FavouritePoem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "bookname == %@ AND number == %d", bookname, number)
        
        do {
            let existingPoems = try viewContext.fetch(fetchRequest)
            if let poemToDelete = existingPoems.first {
                viewContext.delete(poemToDelete)
                try viewContext.save()
                print("Poem removed from favorites successfully")
                return true
            } else {
                print("Poem not found in favorites")
                return false
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func performSearch(searchText: String, excludingBookNames excludedBookNames: [String]) -> [Poem] {
        let request: NSFetchRequest<Poem> = Poem.fetchRequest()
        
        // Create predicates for searching in poem and title
        let poemPredicate = NSPredicate(format: "poem CONTAINS[cd] %@", searchText)
        let titlePredicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        let searchPredicates = NSCompoundPredicate(orPredicateWithSubpredicates: [poemPredicate, titlePredicate])
        
        // let meaningPredicate = NSPredicate(format: "ANY explanations.meaning CONTAINS[cd] %@", searchText)
        // request.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [searchPredicates, meaningPredicate])
        
        // Create the exclusion predicate if the array is not empty
        if !excludedBookNames.isEmpty {
            let excludedPredicate = NSPredicate(format: "NOT (bookname IN %@)", excludedBookNames)
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [searchPredicates, excludedPredicate])
        } else {
            request.predicate = searchPredicates
        }
        
        // Sort by bookname
        request.sortDescriptors = [NSSortDescriptor(key: "bookname", ascending: true)]
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Failed to fetch data: \(error)")
        }
        
        return []
    }
    
    func fetchRandomPoem(excludingBookNames excludedBookNames: [String]) -> Poem? {
        let request: NSFetchRequest<Poem> = Poem.fetchRequest()
        request.fetchLimit = 1

        // Create the count request
        let countRequest: NSFetchRequest<NSNumber> = NSFetchRequest<NSNumber>(entityName: "Poem")
        countRequest.resultType = .countResultType

        // Add predicate to exclude specific book names if the array is not empty
        if !excludedBookNames.isEmpty {
            let excludedPredicate = NSPredicate(format: "NOT (bookname IN %@)", excludedBookNames)
            request.predicate = excludedPredicate
            countRequest.predicate = excludedPredicate
        }

        do {
            let count = try viewContext.count(for: countRequest)
            if count > 0 {
                let randomOffset = Int.random(in: 0..<count)
                request.fetchOffset = randomOffset
                if let randomPoem = try viewContext.fetch(request).first {
                    return randomPoem
                }
            }
        } catch {
            print("Failed to fetch random poem: \(error)")
        }

        return nil
    }
    
    func fetchDailyPoem(for date: Date, includingBookNames: [String]) -> Poem? {
        let calendar = Calendar.current
        let targetDate = calendar.startOfDay(for: date)

        // Check if there's already a DailyPoem for the target date
        let dailyPoemRequest: NSFetchRequest<DailyPoem> = DailyPoem.fetchRequest()
        dailyPoemRequest.predicate = NSPredicate(format: "date == %@", targetDate as NSDate)

        do {
            let todayPoems = try viewContext.fetch(dailyPoemRequest)
            if let todayPoem = todayPoems.first {
                // If there's already a DailyPoem for the target date, return the corresponding Poem
                let poemRequest: NSFetchRequest<Poem> = Poem.fetchRequest()
                poemRequest.predicate = NSPredicate(format: "bookname == %@ AND number == %d", todayPoem.bookname ?? "", todayPoem.number)
                return try viewContext.fetch(poemRequest).first
            } else {
                // Fetch all poems for the given book names
                let request: NSFetchRequest<Poem> = Poem.fetchRequest()
                request.predicate = NSPredicate(format: "bookname IN %@", includingBookNames)

                let allPoems = try viewContext.fetch(request)

                // Fetch all the DailyPoem entries
                let dailyPoems = try viewContext.fetch(NSFetchRequest<DailyPoem>(entityName: "DailyPoem"))
                let dailyPoemIdentifiers = Set(dailyPoems.map { PoemIdentifier(bookname: $0.bookname ?? "", number: $0.number) })

                // Filter out poems that are already in DailyPoem table
                let filteredPoems = allPoems.filter { !dailyPoemIdentifiers.contains(PoemIdentifier(bookname: $0.bookname ?? "", number: $0.number)) }

                // If there are any poems left, pick a random one
                if let randomPoem = filteredPoems.randomElement() {
                    // Create a new DailyPoem entry with the target date
                    let newDailyPoem = DailyPoem(context: viewContext)
                    newDailyPoem.bookname = randomPoem.bookname
                    newDailyPoem.number = randomPoem.number
                    newDailyPoem.date = targetDate
                    newDailyPoem.id = UUID()
                    newDailyPoem.category = randomPoem.maincategoryname
                    newDailyPoem.poem = randomPoem.poem

                    // Save the context
                    try viewContext.save()

                    return randomPoem
                }
            }
        } catch {
            print("Failed to fetch random poem: \(error)")
        }

        return nil
    }
    
    func fetchMinimumDateInDailyPoem() -> Date? {
        let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "DailyPoem")
        fetchRequest.resultType = .dictionaryResultType

        // Use expression description to get the minimum date
        let minDateExpression = NSExpressionDescription()
        minDateExpression.name = "minDate"
        minDateExpression.expression = NSExpression(forFunction: "min:", arguments: [NSExpression(forKeyPath: "date")])
        minDateExpression.expressionResultType = .dateAttributeType

        fetchRequest.propertiesToFetch = [minDateExpression]

        do {
            if let result = try viewContext.fetch(fetchRequest).first,
               let minDate = result["minDate"] as? Date {
                return minDate
            }
        } catch {
            print("Failed to fetch minimum date: \(error)")
        }

        return nil
    }

    // Update poem viewed status
    func updatePoemViewedStatus(for poem: Poem) {
        viewContext.performAndWait {
            poem.viewed = true
            poem.lastUpdated = Date()
            do {
                try viewContext.save()
                print("poem viewed")
            } catch {
                print("Failed to update viewed status: \(error)")
            }
        }
    }
    
    //Fetch last 5 viewed records
    func fetchLastThreeViewedPoems() -> [Poem] {
        let fetchRequest: NSFetchRequest<Poem> = Poem.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "viewed == %@", NSNumber(value: true))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "lastUpdated", ascending: false)]
        fetchRequest.fetchLimit = 3
        
        do {
            let poems = try viewContext.fetch(fetchRequest)
            return poems
        } catch let error as NSError {
            print("Could not fetch last five viewed poems. \(error), \(error.userInfo)")
            return []
        }
    }
    
    //Fetch last 100 viewed records
    func fetchLastHundredViewedPoems() -> [Poem] {
        let fetchRequest: NSFetchRequest<Poem> = Poem.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "viewed == %@", NSNumber(value: true))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "lastUpdated", ascending: false)]
        fetchRequest.fetchLimit = 100
        
        do {
            let poems = try viewContext.fetch(fetchRequest)
            return poems
        } catch let error as NSError {
            print("Could not fetch last five viewed poems. \(error), \(error.userInfo)")
            return []
        }
    }
    
    
    //fetch book viewed summary
    func fetchBookViewedSummary() -> [BookViewedSummary] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Poem")
        
        // Set up properties to fetch
        let booknameExpression = NSExpression(forKeyPath: "bookname")
        let countExpression = NSExpression(forFunction: "count:", arguments: [NSExpression(forKeyPath: "bookname")])
        let viewedSumExpression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "viewed")])
        
        // Create expression descriptions
        let booknameDescription = NSExpressionDescription()
        booknameDescription.name = "bookname"
        booknameDescription.expression = booknameExpression
        booknameDescription.expressionResultType = .stringAttributeType
        
        let countDescription = NSExpressionDescription()
        countDescription.name = "totalRecords"
        countDescription.expression = countExpression
        countDescription.expressionResultType = .integer32AttributeType
        
        let viewedSumDescription = NSExpressionDescription()
        viewedSumDescription.name = "viewedCount"
        viewedSumDescription.expression = viewedSumExpression
        viewedSumDescription.expressionResultType = .integer32AttributeType
        
        // Add expressions to fetch request
        fetchRequest.propertiesToFetch = [booknameDescription, countDescription, viewedSumDescription]
        fetchRequest.resultType = .dictionaryResultType
        fetchRequest.propertiesToGroupBy = ["bookname"]
        
        do {
            let results = try viewContext.fetch(fetchRequest) as! [[String: Any]]
            return results.compactMap { dictionary in
                if let bookname = dictionary["bookname"] as? String,
                   let totalRecords = dictionary["totalRecords"] as? Int,
                   let viewedCount = dictionary["viewedCount"] as? Int {
                    return BookViewedSummary(bookname: bookname, totalRecords: totalRecords, viewedCount: viewedCount)
                }
                return nil
            }
        } catch {
            print("Failed to fetch book viewed summary: \(error)")
            return []
        }
    }
    
    func fetchPoemsByBookandCategoryNames(bookName: String, mainCategory: String, subCategory: String, section: String) -> [Poem] {
        let fetchRequest: NSFetchRequest<Poem> = Poem.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "number", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if section != "" {
            fetchRequest.predicate = NSPredicate(format: "bookname == %@ AND maincategoryname == %@ AND subcategoryname == %@ AND sectionname == %@",
                                                 bookName, mainCategory, subCategory, section)
        } else {
            fetchRequest.predicate = NSPredicate(format: "bookname == %@ AND maincategoryname == %@", bookName, mainCategory)
        }
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching poems: \(error)")
            return []
        }
    }

}

struct PoemIdentifier: Hashable {
    let bookname: String
    let number: Int16
}

struct BookViewedSummary {
    let bookname: String
    let totalRecords: Int
    let viewedCount: Int
}
