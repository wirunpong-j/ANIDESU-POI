//
//  CreateMyAnimeListViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 29/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import Eureka
import RxCocoa
import RxSwift
import MBProgressHUD

protocol CreateMyAnimeListDelegate {
    func updateMyAnimeListCompleted()
}

class CreateMyAnimeListViewController: FormViewController {
    static let identifier = "CreateMyAnimeListViewController"
    
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var addBtn: UIBarButtonItem!
    
    var delegate: CreateMyAnimeListDelegate?
    var anime: Anime?
    var myAnimeList: MyAnimeList?
    var viewModel: MyAnimeListViewModel!
    var disposeBag = DisposeBag()
    
    let ALL_STATUS = [MyAnimeListStatus.PlanToWatch.rawValue.capitalized,
                      MyAnimeListStatus.Watching.rawValue.capitalized,
                      MyAnimeListStatus.Completed.rawValue.capitalized,
                      MyAnimeListStatus.Dropped.rawValue.capitalized]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()
        self.setUpViewModel()
        self.setUpView()
    }
    
    private func setUpViewModel() {
        self.viewModel = MyAnimeListViewModel()
        
        self.viewModel.errorRelay.subscribe(onNext: { (errorString) in
            print("Error :" + errorString)
            self.hideLoading()
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
    
    private func setUpView() {
        self.title = self.myAnimeList == nil ? "Add: " + (anime?.titleRomaji)! : "Edit: " + (anime?.titleRomaji)!
        self.addBtn.title = self.myAnimeList == nil ? "Add" : "Edit"
        self.setUpForm()
        self.hideLoading()
    }
    
    private func setUpForm() {
        form +++ Section("Add to My Anime List *")
            <<< PickerInputRow<String>() {
                $0.tag = "status"
                $0.title = "Status"
                $0.options = ALL_STATUS
                $0.value = self.myAnimeList == nil ? ALL_STATUS[0] : (self.myAnimeList?.status?.capitalized)!
            }
            <<< PickerInputRow<Int>() {
                $0.tag = "progress"
                $0.title = "Progress (EP)"
                $0.options = Array(0...(anime?.totalEP)!)
                $0.value = self.myAnimeList == nil ? 0 : self.myAnimeList?.progress!
            }
            <<< PickerInputRow<Int>() {
                $0.tag = "score"
                $0.title = "Score"
                $0.options = Array(0...10)
                $0.value = self.myAnimeList == nil ? 0 : self.myAnimeList?.score!
            }
            +++ Section("Notes (Optional)")
            <<< TextAreaRow() {
                $0.tag = "notes"
                $0.placeholder = "Write your notes..."
                $0.value = self.myAnimeList == nil ? "" : self.myAnimeList?.note!
            }
            +++ Section()
            <<< ButtonRow ("Delete") {
                $0.title = "Delete"
                }.cellUpdate { cell, row in
//                    cell.isHidden = !(self.myAnimeList?.isAdded)!
//                    cell.textLabel?.textColor = UIColor.red
                }.onCellSelection { cell, row in
//                    let alert = UIAlertController(title: "Alert", message: "Are you sure you want to remove this form your list ?", preferredStyle: UIAlertControllerStyle.alert)
//                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
//                        self.removeThisAnimeFormList()
//                    }))
//                    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
        }
        
//        if (myAnimeList?.isAdded)! {
//            navigationItem.title = "Edit: \((myAnimeList?.anime?.title_romaji)!)"
//        } else {
//            navigationItem.title = "Add: \((myAnimeList?.anime?.title_romaji)!)"
//        }
        navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow)
        animateScroll = true
        rowKeyboardSpacing = 20
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        self.showLoading()
        
        let result = form.values()
        let status = result["status"] as? String ?? ""
        let progress = result["progress"] as? Int ?? 0
        let score = result["score"] as? Int ?? 0
        let note = result["notes"] as? String ?? ""
        
        let newList = MyAnimeList(animeID: (anime?.id)!, note: note, status: status.lowercased(), progress: progress, score: score)
        
        self.viewModel.updateMyAnimeList(myAnimeList: newList) {
            self.hideLoading()
            self.dismiss(animated: true, completion: self.delegate?.updateMyAnimeListCompleted)
        }
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CreateMyAnimeListViewController {
    func showLoading() {
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
    }
    
    func hideLoading() {
        MBProgressHUD.hide(for: view, animated: true)
    }
}
