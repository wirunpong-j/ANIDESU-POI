//
//  ImageRoundView.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 7/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import UIKit

class ImageRoundView: UIImageView {
    
    @IBInspectable var borderColor: UIColor = UIColor.clear
    @IBInspectable var borderWidth: CGFloat = 0.0
    
    override func awakeFromNib() {
        setRounded()
    }
    
    func setRounded() {
        self.layer.masksToBounds = false
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
