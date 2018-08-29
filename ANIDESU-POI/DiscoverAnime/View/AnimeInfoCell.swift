//
//  AnimeInfoCell.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 22/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class AnimeInfoCell: UITableViewCell {
    static let nib = UINib(nibName: "AnimeInfoCell", bundle: .main)
    static let identifier = "AnimeInfoCell"
    
    @IBOutlet weak var animeEngNameLabel: UILabel!
    @IBOutlet weak var animeTypeLabel: UILabel!
    @IBOutlet weak var totalEPLabel: UILabel!
    @IBOutlet weak var animeTagLabel: UILabel!
    @IBOutlet weak var animeGenresLabel: UILabel!
    @IBOutlet weak var hashTagLabel: UILabel!
    @IBOutlet weak var animeOriginLabel: UILabel!
    @IBOutlet weak var mainStudioLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var roundView: AnidesuRoundView!
    
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpCell(anime: Anime) {
        self.animeEngNameLabel.text = AnidesuConverter.checkNilString(str: anime.titleEnglish)
        self.animeTypeLabel.text = AnidesuConverter.checkNilString(str: anime.type)
        self.totalEPLabel.text = AnidesuConverter.checkNilInt(int: anime.totalEP)
        self.animeTagLabel.text = AnidesuConverter.NULL_TEXT
        self.animeGenresLabel.text = AnidesuConverter.getArrayString(array: anime.genres)
        self.hashTagLabel.text = AnidesuConverter.checkNilString(str: anime.hashtag)
        self.animeOriginLabel.text = AnidesuConverter.checkNilString(str: anime.source)
        self.mainStudioLabel.text = AnidesuConverter.NULL_TEXT
        self.descLabel.text = AnidesuConverter.checkNilString(str: anime.description)
        
        self.stackView.frame.size = CGSize(width: self.stackView.frame.width, height: 2000)
        
    }
}
