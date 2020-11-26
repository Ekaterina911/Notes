//
//  ViewController.swift
//  Notes
//
//  Created by EKATERINA  KUKARTSEVA on 26.09.2020.
//  Copyright © 2020 EKATERINA  KUKARTSEVA. All rights reserved.
//

import UIKit

class EditNoteViewController: UIViewController {
    
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var share: UIBarButtonItem!
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        share.isEnabled = false
        
        updateUI()
        
        let accessoryView = KeyboardAccessoryToolbar()
        noteText.inputAccessoryView = accessoryView
    }
    
    private func updateUI() {
        if let note = note {
            noteTitle.text = note.title
            noteText.text = note.text
            share.isEnabled = true
        }
    }
    
    @IBAction func shareAction(_ sender: UIBarButtonItem) {
        
        let items = [self]
        
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func saveNote(_ sender: Any) {
        
        guard let title = noteTitle.text, title.count > 0 else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        let text = noteText.text.count > 0 ? noteText.text! : ""
        
        if note == nil {
            note = Note()
        }
        
        if let note = note {
            note.title = title
            note.text = text
            note.createdAt = Date()
            CoreData.shared.saveContext()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension EditNoteViewController: UIActivityItemSource {

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return ""
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return (note?.title)! + "\n" + (note?.text)!
    }

    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return ""
    }

}
