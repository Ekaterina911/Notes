//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by EKATERINA  KUKARTSEVA on 30.09.2020.
//  Copyright © 2020 EKATERINA  KUKARTSEVA. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var pinned: UIImageView!
    @IBOutlet weak var roundedBackgroundView: UIView!
    
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        formatter.locale = Locale(identifier: "RU")
        return formatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleAppearance()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with note: Note) {
        self.title.text = note.title
        if note.createdAt != nil {
            self.createdAt.text = dateFormatter.string(from: note.createdAt!)
        }
        pinned.isHidden = !note.pinned
    }
    
    private func styleAppearance() {
      roundedBackgroundView.layer.cornerRadius = 10.0
      roundedBackgroundView.layer.masksToBounds = false
      roundedBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
      roundedBackgroundView.layer.shadowColor = #colorLiteral(red: 0.05490196078, green: 0.1333333333, blue: 0.1882352941, alpha: 1).cgColor
      roundedBackgroundView.layer.shadowRadius = 1.0
      roundedBackgroundView.layer.shadowOpacity = 0.3
    }
    
}
