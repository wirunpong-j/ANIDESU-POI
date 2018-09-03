//
//  MyAnimeListViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 27/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MyAnimeListViewController: BaseViewController {
    static let identifier = "MyAnimeListViewController"

    @IBOutlet weak var myAnimeListCollectionView: UICollectionView!
    
    var myAnimeListViewModel: MyAnimeListViewModel!
    let disposeBag = DisposeBag()
    var myAnimeListStatus: MyAnimeListStatus!
    var myAnimeList = [MyAnimeList]()
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUpViewModel()
        self.setUpCollectionView()
    }
    
    private func setUpViewModel() {
        self.myAnimeListViewModel = MyAnimeListViewModel()
        
        self.myAnimeListViewModel.errorRelay.subscribe(onNext: { (errorString) in
            self.showAlert(title: "Error", message: errorString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
        self.myAnimeListViewModel.fetchAllMyAnimeList(status: myAnimeListStatus) { (myAnimeList) in
            self.myAnimeList = myAnimeList
            self.myAnimeListCollectionView.reloadData()
        }
    }
    
    private func setUpCollectionView() {
        self.myAnimeListCollectionView.dataSource = self
        self.myAnimeListCollectionView.delegate = self
        self.myAnimeListCollectionView.register(MyAnimeListCell.nib, forCellWithReuseIdentifier: MyAnimeListCell.identifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case AnimeDetailViewController.identifier:
            let navbar = segue.destination as? UINavigationController
            if let viewController = navbar?.viewControllers.first as? AnimeDetailViewController {
                viewController.anime = sender as? Anime
            }
        default:
            break
        }
    }
}

extension MyAnimeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myAnimeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyAnimeListCell.identifier, for: indexPath) as? MyAnimeListCell {
            cell.setUpCell(myAnimeList: self.myAnimeList[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: AnimeDetailViewController.identifier, sender: myAnimeList[indexPath.row].anime)
    }
}

extension MyAnimeListViewController: UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if self.myAnimeList.isEmpty {
            collectionView.backgroundView  = NoDataView.loadViewFromNib()
            return 0
        } else {
            collectionView.backgroundView = nil
            return 1
        }
    }
    
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
