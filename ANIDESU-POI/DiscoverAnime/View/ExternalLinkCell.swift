//
//  ExternalLinkCell.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 23/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class ExternalLinkCell: UITableViewCell {
    static let nib = UINib(nibName: "ExternalLinkCell", bundle: .main)
    static let identifier = "ExternalLinkCell"

    @IBOutlet weak var linkBtn: AnidesuButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func linkBtnPressed(_ sender: Any) {
    }
    
}
