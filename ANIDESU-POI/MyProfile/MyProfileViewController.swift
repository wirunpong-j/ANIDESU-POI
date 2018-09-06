//
//  MyProfileViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 3/9/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Hero

class MyProfileViewController: BaseViewController {
    @IBOutlet weak var profileTableView: UITableView!
    
    var viewModel: MyAccountViewModel!
    var disposeBag = DisposeBag()
    var tempHeroID: String?
    
    private enum Sections: Int {
        case MyProfileImage, ProfileData
    }
    
    private enum Rows: Int {
        case DisplayName, Email, About
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()
        self.setUpViewModel()
    }
    
    private func setUpTableView() {
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
    }
    
    private func setUpViewModel() {
        self.viewModel = MyAccountViewModel()
        
        self.viewModel.errorRelay.subscribe(onNext: { (errorString) in
            self.showAlert(title: "Error", message: errorString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
    
    @IBAction func optionBtnPressed(_ sender: Any) {
        self.showAlertController()
    }
    
    private func showAlertController() {
        let alert = UIAlertController(title: "Choose option", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Edit Profile", style: .default, handler: { (action) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { (action) in
            self.logOut()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func logOut() {
        self.viewModel.logout {
            self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MyProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Sections(rawValue: section)! {
        case .MyProfileImage:
            return 1
        case .ProfileData:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Sections(rawValue: indexPath.section)! {
        case .MyProfileImage:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MyProfileImageCell.identifier) as? MyProfileImageCell {
                cell.profileImage.hero.id = "profileImage"
                return cell
            }
        case .ProfileData:
            return self.getProfileDataCell(tableView: tableView, row: indexPath.row)
        }
        
        return UITableViewCell()
    }
    
    private func getProfileDataCell(tableView: UITableView, row: Int) -> UITableViewCell {
        switch Rows(rawValue: row)! {
        case .DisplayName:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailLabelCell.identifier) as? DetailLabelCell {
                cell.setUpCell(header: "Display Name", desc: MyProfileModel.instance.displayName)
                cell.setUpColor(background: .MiddleDarkBlue, header: .White, desc: .DarkGray)
                return cell
            }
        case .Email:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailLabelCell.identifier) as? DetailLabelCell {
                cell.setUpCell(header: "Email", desc: MyProfileModel.instance.email)
                cell.setUpColor(background: .MiddleDarkBlue, header: .White, desc: .DarkGray)
                return cell
            }
        case .About:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MoreDetailLabelCell.identifier) as? MoreDetailLabelCell {
                cell.setUpCell(header: "About", desc: MyProfileModel.instance.about)
                cell.setUpColor(background: .MiddleDarkBlue, header: .White, desc: .DarkGray)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Sections(rawValue: indexPath.section)! {
        case .MyProfileImage:
            return UITableViewAutomaticDimension
        
        case .ProfileData:
            switch Rows(rawValue: indexPath.row)! {
            case .DisplayName, .Email:
                return 45
            case .About:
                return UITableViewAutomaticDimension
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 50))
        view.backgroundColor = AnidesuColor.DarkBlue.color()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
}
