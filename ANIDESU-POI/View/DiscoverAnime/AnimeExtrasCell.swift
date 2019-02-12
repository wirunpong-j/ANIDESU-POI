//
//  AnimeExtrasCell.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 23/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class AnimeExtrasCell: UITableViewCell {
    static let nib = UINib(nibName: "AnimeExtrasCell", bundle: .main)
    static let identifier = "AnimeExtrasCell"
    
    @IBOutlet weak var characterCollectionView: UICollectionView!
    @IBOutlet weak var staffCollectionView: UICollectionView!
    
    var characters: [CharacterStaff]?
    var staffs: [CharacterStaff]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        self.characterCollectionView.delegate = self
        self.characterCollectionView.dataSource = self
        self.staffCollectionView.delegate = self
        self.staffCollectionView.dataSource = self
        self.characterCollectionView.register(CharacterCell.nib, forCellWithReuseIdentifier: CharacterCell.identifier)
        self.staffCollectionView.register(CharacterCell.nib, forCellWithReuseIdentifier: CharacterCell.identifier)
    }
    
    public func setUpCell(characters: [CharacterStaff]?, staffs: [CharacterStaff]?) {
        if let characters = characters, let staffs = staffs {
            self.characters = characters
            self.staffs = staffs
            self.characterCollectionView.reloadData()
            self.staffCollectionView.reloadData()
        }
    }
}

extension AnimeExtrasCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == characterCollectionView {
            if let characters = self.characters, !characters.isEmpty {
                collectionView.backgroundView = nil
                return 1
            } else {
                collectionView.backgroundView = NoDataView.loadViewFromNib()
                return 0
            }
        } else {
            if let staffs = self.staffs, !staffs.isEmpty {
                collectionView.backgroundView = nil
                return 1
            } else {
                collectionView.backgroundView = NoDataView.loadViewFromNib()
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == characterCollectionView {
            return self.characters?.count ?? 0
        } else {
            return self.staffs?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == characterCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell {
                cell.setUpCell(character: self.characters![indexPath.row])
                return cell
            }
            
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell {
                cell.setUpCell(character: self.staffs![indexPath.row])
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
}

extension AnimeExtrasCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 2.5, bottom: 1, right: 2.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
