//
//  AnidesuColor.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 7/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import UIKit

public enum AnidesuColor {
    case White
    case DarkBlue
    case Blue
    case Orange
    
    public func color() -> UIColor {
        switch self {
        case .White:
            return #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        case .DarkBlue:
            return #colorLiteral(red: 0.1333333333, green: 0.1921568627, blue: 0.2470588235, alpha: 1)
        case .Blue:
            return #colorLiteral(red: 0.337254902, green: 0.6901960784, blue: 0.9764705882, alpha: 1)
        case .Orange:
            return #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
    }
}
