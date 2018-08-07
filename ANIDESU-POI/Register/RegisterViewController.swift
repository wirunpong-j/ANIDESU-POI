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
    
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var imageView: ImageRoundView!
    
    let imagePicker = UIImagePickerController()
    var registerViewModel: RegisterViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUpViewModel()
        setUpNavBar()
    }
    
    func setDelegate() {
        imagePicker.delegate = self
    }
    
    func setUpViewModel() {
        registerViewModel = RegisterViewModel()
        registerViewModel.errorRelay.subscribe(onNext: { (errorString) in
            self.showAlert(title: "Error", message: errorString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    func setUpNavBar() {
        self.title = "Create Account"
        
        // Create Submit Button
        let submitBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        submitBtn.setTitle("Submit", for: .normal)
        submitBtn.setTitleColor(AnidesuColor.DarkBlue.color(), for: .normal)
        submitBtn.setTitleColor(AnidesuColor.Blue.color(), for: .highlighted)
        submitBtn.addTarget(self, action: #selector(self.submitBtnPressed), for: .touchUpInside)
        
        let submitButtonItem = UIBarButtonItem(customView: submitBtn)
        self.navigationItem.rightBarButtonItem = submitButtonItem
    }
    
    @objc func submitBtnPressed() {
        let displayName = displayNameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let rePassword = rePasswordTextField.text!
        let image = imageView.image!
        
        if password == rePassword {
            registerViewModel.register(displayName: displayName, email: email, password: password, image: image) {
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            self.showAlert(title: "Error", message: "Password and Re-Password not match.")
        }
    }

    @IBAction func selectImgBtnPressed(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFill
            imageView.image = pickedImage
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
