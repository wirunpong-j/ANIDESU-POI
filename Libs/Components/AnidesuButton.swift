//
//  AnidesuButton.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 6/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class AnidesuButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0.0
    @IBInspectable var borderWidth: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor = UIColor.clear
    @IBInspectable var key: String?
    @IBInspectable var fontSize: String?
    
    override func awakeFromNib() {
        self.setInterface()
    }
    
    func setInterface() {
        self.setUpFont()
        self.setUpButton()
    }
    
    func setUpFont() {
        
    }
    
    func setUpButton() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    public func switchButton(isEnabled: Bool, tintColor: AnidesuColor) {
        self.tintColor = tintColor.color()
        self.isEnabled = isEnabled
    }
}
