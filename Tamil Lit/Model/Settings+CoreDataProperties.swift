//
//  Settings+CoreDataProperties.swift
//  Tamil Lit
//
//  Created by Selvarajan on 18/07/24.
//
//

import Foundation
import CoreData


extension Settings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Settings> {
        return NSFetchRequest<Settings>(entityName: "Settings")
    }


}

extension Settings : Identifiable {

}
