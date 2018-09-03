//
//  AnidesuTextField.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 3/9/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import UIKit

class AnidesuTextField: UITextField {
    
    @IBInspectable var placeholderText: String?
    @IBInspectable var placeholderColor: UIColor = AnidesuColor.Clear.color()
    
    override func awakeFromNib() {
        self.setInterface()
    }
    
    private func setInterface() {
        self.setPlaceholder()
    }
    
    private func setPlaceholder() {
        if let placeholderText = self.placeholderText {
            self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedStringKey.foregroundColor: self.placeholderColor])
        }
    }
}
