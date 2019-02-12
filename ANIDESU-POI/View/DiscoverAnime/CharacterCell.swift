//
//  CharacterCell.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 23/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    static let nib = UINib(nibName: "CharacterCell", bundle: .main)
    static let identifier = "CharacterCell"
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpCell(character: CharacterStaff) {
        self.coverImage.setImage(urlStr: character.imageUrlLarge)
        self.fullNameLabel.text = self.getFullName(character: character)
        self.roleLabel.text = character.role
    }
    
    private func getFullName(character: CharacterStaff) -> String {
        if !character.firstName.isEmpty && !character.lastName.isEmpty {
            return character.firstName + " " + character.lastName
        }
        
        return AnidesuConverter.NULL_TEXT
    }

}