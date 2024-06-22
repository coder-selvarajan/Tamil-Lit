//
//  Section+CoreDataProperties.swift
//  Tamil Lit
//
//  Created by Selvarajan on 20/06/24.
//
//

import Foundation
import CoreData


extension Section {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Section> {
        return NSFetchRequest<Section>(entityName: "Section")
    }

    @NSManaged public var id: String?
    @NSManaged public var info: String?
    @NSManaged public var order: Int16
    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?
    @NSManaged public var poems: NSOrderedSet?
    @NSManaged public var subCategory: SubCategory?

}

// MARK: Generated accessors for poems
extension Section {

    @objc(insertObject:inPoemsAtIndex:)
    @NSManaged public func insertIntoPoems(_ value: Poem, at idx: Int)

    @objc(removeObjectFromPoemsAtIndex:)
    @NSManaged public func removeFromPoems(at idx: Int)

    @objc(insertPoems:atIndexes:)
    @NSManaged public func insertIntoPoems(_ values: [Poem], at indexes: NSIndexSet)

    @objc(removePoemsAtIndexes:)
    @NSManaged public func removeFromPoems(at indexes: NSIndexSet)

    @objc(replaceObjectInPoemsAtIndex:withObject:)
    @NSManaged public func replacePoems(at idx: Int, with value: Poem)

    @objc(replacePoemsAtIndexes:withPoems:)
    @NSManaged public func replacePoems(at indexes: NSIndexSet, with values: [Poem])

    @objc(addPoemsObject:)
    @NSManaged public func addToPoems(_ value: Poem)

    @objc(removePoemsObject:)
    @NSManaged public func removeFromPoems(_ value: Poem)

    @objc(addPoems:)
    @NSManaged public func addToPoems(_ values: NSOrderedSet)

    @objc(removePoems:)
    @NSManaged public func removeFromPoems(_ values: NSOrderedSet)

}

extension Section : Identifiable {

}
