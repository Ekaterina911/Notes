//
//  KeyboardAccessoryToolbar.swift
//  Notes
//
//  Created by EKATERINA  KUKARTSEVA on 26.11.2020.
//  Copyright © 2020 EKATERINA  KUKARTSEVA. All rights reserved.
//

import UIKit

class KeyboardAccessoryToolbar: UIToolbar {

    convenience init() {
        self.init(frame: CGRect(x: 0.0,
                                y: 0.0,
                                width: UIScreen.main.bounds.size.width,
                                height: 44.0))
        self.isTranslucent = true
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let cameraImage = UIImage(systemName: "camera")
        
        let cameraBarButton = UIBarButtonItem(image: cameraImage, style: .plain, target: self, action: nil)
        cameraBarButton.tintColor = UIColor(named: "PrimaryTextColor")
        
        let keyboardDoneImage = UIImage(systemName: "keyboard.chevron.compact.down")
        
        let keyboardDoneBarButton = UIBarButtonItem(image: keyboardDoneImage, style: .plain, target: self, action: #selector(cancel))
        keyboardDoneBarButton.tintColor = UIColor(named: "PrimaryTextColor")
        
        self.setItems([cameraBarButton, flexible, keyboardDoneBarButton], animated: false)
    }
    
    @objc func cancel() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

}
