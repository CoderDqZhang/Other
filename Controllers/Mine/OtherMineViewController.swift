//
//  OtherMineViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/20.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import JXSegmentedView

class OtherMineViewController: BaseViewController {

    var pagingView:JXPagingView!
    var userHeader:GloabelHeader!
    var userHeaderContainerView: UIView!
    var segmentedViewDataSource: JXSegmentedTitleDataSource!
    var segmentedView: JXSegmentedView!
    let titles = ["推荐", "发表", "竞猜"]
    var tableHeaderViewHeight: CGFloat = 138
    var heightForHeaderInSection: Int = 44
    
    let recommendVC = RecommendViewController()
    let otherGuessVC = OtherGuessViewController()
    let otherPostVC = OtherPostViewController()
    
    var postData:NSDictionary!
    var otherViewModel = OtherMineViewModel.init()
    
    var gloableNavigationBar:GLoabelNavigaitonBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        let followButton = AnimationButton.init(type: .custom)
        followButton.frame = CGRect.init(x: SCREENWIDTH - 100, y: 0, width: 61, height: 27)
        if #available(iOS 11.0, *) {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: -NAV_HEIGHT/2, width: SCREENWIDTH, height: 64 + NAV_HEIGHT), title: "个人中心", rightButton: followButton, click: { (type) in
                if type == .backBtn{
                    self.navigationController?.popViewController()
                }
            })
        } else {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 64), title: "个人中心", rightButton: followButton, click: { (type) in
                if type == .backBtn{
                    self.navigationController?.popViewController()
                }
            })
            // Fallback on earlier versions
        }
        gloableNavigationBar.rightButtonClouse = { status in
            self.otherViewModel.followNet(userId: (self.postData.object(forKey: "id") as! Int).string, status: status)
        }
        pagingView.pinSectionHeaderVerticalOffset = gloableNavigationBar.height - 64
        self.view.addSubview(gloableNavigationBar)
    }
    
    override func setUpView() {
        if #available(iOS 11.0, *) {
            userHeaderContainerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: CGFloat(tableHeaderViewHeight + NAV_HEIGHT)))
        } else {
             userHeaderContainerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: CGFloat(tableHeaderViewHeight)))
            // Fallback on earlier versions
        }
        userHeader = GloabelHeader(frame: userHeaderContainerView.bounds)
        //设置数据
        otherViewModel.getUserInfoNet(userId: (postData.object(forKey: "id") as! Int).string)
        userHeader.changeToolsButtonType(followed: true)
        userHeader.gloabelHeaderClouse = { status in
            self.otherViewModel.followNet(userId: (self.postData.object(forKey: "id") as! Int).string, status: status)
        }
        userHeaderContainerView.addSubview(userHeader)
        
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedViewDataSource = JXSegmentedTitleDataSource()
        segmentedViewDataSource.titles = titles
        segmentedViewDataSource.titleSelectedColor = App_Theme_06070D_Color!
        segmentedViewDataSource.titleNormalColor = App_Theme_999999_Color!
        segmentedViewDataSource.isTitleColorGradientEnabled = true
        segmentedViewDataSource.isTitleZoomEnabled = false
        segmentedViewDataSource.reloadData(selectedIndex: 1)
        
        segmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: CGFloat(heightForHeaderInSection)))
        segmentedView.backgroundColor = App_Theme_FFFFFF_Color
        segmentedView.defaultSelectedIndex = 1
        segmentedView.dataSource = segmentedViewDataSource
        segmentedView.isContentScrollViewClickTransitionAnimationEnabled = true
        
        let lineView = JXSegmentedIndicatorLineView()
        lineView.indicatorColor = App_Theme_FFD512_Color!
        lineView.indicatorWidth = 26
        segmentedView.indicators = [lineView]
        
        pagingView = JXPagingView(delegate: self)
        
        self.view.addSubview(pagingView)
        
        segmentedView.contentScrollView = pagingView.listContainerView.collectionView
    }

    override func bindViewModelLogic() {
        self.bindViewModel(viewModel: otherViewModel, controller: self)
        self.recommendVC.postDetailDataClouse = { data, type in
            self.otherViewModel.pushPostDetailViewController(data, type)
        }
        
        self.otherPostVC.postDetailDataClouse = { data, type in
            self.otherViewModel.pushPostDetailViewController(data, type)
        }
        
        self.otherGuessVC.postDetailDataClouse = { data, type in
            self.otherViewModel.pushPostDetailViewController(data, type)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pagingView.frame = self.view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
   
}


extension OtherMineViewController: JXPagingViewDelegate {
    
    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        return Int(tableHeaderViewHeight)
    }
    
    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        return userHeaderContainerView
    }
    
    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        return heightForHeaderInSection
    }
    
    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        return segmentedView
    }
    
    func numberOfLists(in pagingView: JXPagingView) -> Int {
        return titles.count
    }
    
    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        switch index {
        case 0:
            recommendVC.initSView(dic: self.postData)
            return recommendVC
        case 1:
            otherPostVC.initSView(dic: self.postData)
            return otherPostVC
        default:
            otherGuessVC.initSView(dic: self.postData)
            return otherGuessVC
        }
    }
    
    func mainTableViewDidScroll(_ scrollView: UIScrollView) {
        userHeader?.scrollViewDidScroll(contentOffsetY: scrollView.contentOffset.y)
        
        var alpa:CGFloat = 0
        if #available(iOS 11.0, *) {
            alpa = scrollView.contentOffset.y / (tableHeaderViewHeight - 64 - NAV_HEIGHT)
        } else {
            alpa = scrollView.contentOffset.y / (tableHeaderViewHeight - 64)
            // Fallback on earlier versions
        }
        gloableNavigationBar.rigthButton.isHidden = scrollView.contentOffset.y > 80 ? false : true

        self.gloableNavigationBar.changeBackGroundColor(transparency: alpa > 1 ? 1 :alpa)
    }
}
