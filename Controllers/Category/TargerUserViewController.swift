//
//  TargerUserViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/15.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class TargerUserViewController: BaseViewController {

    var targetViewModel = TargerUserViewModel.init()
    var searchController:UISearchController!
    
    var searchBar:UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.setNavigationItemBack()
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: targetViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [TargerUserInfoTableViewCell.self,TagerUserTableViewCell.self], controller: self)
        self.setUpSearchController()
    }
    
    func setUpSearchController(){
        // 创建searchResultVC
        let searchResultVC = UIViewController()
//        searchResultVC.definesPresentationContext = true
        // 设置背景颜色为红色
        searchResultVC.view.backgroundColor = UIColor.red
        searchController = UISearchController(searchResultsController: searchResultVC)
        // 设置背景颜色
        searchController.view.backgroundColor = .red
        searchController.searchBar.barTintColor = App_Theme_F6F6F6_Color
        searchController.searchBar.layer.borderColor = App_Theme_F6F6F6_Color?.cgColor
        searchController.searchBar.backgroundImage = UIImage.init()
        searchController.delegate = self
        searchController.searchBar.delegate = self
        // 默认为YES,设置开始搜索时背景显示与否
         searchController.dimsBackgroundDuringPresentation = false
        // 默认为YES,控制搜索时，是否隐藏导航栏
//         searchController.hidesNavigationBarDuringPresentation = true
        // 将搜索框视图设置为tableView的tableHeaderView
        self.tableView.tableHeaderView = searchController.searchBar
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

extension TargerUserViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) // called when text starts editing\
    {
        NavigaiontPresentView(self, toController: searchController)
        searchBar.showsCancelButton = true
    }
    // called when text ends editing
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar){
        searchBar.showsCancelButton = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) // called when text changes (including clear)
    {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) // called when keyboard search button pressed
    {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) // called when cancel button pressed
    {
        
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) // called when search results button pressed
    {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
}

extension TargerUserViewController : UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
