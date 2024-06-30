//
//  Section+CoreDataProperties.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/06/24.
//
//

import Foundation
import CoreData


extension Section {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Section> {
        return NSFetchRequest<Section>(entityName: "Section")
    }

    @NSManaged public var bookname: String?
    @NSManaged public var end: Int16
    @NSManaged public var groupname: String?
    @NSManaged public var id: UUID?
    @NSManaged public var info: String?
    @NSManaged public var number: Int16
    @NSManaged public var start: Int16
    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?
    @NSManaged public var poems: NSSet?
    @NSManaged public var subCategory: SubCategory?

}

// MARK: Generated accessors for poems
extension Section {

    @objc(addPoemsObject:)
    @NSManaged public func addToPoems(_ value: Poem)

    @objc(removePoemsObject:)
    @NSManaged public func removeFromPoems(_ value: Poem)

    @objc(addPoems:)
    @NSManaged public func addToPoems(_ values: NSSet)

    @objc(removePoems:)
    @NSManaged public func removeFromPoems(_ values: NSSet)

}

extension Section : Identifiable {

}
