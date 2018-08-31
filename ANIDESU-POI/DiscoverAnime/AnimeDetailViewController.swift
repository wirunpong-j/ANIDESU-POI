//
//  AnimeDetailViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 22/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AnimeDetailViewController: BaseViewController {
    static let identifier = "AnimeDetailViewController"
    
    @IBOutlet weak var animeDetailTableView: UITableView!
    @IBOutlet weak var animeBannerImage: UIImageView!
    
    var discoverAnimeViewModel: DiscoverAnimeViewModel!
    var myAnimeListViewModel: MyAnimeListViewModel!
    var disposeBag = DisposeBag()
    
    var anime: Anime?
    var myAnimeList: MyAnimeList?
    
    private enum AnimeDetailSections: Int {
        case detail, info, stats, extras
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showLoading()
        self.setUpTableView()
        self.setUpViewModel()
        self.setUpView()
        self.hideLoading()
    }
    
    private func setUpTableView() {
        self.animeDetailTableView.delegate = self
        self.animeDetailTableView.dataSource = self
        self.animeDetailTableView.register(AnimeHeaderCell.nib, forCellReuseIdentifier: AnimeHeaderCell.identifier)
        self.animeDetailTableView.register(AnimeInfoCell.nib, forCellReuseIdentifier: AnimeInfoCell.identifier)
        self.animeDetailTableView.register(AnimeStatsCell.nib, forCellReuseIdentifier: AnimeStatsCell.identifier)
        self.animeDetailTableView.register(AnimeExtrasCell.nib, forCellReuseIdentifier: AnimeExtrasCell.identifier)
    }
    
    private func setUpViewModel() {
        self.discoverAnimeViewModel = DiscoverAnimeViewModel()
        self.myAnimeListViewModel = MyAnimeListViewModel()
        
        self.discoverAnimeViewModel.errorRelay.subscribe(onNext: { (errorString) in
            self.showAlert(title: "Error", message: errorString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
        self.myAnimeListViewModel.errorRelay.subscribe(onNext: { (errorString) in
            self.showAlert(title: "Error", message: errorString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
        self.myAnimeListViewModel.fetchMyAnimeList(animeID: (self.anime?.id)!) { (myAnimeList) in
            self.myAnimeList = myAnimeList
        }
        
        self.discoverAnimeViewModel.fetchAnimePage(animeID: (self.anime?.id)!) { (anime) in
            self.anime = anime
            self.animeDetailTableView.reloadData()
        }
    }
    
    private func setUpView() {
        self.title = self.anime?.titleRomaji!
        
        if let bannerImage = self.anime?.imageUrlBanner {
            self.animeBannerImage.setImage(urlStr: bannerImage)
        } else {
            self.animeBannerImage.setImage(urlStr: (self.anime?.imageUrlLarge)!)
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func menuBtnPressed(_ sender: Any) {
        self.showAlertController()
    }
    
    private func showAlertController() {
        let alert = UIAlertController(title: "Choose option", message: "", preferredStyle: .actionSheet)
        
        let animeListTitle = self.myAnimeList == nil ? "Add to My Anime List" : "Edit My Anime List"
        alert.addAction(UIAlertAction(title: animeListTitle, style: .default, handler: { (action) in
            self.performSegue(withIdentifier: CreateMyAnimeListViewController.identifier, sender: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Review", style: .default, handler: { (action) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Share", style: .default, handler: { (action) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.setBackButton()
        
        switch segue.identifier {
        case CreateMyAnimeListViewController.identifier:
            if let viewController = segue.destination as? CreateMyAnimeListViewController {
                viewController.anime = anime
                viewController.myAnimeList = myAnimeList
            }
        default:
            break
        }
    }
    
    private func setBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
}

extension AnimeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch AnimeDetailSections(rawValue: indexPath.section)! {
        case .detail:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AnimeHeaderCell.identifier) as? AnimeHeaderCell {
                cell.setUpCell(anime: self.anime!)
                return cell
            }
        case .info:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AnimeInfoCell.identifier) as? AnimeInfoCell {
                cell.setUpCell(anime: self.anime!)
                return cell
            }
        case .stats:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AnimeStatsCell.identifier) as? AnimeStatsCell {
                cell.setUpCell(links: self.anime?.externalLinks)
                return cell
            }
        case .extras:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AnimeExtrasCell.identifier) as? AnimeExtrasCell {
                cell.setUpCell(characters: self.anime?.characters, staffs: self.anime?.staff)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch AnimeDetailSections(rawValue: section)! {
        case .info:
            return SectionHeaderView.loadViewFromNib(title: "Info", backgroundColor: AnidesuColor.DarkBlue)
        case .stats:
            return SectionHeaderView.loadViewFromNib(title: "Stats", backgroundColor: AnidesuColor.DarkBlue)
        case .extras:
            return SectionHeaderView.loadViewFromNib(title: "Extras", backgroundColor: AnidesuColor.DarkBlue)
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch AnimeDetailSections(rawValue: section)! {
        case .info, .stats, .extras:
            return 50
        default:
            return 0
        }
    }
}
