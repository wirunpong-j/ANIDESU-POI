//
//  AnimeHeaderCell.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 22/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class AnimeHeaderCell: UITableViewCell {
    static let nib = UINib(nibName: "AnimeHeaderCell", bundle: .main)
    static let identifier = "AnimeHeaderCell"
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var animeNameLabel: UILabel!
    @IBOutlet weak var airingLabel: UILabel!
    @IBOutlet weak var nextEPLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setUpCell(anime: Anime) {
        self.coverImage.setImage(urlStr: anime.imageUrlLarge)
        self.animeNameLabel.text = anime.titleRomaji
        self.airingLabel.text = anime.airingStatus.uppercased()
        self.nextEPLabel.text = anime.airing.getNextEpisodeTime()
        self.startLabel.text = AnidesuConverter.getDateFuzzy(dateFuzzy: anime.startDateFuzzy)
        self.endLabel.text = AnidesuConverter.getDateFuzzy(dateFuzzy: anime.endDateFuzzy)
    }
}
