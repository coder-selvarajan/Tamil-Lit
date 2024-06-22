//
//  Book+CoreDataProperties.swift
//  Tamil Lit
//
//  Created by Selvarajan on 20/06/24.
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
    @NSManaged public var categories: MainCategory?
    @NSManaged public var poems: Poem?

}

extension Book : Identifiable {

}
