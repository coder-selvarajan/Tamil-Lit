//
//  Book+CoreDataProperties.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var author: String?
    @NSManaged public var color: String?
    @NSManaged public var id: UUID?
    @NSManaged public var image: String?
    @NSManaged public var info: String?
    @NSManaged public var name: String?
    @NSManaged public var noofpoems: Int16
    @NSManaged public var order: Int16
    @NSManaged public var period: String?
    @NSManaged public var mainCategories: NSSet?
    @NSManaged public var poems: NSSet?

}

// MARK: Generated accessors for mainCategories
extension Book {

    @objc(addMainCategoriesObject:)
    @NSManaged public func addToMainCategories(_ value: MainCategory)

    @objc(removeMainCategoriesObject:)
    @NSManaged public func removeFromMainCategories(_ value: MainCategory)

    @objc(addMainCategories:)
    @NSManaged public func addToMainCategories(_ values: NSSet)

    @objc(removeMainCategories:)
    @NSManaged public func removeFromMainCategories(_ values: NSSet)

}

// MARK: Generated accessors for poems
extension Book {

    @objc(addPoemsObject:)
    @NSManaged public func addToPoems(_ value: Poem)

    @objc(removePoemsObject:)
    @NSManaged public func removeFromPoems(_ value: Poem)

    @objc(addPoems:)
    @NSManaged public func addToPoems(_ values: NSSet)

    @objc(removePoems:)
    @NSManaged public func removeFromPoems(_ values: NSSet)

}

extension Book : Identifiable {

}
