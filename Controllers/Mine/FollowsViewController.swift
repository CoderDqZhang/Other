//
//  FollowsViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class FollowsViewController: BaseViewController {

    let followViewModel = FollowViewModel.init()
    var targerUserViewControllerClouse:TargerUserViewControllerClouse!
    
    var searchController = BaseSearchViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.setNavigationItemBack()
        self.navigationItem.title = "我的关注"
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: followViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [GloabelFansTableViewCell.self], controller: self)
        self.tableView.backgroundColor = App_Theme_F6F6F6_Color
        self.setUpSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
    
    func refreshResultData(){
        followViewModel.reslutArray = self.viewModel?.resultData
        self.tableView.reloadData()
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
