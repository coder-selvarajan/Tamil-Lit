//
//  MainCategory+CoreDataProperties.swift
//  Tamil Lit
//
//  Created by Selvarajan on 20/06/24.
//
//

import Foundation
import CoreData


extension MainCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainCategory> {
        return NSFetchRequest<MainCategory>(entityName: "MainCategory")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var info: String?
    @NSManaged public var order: Int16
    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?
    @NSManaged public var book: Book?
    @NSManaged public var poems: NSSet?
    @NSManaged public var subCategories: NSSet?

}

// MARK: Generated accessors for poems
extension MainCategory {

    @objc(addPoemsObject:)
    @NSManaged public func addToPoems(_ value: Poem)

    @objc(removePoemsObject:)
    @NSManaged public func removeFromPoems(_ value: Poem)

    @objc(addPoems:)
    @NSManaged public func addToPoems(_ values: NSSet)

    @objc(removePoems:)
    @NSManaged public func removeFromPoems(_ values: NSSet)

}

// MARK: Generated accessors for subCategories
extension MainCategory {

    @objc(addSubCategoriesObject:)
    @NSManaged public func addToSubCategories(_ value: SubCategory)

    @objc(removeSubCategoriesObject:)
    @NSManaged public func removeFromSubCategories(_ value: SubCategory)

    @objc(addSubCategories:)
    @NSManaged public func addToSubCategories(_ values: NSSet)

    @objc(removeSubCategories:)
    @NSManaged public func removeFromSubCategories(_ values: NSSet)

}

extension MainCategory : Identifiable {

}
