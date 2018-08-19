//
//  Image+KF+RoundView.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 15/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(urlStr: String) {
        let url = URL(string: urlStr)
        self.kf.setImage(with: url)
    }
    
    func setImageWithRounded(urlStr: String) {
        let url = URL(string: urlStr)
        self.kf.setImage(with: url)
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = AnidesuColor.White.color().cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.contentMode = .scaleToFill
        self.clipsToBounds = true
    }
}

