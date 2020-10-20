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
    
    let idSegueOnEdit = "edit"
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        formatter.locale = Locale(identifier: "RU")
        return formatter
    }()
    
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: idSegueOnEdit, sender: nil)
    }
    
    @IBAction func cancelAction(_ segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CoreData.sort(forKey: "title", ascending: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoreData.deleteAllNotes()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreData.tasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let task = CoreData.tasks[indexPath.row]
        cell.textLabel?.text = task.title
        cell.detailTextLabel?.text = dateFormatter.string(from: task.createdAt!)
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        
        
        
     }
     
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        performSegue(withIdentifier: idSegueOnEdit, sender: indexPath.row)
        
        return nil
    }
}
