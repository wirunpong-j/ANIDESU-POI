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

class CreateMyAnimeListViewController: FormViewController {
    static let identifier = "CreateMyAnimeListViewController"
    
    @IBOutlet weak var addBtn: UIBarButtonItem!
    
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
        self.setUpViewModel()
        self.setUpView()
    }
    
    private func setUpViewModel() {
        self.viewModel = MyAnimeListViewModel()
        
        self.viewModel.errorRelay.subscribe(onNext: { (errorString) in
            print("Error :" + errorString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
        self.viewModel.isLoading.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoading()
            } else {
                self.hideLoading()
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
    
    private func setUpView() {
        self.navigationController?.navigationBar.tintColor = AnidesuColor.White.color()
        self.title = self.myAnimeList == nil ? "Add: " + (anime?.titleRomaji)! : "Edit: " + (anime?.titleRomaji)!
        self.addBtn.title = self.myAnimeList == nil ? "Add" : "Edit"
        self.setUpForm()
    }
    
    private func setUpForm() {
        self.tableView.backgroundColor = AnidesuColor.DarkBlue.color()
            
        form +++ Section("Add to My Anime List *")
            <<< PickerInputRow<String>() {
                $0.tag = "status"
                $0.title = "Status"
                $0.options = ALL_STATUS
                $0.value = self.myAnimeList == nil ? ALL_STATUS[0] : (self.myAnimeList?.status.capitalized)!
                $0.cell.backgroundColor = AnidesuColor.MiddleDarkBlue.color()
                $0.cell.detailTextLabel?.textColor = AnidesuColor.DarkGray.color()
                $0.cellUpdate({ (cell, row) in
                    cell.textLabel?.textColor = AnidesuColor.White.color()
                })
            }
            <<< PickerInputRow<Int>() {
                $0.tag = "progress"
                $0.title = "Progress (EP)"
                $0.options = Array(0...(anime?.totalEP)!)
                $0.value = self.myAnimeList == nil ? 0 : self.myAnimeList?.progress
                $0.cell.backgroundColor = AnidesuColor.MiddleDarkBlue.color()
                $0.cell.detailTextLabel?.textColor = AnidesuColor.DarkGray.color()
                $0.cellUpdate({ (cell, row) in
                    cell.textLabel?.textColor = AnidesuColor.White.color()
                })
            }
            <<< PickerInputRow<Int>() {
                $0.tag = "score"
                $0.title = "Score"
                $0.options = Array(0...10)
                $0.value = self.myAnimeList == nil ? 0 : self.myAnimeList?.score
                $0.cell.backgroundColor = AnidesuColor.MiddleDarkBlue.color()
                $0.cell.detailTextLabel?.textColor = AnidesuColor.DarkGray.color()
                $0.cellUpdate({ (cell, row) in
                    cell.textLabel?.textColor = AnidesuColor.White.color()
                })
            }
            +++ Section("Notes (Optional)")
            <<< TextAreaRow() {
                $0.tag = "notes"
                $0.placeholder = "Write your notes..."
                $0.value = self.myAnimeList == nil ? "" : self.myAnimeList?.note
                $0.cell.backgroundColor = AnidesuColor.MiddleDarkBlue.color()
                $0.cell.textView.backgroundColor = AnidesuColor.MiddleDarkBlue.color()
                $0.cell.placeholderLabel?.textColor = AnidesuColor.DarkGray.color()
                $0.cell.textView.textColor = AnidesuColor.White.color()
                
                $0.cellUpdate({ (textAreaCell, textAreaRow) in
                    textAreaCell.textView.textColor = AnidesuColor.White.color()
                })
            }
            +++ Section()
            <<< ButtonRow ("Delete") {
                $0.title = "Delete"
                }.cellUpdate { cell, row in
                    cell.isHidden = self.myAnimeList == nil ? true : false
                    cell.textLabel?.textColor = UIColor.red
                    cell.backgroundColor = AnidesuColor.MiddleDarkBlue.color()
                }.onCellSelection { cell, row in
                    let alert = UIAlertController(title: "Alert", message: "Are you sure you want to remove this form your list ?", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                        self.removeMyAnimeList()
                    }))
                    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
        navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow)
        animateScroll = true
        rowKeyboardSpacing = 20
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        let newList = MyAnimeList(animeID: (anime?.id)!, form: form.values())
        
        self.viewModel.updateMyAnimeList(myAnimeList: newList) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func removeMyAnimeList() {
        self.viewModel.removeMyAnimeList(animeID: (anime?.id)!) {
            self.navigationController?.popViewController(animated: true)
        }
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
