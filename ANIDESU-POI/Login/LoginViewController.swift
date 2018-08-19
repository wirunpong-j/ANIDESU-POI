//
//  LoginViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 6/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import FirebaseAuth
import RxCocoa
import RxSwift

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var loginViewModel: LoginViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setUpViewModel()
        self.showLoading()
        if Auth.auth().currentUser != nil {
            self.loginViewModel.getUserData {
                self.hideLoading()
                self.showStoryboard(storyboardName: .Main)
            }
        } else {
            self.hideLoading()
        }
    }
    
    func setUpViewModel() {
        self.loginViewModel = LoginViewModel()
        self.loginViewModel.errorRelay.subscribe(onNext: { (errorString) in
            self.showAlert(title: "Error", message: errorString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        self.loginViewModel.login(email: email, password: password) {
            self.showStoryboard(storyboardName: .Main)
        }
    }
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        self.showStoryboard(storyboardName: .Register)
    }
}
