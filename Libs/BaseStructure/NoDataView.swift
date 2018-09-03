//
//  NoDataView.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 3/9/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import UIKit

class NoDataView: UIView {
    
    public static func loadViewFromNib() -> NoDataView {
        return Bundle.main.loadNibNamed("NoDataView", owner: self, options: nil)!.first as! NoDataView
    }
    
}
