//
//  MoreDetailLabelCell.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 3/9/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class MoreDetailLabelCell: UITableViewCell {
    static let nib = UINib(nibName: "MoreDetailLabelCell", bundle: .main)
    static let identifier = "MoreDetailLabelCell"
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setUpCell(header: String, desc: String) {
        self.headerLabel.text = header
        self.descLabel.text = desc
    }
    
    public func setUpColor(background: AnidesuColor, header: AnidesuColor, desc: AnidesuColor) {
        self.contentView.backgroundColor = background.color()
        self.headerLabel.textColor = header.color()
        self.descLabel.textColor = desc.color()
    }

}
