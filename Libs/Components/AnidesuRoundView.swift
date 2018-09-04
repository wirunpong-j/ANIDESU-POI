//
//  AnidesuRoundView.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 20/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import UIKit

class AnidesuRoundView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 3.0
    @IBInspectable var topLeft: Bool = false
    @IBInspectable var topRight: Bool = false
    @IBInspectable var bottomLeft: Bool = false
    @IBInspectable var bottomRight: Bool = false
    @IBInspectable var borderWidth: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor = UIColor.clear
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setInterface()
    }
    
    override func layoutSubviews() {
        self.setInterface()
    }
    
    public func setInterface() {
        if self.cornerRadius > 0 {
            self.setRoundCornersWithRadius(radius: self.cornerRadius)
        }
    }
    
    private func setRoundCornersWithRadius(radius: CGFloat) {
        let bounds = self.bounds
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: getCorners(),
                                    cornerRadii: CGSize(width: radius, height: radius))
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    private func getCorners() -> UIRectCorner {
        var corners = UIRectCorner()
        if self.bottomLeft {
            corners.insert(.bottomLeft)
        }
        if self.bottomRight {
            corners.insert(.bottomRight)
        }
        if self.topLeft {
            corners.insert(.topLeft)
        }
        if self.topRight {
            corners.insert(.topRight)
        }
        
        return corners
    }
}
