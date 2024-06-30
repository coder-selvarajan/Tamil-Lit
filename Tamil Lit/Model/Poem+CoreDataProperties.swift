//
//  Poem+CoreDataProperties.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//
//

import Foundation
import CoreData


extension Poem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Poem> {
        return NSFetchRequest<Poem>(entityName: "Poem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var number: Int16
    @NSManaged public var poem: String?
    @NSManaged public var poeminfo: String?
    @NSManaged public var transliteration: String?
    @NSManaged public var book: Book?
    @NSManaged public var explanations: NSOrderedSet?
    @NSManaged public var mainCategory: MainCategory?
    @NSManaged public var section: Section?
    @NSManaged public var subCategory: SubCategory?

}

// MARK: Generated accessors for explanations
extension Poem {

    @objc(insertObject:inExplanationsAtIndex:)
    @NSManaged public func insertIntoExplanations(_ value: Explanation, at idx: Int)

    @objc(removeObjectFromExplanationsAtIndex:)
    @NSManaged public func removeFromExplanations(at idx: Int)

    @objc(insertExplanations:atIndexes:)
    @NSManaged public func insertIntoExplanations(_ values: [Explanation], at indexes: NSIndexSet)

    @objc(removeExplanationsAtIndexes:)
    @NSManaged public func removeFromExplanations(at indexes: NSIndexSet)

    @objc(replaceObjectInExplanationsAtIndex:withObject:)
    @NSManaged public func replaceExplanations(at idx: Int, with value: Explanation)

    @objc(replaceExplanationsAtIndexes:withExplanations:)
    @NSManaged public func replaceExplanations(at indexes: NSIndexSet, with values: [Explanation])

    @objc(addExplanationsObject:)
    @NSManaged public func addToExplanations(_ value: Explanation)

    @objc(removeExplanationsObject:)
    @NSManaged public func removeFromExplanations(_ value: Explanation)

    @objc(addExplanations:)
    @NSManaged public func addToExplanations(_ values: NSOrderedSet)

    @objc(removeExplanations:)
    @NSManaged public func removeFromExplanations(_ values: NSOrderedSet)

}

extension Poem : Identifiable {

}
