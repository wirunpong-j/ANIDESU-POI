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
import Hero

class AnimeDetailViewController: BaseViewController {
    static let identifier = "AnimeDetailViewController"
    
    @IBOutlet weak var animeDetailTableView: UITableView!
    @IBOutlet weak var animeBannerImage: UIImageView!
    
    var discoverAnimeViewModel: DiscoverAnimeViewModel!
    var myAnimeListViewModel: MyAnimeListViewModel!
    var reviewViewModel: ReviewViewModel!
    var disposeBag = DisposeBag()
    
    var anime: Anime?
    var myAnimeList: MyAnimeList?
    var review: Review?
    var tempHeroID: MyHeroTransition?
    
    private enum AnimeDetailSections: Int {
        case detail, info, stats, extras
    }
    
    private enum AlertButton {
        case myAnimeList, review, share, cancel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setHeroTransition()
        self.setUpTableView()
        self.setUpViewModel()
        self.setUpView()
    }
    
    private func setHeroTransition() {
        self.navigationController?.hero.isEnabled = true
        self.navigationController?.hero.navigationAnimationType = .selectBy(presenting: .pageIn(direction: .left), dismissing: .pageOut(direction: .right))
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
        self.reviewViewModel = ReviewViewModel()
        
        self.discoverAnimeViewModel.errorRelay.subscribe(onNext: { (errorString) in
            self.showAlert(title: "Error", message: errorString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
        self.myAnimeListViewModel.errorRelay.subscribe(onNext: { (errorString) in
            self.showAlert(title: "Error", message: errorString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
        self.reviewViewModel.errorRelay.subscribe(onNext: { (errorString) in
            self.showAlert(title: "Error", message: errorString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
        self.myAnimeListViewModel.isLoading.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoading()
            } else {
                self.hideLoading()
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
        self.reviewViewModel.isLoading.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoading()
            } else {
                self.hideLoading()
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
        self.discoverAnimeViewModel.isLoading.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoading()
            } else {
                self.hideLoading()
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
        self.myAnimeListViewModel.fetchMyAnimeList(animeID: (self.anime?.id)!) { (myAnimeList) in
            self.myAnimeList = myAnimeList
        }
        
        self.reviewViewModel.fetchReviewPage(animeID: (self.anime?.id)!) { (review) in
            self.review = review
        }
        
        self.discoverAnimeViewModel.fetchAnimePage(animeID: (self.anime?.id)!) { (anime) in
            self.anime = anime
            self.animeDetailTableView.reloadData()
        }
    }
    
    private func setUpView() {
        self.title = self.anime?.titleRomaji
        self.animeBannerImage.setImage(urlStr: (self.anime?.imageUrlBanner)!)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func menuBtnPressed(_ sender: Any) {
        self.showAlertController()
    }
    
    private func showAlertController() {
        let alert = UIAlertController(title: "Choose option", message: "", preferredStyle: .actionSheet)
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = AnidesuColor.MiddleDarkBlue.color()
        alert.view.tintColor = AnidesuColor.Blue.color()
        
        alert.addAction(createAlertAction(alertButton: .myAnimeList))
        alert.addAction(createAlertAction(alertButton: .review))
        alert.addAction(createAlertAction(alertButton: .share))
        alert.addAction(createAlertAction(alertButton: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func createAlertAction(alertButton: AlertButton) -> UIAlertAction {
        var alertAction = UIAlertAction()
        
        switch alertButton {
        case .myAnimeList:
            let animeListTitle = self.myAnimeList == nil ? "Add to My Anime List" : "Edit My Anime List"
            alertAction = UIAlertAction(title: animeListTitle, style: .default, handler: { (action) in
                self.performSegue(withIdentifier: CreateMyAnimeListViewController.identifier, sender: nil)
            })
        case .review:
            let reviewTitle = self.review == nil ? "Review" : "Edit Review"
            alertAction = UIAlertAction(title: reviewTitle, style: .default, handler: { (action) in
                self.performSegue(withIdentifier: CreateReviewViewController.identifier, sender: nil)
            })
        case .share:
            alertAction = UIAlertAction(title: "Share", style: .default, handler: { (action) in
                
            })
        case .cancel:
            alertAction = UIAlertAction(title: "Cancel", style: .cancel)
            if let cancelBackgroundViewType = NSClassFromString("_UIAlertControlleriOSActionSheetCancelBackgroundView") as? UIView.Type {
                cancelBackgroundViewType.appearance().subviewsBackgroundColor = AnidesuColor.MiddleDarkBlue.color()
            }
        }
        
        return alertAction
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.setBackButton()
        
        switch segue.identifier {
        case CreateMyAnimeListViewController.identifier:
            if let viewController = segue.destination as? CreateMyAnimeListViewController {
                viewController.anime = self.anime
                viewController.myAnimeList = self.myAnimeList
            }
        case CreateReviewViewController.identifier:
            if let viewController = segue.destination as? CreateReviewViewController {
                viewController.anime = self.anime
                viewController.review = self.review
            }
        default:
            break
        }
    }
    
    private func setBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        backItem.tintColor = AnidesuColor.Blue.color()
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
                cell.coverImage.hero.id = self.tempHeroID?.id
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
            return SectionHeaderView.loadViewFromNib(title: "Info", backgroundColor: .Blue, contentViewColor: .DarkBlue)
        case .stats:
            return SectionHeaderView.loadViewFromNib(title: "Stats", backgroundColor: .Blue, contentViewColor: .DarkBlue)
        case .extras:
            return SectionHeaderView.loadViewFromNib(title: "Extras", backgroundColor: .Blue, contentViewColor: .DarkBlue)
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

fileprivate extension UIView {
    private struct AssociatedKey {
        static var subviewsBackgroundColor = "subviewsBackgroundColor"
    }
    
    @objc dynamic var subviewsBackgroundColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.subviewsBackgroundColor) as? UIColor
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKey.subviewsBackgroundColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            subviews.forEach { $0.backgroundColor = newValue }
        }
    }
}