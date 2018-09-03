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
    case MiddleDarkBlue
    case Blue
    case MiddleBlue
    case Orange
    case Green
    case Black
    case Gray
    case LightGray
    case DarkGray
    case Clear
    
    public func color() -> UIColor {
        switch self {
        case .White:
            return #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        case .DarkBlue:
            return #colorLiteral(red: 0.09803921569, green: 0.1294117647, blue: 0.1764705882, alpha: 1)
        case .MiddleDarkBlue:
            return #colorLiteral(red: 0.12415535, green: 0.1860362291, blue: 0.2528194189, alpha: 1)
        case .Blue:
            return #colorLiteral(red: 0.337254902, green: 0.6901960784, blue: 0.9764705882, alpha: 1)
        case .MiddleBlue:
            return #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        case .Orange:
            return #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        case .Green:
            return #colorLiteral(red: 0.2666666667, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
        case .Black:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .Gray:
            return #colorLiteral(red: 0.7999204993, green: 0.8000556827, blue: 0.7999026775, alpha: 1)
        case .LightGray:
            return #colorLiteral(red: 0.9410838485, green: 0.9412414432, blue: 0.9410631061, alpha: 1)
        case .DarkGray:
            return #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        case .Clear:
            return UIColor.clear
        }
    }
}
