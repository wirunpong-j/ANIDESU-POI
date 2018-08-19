//
//  DiscoverAnimeMenuViewController
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 19/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import Tabman
import Pageboy
import RxSwift
import RxCocoa

class DiscoverAnimeMenuViewController: TabmanViewController, PageboyViewControllerDataSource {
    
    var discoverAnimeViewModel: DiscoverAnimeViewModel!
    let disposeBag = DisposeBag()
    var menuViewController = [UIViewController]()
    let ALL_SEASON = [AnimeSeason.Winter, AnimeSeason.Spring, AnimeSeason.Fall, AnimeSeason.Summer]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViewModel()
        self.setUpView()
    }
    
    func setUpViewModel() {
        self.discoverAnimeViewModel = DiscoverAnimeViewModel()
        self.discoverAnimeViewModel.errorRelay.subscribe(onNext: { (errorString) in
            print("ERROR: \(errorString)")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
    
    func setUpView() {
        self.dataSource = self
        self.bar.items = [Item(title: ALL_SEASON[0].rawValue.uppercased()),
                          Item(title: ALL_SEASON[1].rawValue.uppercased()),
                          Item(title: ALL_SEASON[2].rawValue.uppercased()),
                          Item(title: ALL_SEASON[3].rawValue.uppercased())]
        self.bar.style = .scrollingButtonBar
        self.bar.appearance = TabmanBar.Appearance({ (appearance) in
            // customize appearance here
            appearance.state.selectedColor = AnidesuColor.Green.color()
            appearance.state.color = AnidesuColor.White.color()
            appearance.indicator.color = AnidesuColor.Green.color()
            appearance.indicator.lineWeight = .thick
            appearance.style.background = .solid(color: AnidesuColor.DarkBlue.color())
            appearance.text.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
            appearance.layout.minimumItemWidth = 100
        })
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1336890757, green: 0.1912626624, blue: 0.2462295294, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        tabBarController?.tabBar.backgroundColor = #colorLiteral(red: 0.1336890757, green: 0.1912626624, blue: 0.2462295294, alpha: 1)
        
        self.fetchAnimeBySeason()
    }
    
    func fetchAnimeBySeason() {
        self.discoverAnimeViewModel.fetchAnimeAllSeason(currentViewController: self) { (menuViewController) in
            self.menuViewController = menuViewController
            self.reloadPages()
        }
    }

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return self.menuViewController.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return self.menuViewController[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

}
