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

typealias SearchResultDicClouse = (_ dic:NSDictionary) -> Void

typealias PostDetailDataClouse =  (_ obj:NSMutableDictionary, _ type:PostType, _ indexPath:IndexPath?) ->Void

typealias ScoreDetailDataClouse =  (_ obj:NSMutableDictionary, _ type:ScoreDetailVC, _ scoreType:ScoreDetailTypeVC, _ indexPath:IndexPath?) ->Void


typealias SetUpLoadMoreDataClouse = () ->Void

typealias ReloadDataClouse = () ->Void

class BaseViewController: UIViewController {

    var tableView:UITableView!
    var viewModel:BaseViewModel?
    
    var umengPageName:String! = ""
    
    var resultDicClouse:SearchResultDicClouse!
    var reloadDataClouse:ReloadDataClouse!
    var postDetailDataClouse:PostDetailDataClouse!
    
    var scoreDetailDataClouse:ScoreDetailDataClouse!
    
    var setUpLoadMoreDataClouse:SetUpLoadMoreDataClouse!
    
    var listViewDidScrollCallback: ((UIScrollView) -> ())?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = App_Theme_F6F6F6_Color
        
        self.setUpView()
        self.bindViewModelLogic()
        self.setUpViewNavigationItem()
        self.navigationController?.fd_fullscreenPopGestureRecognizer.isEnabled = true
        self.setupBaseViewForDismissKeyboard()
        //处于第一个Item 允许返回
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
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
    
    func getControllerView() ->UIView {
        return self.view
    }
    
    func bindViewodelResultData(_ resultData:NSMutableArray){
        if self.viewModel != nil {
            self.viewModel!.resultData = resultData
        }
    }
    
    func setUpTableView(style:UITableView.Style, cells:[AnyClass], controller:UIViewController?){
        tableView = UITableView.init(frame: CGRect.zero, style: style)
        for cell in cells{
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
        self.tableView.emptyDataSetSource = viewModel
        self.tableView.emptyDataSetDelegate = viewModel
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
        if viewModel?.resultData != nil {
            viewModel?.resultData = self.viewModel?.resultData
        }
        viewModel?.controller = controller
    }
    
    func changeTableViewFrame(frame:CGRect) {
        tableView.frame = frame
    }
    
    func setUpRefreshData(refresh:@escaping MJRefreshComponentRefreshingBlock){
        if self.tableView != nil {
            let header = MJRefreshGifHeader.init {
                refresh()
            }
            var download:[UIImage] = []
            for index in 1...12 {
                download.append(UIImage.init(named: "ic_baodian_downloading\(index)")!)
            }
            header?.lastUpdatedTimeLabel.isHidden = true
            header?.stateLabel.isHidden = true
            header?.setImages(download, duration: 0.5, for: MJRefreshState.idle)
//            header?.setImages(download, for: MJRefreshState.pulling)
            header?.setImages(download, duration: 0.5, for: MJRefreshState.pulling)
//            header?.setImages(download, for: MJRefreshState.refreshing)
            self.tableView.mj_header = header
        }
        
    }
    
    func stopRefresh(){
        if self.tableView != nil && self.tableView.mj_header != nil {
            self.tableView.mj_header.endRefreshing()
        }
        if self.tableView != nil && self.tableView.mj_footer != nil {
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
    func setUpLoadMoreData(refresh:@escaping MJRefreshComponentRefreshingBlock){
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            refresh()
        })
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

extension BaseViewController: JXPagingViewListViewDelegate {
    public func listView() -> UIView {
        return self.view
    }
    
    public func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.listViewDidScrollCallback = callback
    }
    
    public func listScrollView() -> UIScrollView {
        return self.tableView
    }
    
    public func listDidDisappear() {
        print("listDidDisappear")
    }
    
    public func listDidAppear() {
        print("listDidAppear")
    }
}

//处于第一个Item 允许返回
extension BaseViewController : UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}

