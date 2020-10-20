//
//  TableViewController.swift
//  ToDoList
//
//  Created by EKATERINA  KUKARTSEVA on 22.08.2020.
//  Copyright © 2020 EKATERINA  KUKARTSEVA. All rights reserved.
//

import UIKit
import CoreData

class NoteTableViewController: UITableViewController {
    
    @IBOutlet var searchBarView: UISearchBar!
    
    private let segueIdentifier = "saveNote"
    private let cellIdentifier = "Cell"
    private let fetchedResultsController = CoreData.shared.fetchedResultsController()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.titleView = searchBarView
        tableView.tableHeaderView = searchBarView
        
        searchBarView.delegate = self
        
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
        
//                for _ in 0...10000 {
//                    let note = Note()
//                    note.title = UUID().uuidString
//                    note.text = UUID().uuidString
//                    note.createdAt = Date()
//                }
//                CoreData.shared.saveContext()
        
//        CoreData.shared.deleteAllNotes()
    }
    
    @IBAction func saveNote(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
    
    @IBAction func cancel(_ sender: UIStoryboardSegue) {}
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == segueIdentifier,
              let navigationVC = segue.destination as? UINavigationController,
              let newController = navigationVC.topViewController as? EditNoteViewController
        else { return }
        
        if sender == nil {
            newController.note = nil
        } else {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let note = fetchedResultsController.object(at: indexPath) as! Note
            
            newController.note = note
            newController.title = NSLocalizedString("edit", comment: "")
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension NoteTableViewController {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NoteTableViewCell
        
        guard let note = fetchedResultsController.object(at: indexPath) as? Note
        else { return cell}
        
        cell.configureCell(with: note)
        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let note = fetchedResultsController.object(at: indexPath) as? Note else {
            return nil
        }
        let action = actionDelete(a: note)
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    private func actionDelete(a note: Note) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            CoreData.shared.deleteNote(note: note)
            completion(true)
        }
        action.backgroundColor = UIColor(named: "BackgroundColor")
        action.image = UIImage(named: "Busket")
        
        return action
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let note = fetchedResultsController.object(at: indexPath) as? Note else {
            return nil
        }
        
        let action = actionToPin(a: note)
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    private func actionToPin(a note: Note) -> UIContextualAction {
        
        let action = UIContextualAction(style: .normal, title: "Pin") { (action, view, completion) in
            note.pinned = !note.pinned
            CoreData.shared.saveContext()
            completion(true)
        }
        action.backgroundColor = UIColor(named: "BackgroundColor")
        action.image = note.pinned ? UIImage(named: "Unpin") : UIImage(named: "Pin")
        
        return action
    }
    
}

// MARK: - NSFetchedResultsControllerDelegate

extension NoteTableViewController: NSFetchedResultsControllerDelegate {
    
    // Уведомляет получателя, что полученный контроллер результатов собирается начать обработку одного или нескольких изменений из-за добавления, удаления, перемещения или обновления.
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    // Уведомляет получателя о том, что выбранный объект был изменен в результате добавления, удаления, перемещения или обновления.
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        case .move: break
        @unknown default:
            fatalError("No info")
        }
        
        tableView.reloadData()
    }
    
    // Уведомляет получателя, что полученный контроллер результатов завершил обработку одного или нескольких изменений из-за добавления, удаления, перемещения или обновления.
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

// MARK: - UISearchBarDelegate

extension NoteTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            fetchedResultsController.fetchRequest.predicate = nil
        } else {
            self.fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "(title contains[cd] %@) OR (text contains[cd] %@)", searchText, searchText)
        }
        
        do {
            try self.fetchedResultsController.performFetch()
            self.tableView.reloadData()
        } catch {}
        
    }
    
}
