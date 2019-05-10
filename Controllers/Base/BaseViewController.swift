//
//  BaseViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh
import DZNEmptyDataSet
import FDFullscreenPopGesture

class BaseViewController: UIViewController {

    var tableView:UITableView!
    var viewModel:BaseViewModel?
    var umengPageName:String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = App_Theme_F6F6F6_Color
        
        
        self.setUpView()
        self.bindViewModelLogic()
        self.setUpViewNavigationItem()
        self.navigationController?.fd_fullscreenPopGestureRecognizer.isEnabled = true
        self.setupBaseViewForDismissKeyboard()
        // Do any additional setup after loading the view.
    }
    
    func setupBaseViewForDismissKeyboard(){
        self.setupForDismissKeyboard()
    }
    
    func viewControllerSetNavigationItemBack(){
        self.setNavigationItemBack()
    }
    
    func setUpViewNavigationItem(){}
    func setUpView(){}
    
    func bindViewModelLogic(){}
    
    func setUpTableView(style:UITableView.Style, cells:[AnyClass], controller:UIViewController?){
        tableView = UITableView.init(frame: CGRect.zero, style: style)
        for cell in cells{
            print(cell.description())
            tableView.register(cell.self, forCellReuseIdentifier: "\(cell.description())")
        }
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 49, right: 0)
            tableView.scrollIndicatorInsets = tableView.contentInset
        }
        self.tableView.contentInset.top = 0
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.separatorStyle = .none
        controller?.view.addSubview(tableView)
        tableView.delegate = viewModel as? UITableViewDelegate
        tableView.dataSource = viewModel as? UITableViewDataSource
        self.tableView.backgroundColor = App_Theme_F6F6F6_Color
        tableView.keyboardDismissMode = .onDrag
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo((controller?.view.snp.top)!).offset(0)
            make.left.equalTo((controller?.view.snp.left)!).offset(0)
            make.right.equalTo((controller?.view.snp.right)!).offset(0)
            make.bottom.equalTo((controller?.view.snp.bottom)!).offset(0)
        }
        
    }
    
    
    func bindViewModel(viewModel:BaseViewModel?, controller: BaseViewController?){
        self.viewModel = viewModel
        viewModel?.controller = controller
    }
    
    func changeTableViewFrame(frame:CGRect) {
        tableView.frame = frame
    }
    
    func setUpRefreshData(refresh:@escaping MJRefreshComponentRefreshingBlock){
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
        })
    }
    
    func stopRefresh(){
        self.tableView.mj_header.endRefreshing()
    }
    
    func setUpLoadMoreData(refresh:@escaping MJRefreshComponentRefreshingBlock){
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            refresh()
        })
    }
    
    func stopLoadMoreData(){
        self.tableView.mj_footer.endRefreshing()
    }
    
    func getViewModel(){
        
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
