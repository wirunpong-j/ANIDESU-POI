//
//  DiscoverAnimeViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 15/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DiscoverAnimeViewController: BaseViewController {
    static let identifier = "DiscoverAnimeViewController"
    
    @IBOutlet weak var listAnimeCollectionView: UICollectionView!
    
    var discoverAnimeViewModel: DiscoverAnimeViewModel!
    var animeSeason: AnimeSeason!
    var listAnime = [AnimeResponse]()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViewModel()
        self.setUpCollectionView()
    }
    
    func setUpViewModel() {
        self.discoverAnimeViewModel = DiscoverAnimeViewModel()
        
        self.discoverAnimeViewModel.errorRelay.subscribe(onNext: { (errorString) in
            self.showAlert(title: "Error", message: errorString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
    
    func setUpCollectionView() {
        self.listAnimeCollectionView.dataSource = self
        self.listAnimeCollectionView.delegate = self
        self.listAnimeCollectionView.register(AnimeCell.nib, forCellWithReuseIdentifier: AnimeCell.identifier)
        
        self.discoverAnimeViewModel.fetchListAnimeBySeason(season: animeSeason) { (listAnime) in
            self.listAnime = listAnime
            self.listAnimeCollectionView.reloadData()
        }
    }
}

extension DiscoverAnimeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listAnime.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnimeCell.identifier, for: indexPath) as? AnimeCell {
            cell.setUpView(anime: self.listAnime[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension DiscoverAnimeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = self.view.frame.width
        return CGSize(width: (screenWidth / 2) - 5, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 2.5, bottom: 5, right: 2.5)
    }
    
}
