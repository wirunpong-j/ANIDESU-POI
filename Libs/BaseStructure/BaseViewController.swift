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
    case MyProfile
    
    var name: String {
        switch self {
        case .Login:
            return "Login"
        case .Main:
            return "Main"
        case .MyProfile:
            return "MyProfile"
        }
    }
}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoading() {
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
    }
    
    func showLoading(message: String) {
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = message
    }
    
    func hideLoading() {
        MBProgressHUD.hide(for: view, animated: true)
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
