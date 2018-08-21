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
    
    private var frameLayer: CAShapeLayer?
    private var corners: UIRectCorner {
        get {
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
    
    private var maskPath: UIBezierPath {
        get {
            return UIBezierPath(roundedRect: self.bounds, byRoundingCorners: self.corners, cornerRadii: CGSize(width: self.cornerRadius, height: self.cornerRadius))
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if self.cornerRadius > 0 {
            setRoundCornersWithCorners(corners: corners, Radius: cornerRadius)
        }
        if self.borderWidth > 0 {
            setBorderWithColor(color: borderColor)
        }
    }
    
    func updateCornersAndBorder() {
        layoutIfNeeded()
        
        setRoundCornersWithCorners(corners: self.corners, Radius: self.cornerRadius)
        setBorderWithColor(color: borderColor)
    }
    
    private func setRoundCornersWithCorners(corners: UIRectCorner, Radius radius: CGFloat) {
        let bounds = self.bounds
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: self.corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    
    private func setBorderWithColor(color: UIColor) {
        if let frameLayer = self.frameLayer {
            frameLayer.removeFromSuperlayer()
            self.frameLayer = nil
        }
        
        if self.frameLayer == nil {
            self.frameLayer = CAShapeLayer()
            self.frameLayer!.frame = self.bounds
            self.frameLayer!.path = self.maskPath.cgPath
            self.frameLayer!.strokeColor = color.cgColor
            self.frameLayer!.fillColor = nil
            self.frameLayer!.lineWidth = self.borderWidth * 2
            self.layer.addSublayer(self.frameLayer!)
            self.layoutIfNeeded()
        }
    }
}
