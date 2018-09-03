//
//  RegisterViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 7/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa

class RegisterViewController: BaseViewController {
    static let identifier = "RegisterViewController"
    
    @IBOutlet weak var displayNameTextField: AnidesuTextField!
    @IBOutlet weak var emailTextField: AnidesuTextField!
    @IBOutlet weak var passwordTextField: AnidesuTextField!
    @IBOutlet weak var rePasswordTextField: AnidesuTextField!
    @IBOutlet weak var imageView: ImageRoundView!
    
    let imagePicker = UIImagePickerController()
    var viewModel: RegisterViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViewModel()
    }
    
    func setUpViewModel() {
        self.imagePicker.delegate = self
        self.viewModel = RegisterViewModel()
        
        self.viewModel.errorRelay.subscribe(onNext: { (errorString) in
            self.showAlert(title: "Error", message: errorString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        self.viewModel.isLoading.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoading()
            } else {
                self.hideLoading()
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        let displayName = displayNameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let rePassword = rePasswordTextField.text!
        let image = imageView.image!
        
        if password == rePassword {
            self.viewModel.register(displayName: displayName, email: email, password: password, image: image) {
                self.showAlert(title: "Success", message: "Register Completed.", completion: {
                    self.dismiss(animated: true, completion: nil)
                })
            }
        } else {
            self.showAlert(title: "Error", message: "Password and Re-Password not match.")
        }
    }

    @IBAction func selectImgBtnPressed(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFill
            imageView.image = pickedImage
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
