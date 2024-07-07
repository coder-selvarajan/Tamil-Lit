//
//  ImportDBView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 07/07/24.
//
import SwiftUI
import CoreData
import SQLite3

struct ImportDBView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var importStatus: String = "Importing data..."
    @State private var showMainView = false
    
    var body: some View {
        VStack {
            Spacer()
            Text(importStatus)
                .padding()
                .onAppear {
                    importDataFromSQLite()
                }
            Spacer()
            
            Button {
                showMainView = true
            } label: {
                Text("Go to - Home View")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.blue)
                    .cornerRadius(10.0)
            }
            
            
            Spacer()
            
        }
        .fullScreenCover(isPresented: $showMainView) {
            MainView()
        }
    }
    
    private func importDataFromSQLite() {
        guard let dbPath = Bundle.main.path(forResource: "TamilBookDB", ofType: "sqlite") else {
            importStatus = "SQLite file not found."
            return
        }
        
        var db: OpaquePointer?
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
            importBooks(from: db)
            importExplanations(from: db)
            importPoems(from: db)
            importSections(from: db)
            importSubCategories(from: db)
            importMainCategories(from: db)
            
            sqlite3_close(db)
            importStatus = "Data import completed."
        } else {
            importStatus = "Unable to open SQLite database."
            print("Unable to open SQLite database.")
        }
    }
    
    private func importBooks(from db: OpaquePointer?) {
        var queryStatement: OpaquePointer?
        let query = "SELECT id, author, categoryLevel, color, image, info, name, noofpoems, `order`, period FROM ZBOOK;"
        
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = UUID(uuidString: String(cString: sqlite3_column_text(queryStatement, 0)))!
                let author = String(cString: sqlite3_column_text(queryStatement, 1))
                let categoryLevel = Int16(sqlite3_column_int(queryStatement, 2))
                let color = String(cString: sqlite3_column_text(queryStatement, 3))
                let image = String(cString: sqlite3_column_text(queryStatement, 4))
                let info = String(cString: sqlite3_column_text(queryStatement, 5))
                let name = String(cString: sqlite3_column_text(queryStatement, 6))
                let noofpoems = Int16(sqlite3_column_int(queryStatement, 7))
                let order = Int16(sqlite3_column_int(queryStatement, 8))
                let period = String(cString: sqlite3_column_text(queryStatement, 9))
                
                let newBook = Book(context: viewContext)
                newBook.id = id
                newBook.author = author
                newBook.categoryLevel = categoryLevel
                newBook.color = color
                newBook.image = image
                newBook.info = info
                newBook.name = name
                newBook.noofpoems = noofpoems
                newBook.order = order
                newBook.period = period
                
                do {
                    try viewContext.save()
                } catch {
                    importStatus = "Failed to save Book data to Core Data."
                    print("Failed to save Book data to Core Data: \(error.localizedDescription)")
                }
            }
            sqlite3_finalize(queryStatement)
        } else {
            importStatus = "Failed to prepare Book query statement."
            print("Failed to prepare Book query statement: \(String(cString: sqlite3_errmsg(db)))")
        }
    }
    
    private func importExplanations(from db: OpaquePointer?) {
        var queryStatement: OpaquePointer?
        let query = "SELECT id, author, bookname, info, language, meaning, `order`, subtitle, title FROM ZEXPLANATION;"
        
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = UUID(uuidString: String(cString: sqlite3_column_text(queryStatement, 0)))!
                let author = String(cString: sqlite3_column_text(queryStatement, 1))
                let bookname = String(cString: sqlite3_column_text(queryStatement, 2))
                let info = String(cString: sqlite3_column_text(queryStatement, 3))
                let language = String(cString: sqlite3_column_text(queryStatement, 4))
                let meaning = String(cString: sqlite3_column_text(queryStatement, 5))
                let order = Int16(sqlite3_column_int(queryStatement, 6))
                let subtitle = String(cString: sqlite3_column_text(queryStatement, 7))
                let title = String(cString: sqlite3_column_text(queryStatement, 8))
                
                let newExplanation = Explanation(context: viewContext)
                newExplanation.id = id
                newExplanation.author = author
                newExplanation.bookname = bookname
                newExplanation.info = info
                newExplanation.language = language
                newExplanation.meaning = meaning
                newExplanation.order = order
                newExplanation.subtitle = subtitle
                newExplanation.title = title
                
                do {
                    try viewContext.save()
                } catch {
                    importStatus = "Failed to save Explanation data to Core Data."
                    print("Failed to save Explanation data to Core Data: \(error.localizedDescription)")
                }
            }
            sqlite3_finalize(queryStatement)
        } else {
            importStatus = "Failed to prepare Explanation query statement."
            print("Failed to prepare Explanation query statement: \(String(cString: sqlite3_errmsg(db)))")
        }
    }
    
    private func importPoems(from db: OpaquePointer?) {
        var queryStatement: OpaquePointer?
        let query = "SELECT id, bookname, number, poem, poeminfo, title, transliteration, type FROM ZPOEM;"
        
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = UUID(uuidString: String(cString: sqlite3_column_text(queryStatement, 0)))!
                let bookname = String(cString: sqlite3_column_text(queryStatement, 1))
                let number = Int16(sqlite3_column_int(queryStatement, 2))
                let poem = String(cString: sqlite3_column_text(queryStatement, 3))
                let poeminfo = String(cString: sqlite3_column_text(queryStatement, 4))
                let title = String(cString: sqlite3_column_text(queryStatement, 5))
                let transliteration = String(cString: sqlite3_column_text(queryStatement, 6))
                let type = String(cString: sqlite3_column_text(queryStatement, 7))
                
                let newPoem = Poem(context: viewContext)
                newPoem.id = id
                newPoem.bookname = bookname
                newPoem.number = number
                newPoem.poem = poem
                newPoem.poeminfo = poeminfo
                newPoem.title = title
                newPoem.transliteration = transliteration
                newPoem.type = type
                
                // Setting relationships
                if let book = fetchBook(by: bookname) {
                    newPoem.book = book
                    book.addToPoems(newPoem)
                }
                
                do {
                    try viewContext.save()
                } catch {
                    importStatus = "Failed to save Poem data to Core Data."
                    print("Failed to save Poem data to Core Data: \(error.localizedDescription)")
                }
            }
            sqlite3_finalize(queryStatement)
        } else {
            importStatus = "Failed to prepare Poem query statement."
            print("Failed to prepare Poem query statement: \(String(cString: sqlite3_errmsg(db)))")
        }
    }
    
    private func importSections(from db: OpaquePointer?) {
        var queryStatement: OpaquePointer?
        let query = "SELECT id, bookname, groupname, info, number, start, end, title, subtitle FROM ZSECTION;"
        
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = UUID(uuidString: String(cString: sqlite3_column_text(queryStatement, 0)))!
                let bookname = String(cString: sqlite3_column_text(queryStatement, 1))
                let groupname = String(cString: sqlite3_column_text(queryStatement, 2))
                let info = String(cString: sqlite3_column_text(queryStatement, 3))
                let number = Int16(sqlite3_column_int(queryStatement, 4))
                let start = Int16(sqlite3_column_int(queryStatement, 5))
                let end = Int16(sqlite3_column_int(queryStatement, 6))
                let title = String(cString: sqlite3_column_text(queryStatement, 7))
                let subtitle = String(cString: sqlite3_column_text(queryStatement, 8))
                
                let newSection = Section(context: viewContext)
                newSection.id = id
                newSection.bookname = bookname
                newSection.groupname = groupname
                newSection.info = info
                newSection.number = number
                newSection.start = start
                newSection.end = end
                newSection.title = title
                newSection.subtitle = subtitle
                
                // Setting relationships
                if let subCategory = fetchSubCategory(by: bookname) {
                    newSection.subCategory = subCategory
                    subCategory.addToSections(newSection)
                }
                
                do {
                    try viewContext.save()
                } catch {
                    importStatus = "Failed to save Section data to Core Data."
                    print("Failed to save Section data to Core Data: \(error.localizedDescription)")
                }
            }
            sqlite3_finalize(queryStatement)
        } else {
            importStatus = "Failed to prepare Section query statement."
            print("Failed to prepare Section query statement: \(String(cString: sqlite3_errmsg(db)))")
        }
    }
    
    private func importSubCategories(from db: OpaquePointer?) {
        var queryStatement: OpaquePointer?
        let query = "SELECT id, bookname, groupname, info, number, start, end, title, subtitle FROM ZSUBCATEGORY;"
        
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = UUID(uuidString: String(cString: sqlite3_column_text(queryStatement, 0)))!
                let bookname = String(cString: sqlite3_column_text(queryStatement, 1))
                let groupname = String(cString: sqlite3_column_text(queryStatement, 2))
                let info = String(cString: sqlite3_column_text(queryStatement, 3))
                let number = Int16(sqlite3_column_int(queryStatement, 4))
                let start = Int16(sqlite3_column_int(queryStatement, 5))
                let end = Int16(sqlite3_column_int(queryStatement, 6))
                let title = String(cString: sqlite3_column_text(queryStatement, 7))
                let subtitle = String(cString: sqlite3_column_text(queryStatement, 8))
                
                let newSubCategory = SubCategory(context: viewContext)
                newSubCategory.id = id
                newSubCategory.bookname = bookname
                newSubCategory.groupname = groupname
                newSubCategory.info = info
                newSubCategory.number = number
                newSubCategory.start = start
                newSubCategory.end = end
                newSubCategory.title = title
                newSubCategory.subtitle = subtitle
                
                // Setting relationships
                if let mainCategory = fetchMainCategory(by: bookname) {
                    newSubCategory.mainCategory = mainCategory
                    mainCategory.addToSubCategories(newSubCategory)
                }
                
                do {
                    try viewContext.save()
                } catch {
                    importStatus = "Failed to save SubCategory data to Core Data."
                    print("Failed to save SubCategory data to Core Data: \(error.localizedDescription)")
                }
            }
            sqlite3_finalize(queryStatement)
        } else {
            importStatus = "Failed to prepare SubCategory query statement."
            print("Failed to prepare SubCategory query statement: \(String(cString: sqlite3_errmsg(db)))")
        }
    }
    
    private func importMainCategories(from db: OpaquePointer?) {
        var queryStatement: OpaquePointer?
        let query = "SELECT id, bookname, groupname, info, number, start, end, title, subtitle FROM ZMAINCATEGORY;"
        
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = UUID(uuidString: String(cString: sqlite3_column_text(queryStatement, 0)))!
                let bookname = String(cString: sqlite3_column_text(queryStatement, 1))
                let groupname = String(cString: sqlite3_column_text(queryStatement, 2))
                let info = String(cString: sqlite3_column_text(queryStatement, 3))
                let number = Int16(sqlite3_column_int(queryStatement, 4))
                let start = Int16(sqlite3_column_int(queryStatement, 5))
                let end = Int16(sqlite3_column_int(queryStatement, 6))
                let title = String(cString: sqlite3_column_text(queryStatement, 7))
                let subtitle = String(cString: sqlite3_column_text(queryStatement, 8))
                
                let newMainCategory = MainCategory(context: viewContext)
                newMainCategory.id = id
                newMainCategory.bookname = bookname
                newMainCategory.groupname = groupname
                newMainCategory.info = info
                newMainCategory.number = number
                newMainCategory.start = start
                newMainCategory.end = end
                newMainCategory.title = title
                newMainCategory.subtitle = subtitle
                
                // Setting relationships
                if let book = fetchBook(by: bookname) {
                    newMainCategory.book = book
                    book.addToMainCategories(newMainCategory)
                }
                
                do {
                    try viewContext.save()
                } catch {
                    importStatus = "Failed to save MainCategory data to Core Data."
                    print("Failed to save MainCategory data to Core Data: \(error.localizedDescription)")
                }
            }
            sqlite3_finalize(queryStatement)
        } else {
            importStatus = "Failed to prepare MainCategory query statement."
            print("Failed to prepare MainCategory query statement: \(String(cString: sqlite3_errmsg(db)))")
        }
    }
    
    // Helper functions to fetch related entities by name
    private func fetchBook(by name: String) -> Book? {
        let request = Book.fetchRequest() as NSFetchRequest<Book>
        request.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let results = try viewContext.fetch(request)
            return results.first
        } catch {
            print("Failed to fetch Book: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func fetchMainCategory(by name: String) -> MainCategory? {
        let request = MainCategory.fetchRequest() as NSFetchRequest<MainCategory>
        request.predicate = NSPredicate(format: "bookname == %@", name)
        
        do {
            let results = try viewContext.fetch(request)
            return results.first
        } catch {
            print("Failed to fetch MainCategory: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func fetchSubCategory(by name: String) -> SubCategory? {
        let request = SubCategory.fetchRequest() as NSFetchRequest<SubCategory>
        request.predicate = NSPredicate(format: "bookname == %@", name)
        
        do {
            let results = try viewContext.fetch(request)
            return results.first
        } catch {
            print("Failed to fetch SubCategory: \(error.localizedDescription)")
            return nil
        }
    }
}
