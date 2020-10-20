//
//  UITextField + Extected.swift
//  ToDoList
//
//  Created by EKATERINA  KUKARTSEVA on 10.10.2020.
//  Copyright © 2020 EKATERINA  KUKARTSEVA. All rights reserved.
//

import UIKit

extension UITextField {
    
    @IBInspectable var placeholderColor: UIColor {
        get {
            return self.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .lightText
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [.foregroundColor: newValue])
        }
    }
}
