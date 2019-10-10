//
//  CategoryChoosViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/24.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

typealias CategoryChoosViewControllerClouse = (_ dic:NSDictionary) ->Void

class CategoryChoosViewController: BaseViewController {

    var categoryChossViewModel = CategoryChossViewModel.init()
    var searchController = BaseSearchViewController()
    
    var categoryChoosViewControllerClouse:CategoryChoosViewControllerClouse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.setNavigationItemBack()
        self.navigationItem.title = "选择部落"
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: categoryChossViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [TargerUserInfoTableViewCell.self,TagerUserTableViewCell.self], controller: self)
        self.setUpSearchController()
    }
    
    func setUpSearchController(){
        // 创建searchResultVC
        self.definesPresentationContext = true
        let categoryVC = CategoryChoosSearchViewController()
        categoryVC.resultDicClouse = { dic in
            self.resultDicNavigationController(dic)
        }
        searchController = BaseSearchViewController.init(searchResultsController: categoryVC)
        searchController.rootController = self
        searchController.searchType = .category
        searchController.searchBar.delegate = searchController
        searchController.setUpView()
        self.tableView.tableHeaderView = searchController.searchBar
    }
    
    func resultDicNavigationController(_ dic:NSDictionary){
        if self.categoryChoosViewControllerClouse != nil {
            self.categoryChoosViewControllerClouse(dic)
        }
        self.navigationController?.popViewController()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
