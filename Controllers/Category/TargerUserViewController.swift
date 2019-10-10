//
//  TargerUserViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/15.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

typealias TargerUserViewControllerClouse = (_ dic:NSDictionary) ->Void

class TargerUserViewController: BaseViewController {

    var targetViewModel = TargerUserViewModel.init()
    var searchController = BaseSearchViewController()
    
    var targerUserViewControllerClouse:TargerUserViewControllerClouse!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.setNavigationItemBack()
        self.navigationItem.title = "我要@"
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: targetViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [TargerUserInfoTableViewCell.self,TagerUserTableViewCell.self], controller: self)
        self.setUpSearchController()
    }
    
    func setUpSearchController(){
        // 创建searchResultVC
        self.definesPresentationContext = true
        let targerVC = TargerUserSearchViewController()
        targerVC.resultDicClouse = { dic in
            print(dic)
            self.resultDicNavigationController(dic)
        }
        searchController = BaseSearchViewController.init(searchResultsController: targerVC)
        searchController.rootController = self
        searchController.searchType = .follows
        searchController.searchBar.delegate = searchController
        searchController.setUpView()
        self.tableView.tableHeaderView = searchController.searchBar
    }
    
    func resultDicNavigationController(_ dic:NSDictionary){
        if self.targerUserViewControllerClouse != nil {
            self.targerUserViewControllerClouse(dic)
        }
        self.navigationController?.popViewController()
    }

    /*
    // MARK: - Navigation
xxx
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

