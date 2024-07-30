//
//  FavouritePoem+CoreDataProperties.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/07/24.
//
//

import Foundation
import CoreData


extension FavouritePoem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouritePoem> {
        return NSFetchRequest<FavouritePoem>(entityName: "FavouritePoem")
    }

    @NSManaged public var bookname: String?
    @NSManaged public var id: UUID?
    @NSManaged public var maincategoryname: String?
    @NSManaged public var number: Int16
    @NSManaged public var poem: String?
    @NSManaged public var sectionname: String?
    @NSManaged public var subcategoryname: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?

}

extension FavouritePoem : Identifiable {

}
