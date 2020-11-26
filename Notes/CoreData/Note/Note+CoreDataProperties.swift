//
//  Note+CoreDataProperties.swift
//  Notes
//
//  Created by EKATERINA  KUKARTSEVA on 03.10.2020.
//  Copyright © 2020 EKATERINA  KUKARTSEVA. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var text: String?
    @NSManaged public var title: String?
    @NSManaged public var pinned: Bool

}
