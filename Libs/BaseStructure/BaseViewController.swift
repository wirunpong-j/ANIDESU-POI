//
//  BaseViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 6/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import MBProgressHUD

public enum AnidesuStoryboard {
    case Login
    case Main
    case Register
    
    func getName() -> String {
        switch self {
        case .Login: return "Login"
        case .Main: return "Main"
        case .Register: return "Register"
        }
    }
}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackNavigationItem()
    }
    
    func setBackNavigationItem() {
        if self.navigationController?.viewControllers.count ?? 0 > 0 {
            // BarButtonItems
            let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            backButton.setTitle("Cancel", for: .normal)
            backButton.setTitleColor(AnidesuColor.DarkBlue.color(), for: .normal)
            backButton.setTitleColor(AnidesuColor.Blue.color(), for: .highlighted)
            backButton.addTarget(self, action: #selector(self.backBtnPressed), for: .touchUpInside)
            
            let backButtonItem = UIBarButtonItem(customView: backButton)
            self.navigationItem.leftBarButtonItem = backButtonItem
        }
    }
    
    @objc func backBtnPressed() {
        if let navBar = self.navigationController, navBar.viewControllers.first != self {
            navBar.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
    
    func showLoading() {
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
    }
    
    func hideLoading() {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    func showStoryboard(storyboardName: AnidesuStoryboard) {
        let storyboard = UIStoryboard(name: storyboardName.getName(), bundle: nil)
        let vc = storyboard.instantiateInitialViewController()!
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showAlert(title: String, message: String, completion handler: @escaping (()->()) ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction((UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            handler()
        })))
        self.present(alert, animated: true)
    }

}
