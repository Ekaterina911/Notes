//
//  CoreData.swift
//  Notes
//
//  Created by EKATERINA  KUKARTSEVA on 30.09.2020.
//  Copyright © 2020 EKATERINA  KUKARTSEVA. All rights reserved.
//

import Foundation
import CoreData

class CoreData {
    
    static public var shared = CoreData()
    
    func entityForName(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
    }
    
    var context: NSManagedObjectContext {
        get {
            return persistentContainer.viewContext
        }
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Notes")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchedResultsController() -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        let createdAtSort = NSSortDescriptor(key: "createdAt", ascending: false)
        let pinnedSort = NSSortDescriptor(key: "pinned", ascending: false)
        fetchRequest.sortDescriptors = [pinnedSort, createdAtSort]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
    
    func deleteNote(note: Note) {
        context.delete(note)
        saveContext()
    }
    
    func deleteAllNotes() {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        if let notes = try? context.fetch(fetchRequest) {
            for note in notes {
                context.delete(note)
            }
            
            saveContext()
        }
    }
    
    //    func sort(forKey key: String, ascending: Bool) {
    //
    //        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
    //
    //        let sortDescriptor = NSSortDescriptor(key: key, ascending: ascending)
    //        fetchRequest.sortDescriptors = [sortDescriptor]
    //
    //        do {
    //            try context.fetch(fetchRequest)
    //        } catch let error as NSError {
    //            print(error.localizedDescription)
    //        }
    //    }
    //
    //    func fetchData() {
    //
    //        let request: NSFetchRequest<Note> = Note.fetchRequest()
    //
    //        do {
    //            try context.fetch(request)
    //        } catch {
    //            print(error)
    //        }
    //    }
    //
    //    // Фильтр по ключу?
    //    func filter() {
    //
    //        let request: NSFetchRequest<Note> = Note.fetchRequest()
    //
    //        let title = "asd"
//            request.predicate = NSPredicate(format: "title == %@", title)
    //
    //        do {
    //            try context.fetch(request)
    //        } catch let error as NSError {
    //            print(error.localizedDescription)
    //        }
    //    }
    //
    //    func count() -> Int {
    //        let request: NSFetchRequest<Note> = Note.fetchRequest()
    //        var count = 0
    //
    //        do {
    //            count = try context.count(for: request)
    //        } catch let error as NSError {
    //            print(error.localizedDescription)
    //        }
    //
    //        return count
    //    }
    
}
