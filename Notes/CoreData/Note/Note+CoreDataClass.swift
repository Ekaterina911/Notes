//
//  Note+CoreDataClass.swift
//  Notes
//
//  Created by EKATERINA  KUKARTSEVA on 03.10.2020.
//  Copyright © 2020 EKATERINA  KUKARTSEVA. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    
    convenience init() {
        self.init(entity: CoreData.shared.entityForName(entityName: "Note"), insertInto: CoreData.shared.context)
    }
    
}
