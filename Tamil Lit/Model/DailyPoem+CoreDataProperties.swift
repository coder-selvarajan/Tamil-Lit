//
//  DailyPoem+CoreDataProperties.swift
//  Tamil Lit
//
//  Created by Selvarajan on 30/07/24.
//
//

import Foundation
import CoreData


extension DailyPoem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyPoem> {
        return NSFetchRequest<DailyPoem>(entityName: "DailyPoem")
    }

    @NSManaged public var bookname: String?
    @NSManaged public var category: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var number: Int16
    @NSManaged public var poem: String?

}

extension DailyPoem : Identifiable {

}
