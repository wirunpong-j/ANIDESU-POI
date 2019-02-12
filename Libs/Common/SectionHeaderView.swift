//
//  SectionHeaderView.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 22/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import UIKit

class SectionHeaderView: UIView {
    @IBOutlet weak var roundView: AnidesuRoundView!
    @IBOutlet weak var headerLabel: UILabel!
    
    public static func loadViewFromNib() -> SectionHeaderView {
        return Bundle.main.loadNibNamed("SectionHeaderView", owner: self, options: nil)!.first as! SectionHeaderView
    }
    
    public static func loadViewFromNib(title: String, backgroundColor: AnidesuColor, contentViewColor: AnidesuColor) -> SectionHeaderView {
        let view = SectionHeaderView.loadViewFromNib()
        view.headerLabel.text = title
        view.headerLabel.textColor = AnidesuColor.White.color()
        view.roundView.backgroundColor = backgroundColor.color()
        view.backgroundColor = contentViewColor.color()
        return view
    }
    
}
