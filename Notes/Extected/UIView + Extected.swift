//
//  UIView + Extected.swift
//  ToDoList
//
//  Created by EKATERINA  KUKARTSEVA on 05.10.2020.
//  Copyright © 2020 EKATERINA  KUKARTSEVA. All rights reserved.
//

import UIKit

extension UIView {
    
    // Радиус границы
    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue  }
        get { return layer.cornerRadius }
    }
    /// Толщина границы
    @IBInspectable var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
    /// Цвет границы
    @IBInspectable var borderColor: UIColor? {
        set { layer.borderColor = newValue?.cgColor  }
        get { return layer.borderColor?.UIColor }
    }
    /// Смещение тени
    @IBInspectable var shadowOffset: CGSize {
        set { layer.shadowOffset = newValue  }
        get { return layer.shadowOffset }
    }
    /// Прозрачность тени
    @IBInspectable var shadowOpacity: Float {
        set { layer.shadowOpacity = newValue }
        get { return layer.shadowOpacity }
    }
    /// Радиус блура тени
    @IBInspectable var shadowRadius: CGFloat {
        set {  layer.shadowRadius = newValue }
        get { return layer.shadowRadius }
    }
    /// Цвет тени
    @IBInspectable var shadowColor: UIColor? {
        set { layer.shadowColor = newValue?.cgColor }
        get { return layer.shadowColor?.UIColor }
    }
}

extension CGColor {
    
    var UIColor: UIKit.UIColor {
        return UIKit.UIColor(cgColor: self)
    }
}
