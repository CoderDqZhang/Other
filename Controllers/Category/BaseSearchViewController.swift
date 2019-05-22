//
//  BaseSearchViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/16.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit


class BaseSearchViewController: UISearchController {

    var rootController:BaseViewController!
    var originArray = NSMutableArray.init()
    var searchArray = NSMutableArray.init()
    var resultDic:NSDictionary!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setUpView(){
        // 设置背景颜色
        self.view.backgroundColor = App_Theme_F6F6F6_Color
        self.searchBar.barTintColor = App_Theme_F6F6F6_Color
        self.searchBar.layer.borderColor = App_Theme_F6F6F6_Color?.cgColor
        self.searchBar.backgroundImage = UIImage.init()
        self.delegate = self
        self.searchResultsUpdater = self
        // 默认为YES,设置开始搜索时背景显示与否
        self.dimsBackgroundDuringPresentation = true
        // 默认为YES,控制搜索时，是否隐藏导航栏
        self.hidesNavigationBarDuringPresentation = true
        // 将搜索框视图设置为tableView的tableHeaderView
        (self.searchResultsController as! BaseViewController).resultDicClouse = { dic in
            self.isActive = false
            self.isEditing = false
        }
        
    }
    
    func setSarchResultData(_ text:String) {

        let dic = NSMutableArray.init(array: [["name":"这是一个测试数据啦","desc":"lalalala"],["name":"这是一个测试数据啦","desc":"lalalala"],["name":"这是一个测试数据啦","desc":"lalalala"],["name":"这是一个测试数据啦","desc":"lalalala"],])
        (self.searchResultsController as! BaseViewController).bindViewodelResultData(dic)
        ((self.searchResultsController as! BaseViewController) as! TargerUserSearchViewController).refreshResultData()
    }
}

extension BaseSearchViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) // called when text starts editing\
    {
        if !self.isActive {
            self.searchBar.backgroundImage = UIImage.init()
            searchBar.showsCancelButton = true
        }
    }
    // called when text ends editing
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar){
//        searchBar.showsCancelButton = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) // called when text changes (including clear)
    {
        self.setSarchResultData(searchText)
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


extension BaseSearchViewController : UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
    }
}

extension BaseSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        self.searchArray = self.originArray.filter({ (array) -> Bool in
//            return (array as! NSDictionary).contains(where: { (key, value) -> Bool in
//                value=
//            })
//        })
//        self.searchArray = self.originArray.filter { (school) -> Bool in
//            return school.contains(searchController.searchBar.text!)
//        }
    }
}

