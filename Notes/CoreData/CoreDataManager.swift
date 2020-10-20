//
//  DataController.swift
//  ToDoList
//
//  Created by EKATERINA  KUKARTSEVA on 01.10.2020.
//  Copyright © 2020 EKATERINA  KUKARTSEVA. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataStack {
    
    // MARK: - Core Data stack

    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
