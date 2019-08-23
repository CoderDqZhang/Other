//
//  StoreSegementViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import JXSegmentedView

enum StoreDetailTyp:Int {
    case all = 0
    case income = 2
    case pay = 1
}

class StoreSegementViewController: BaseViewController {

   
    var segmentedViewDataSource: JXSegmentedTitleDataSource!
    var segmentedView: JXSegmentedView!
    var listContainerView: JXSegmentedListContainerView!
    
    var pagingView:JXPagingView!
    var userHeader:StoreView!
    var userHeaderContainerView: UIView!

    var tableHeaderViewHeight: CGFloat = 90
    var heightForHeaderInSection: Int = 44

    let titles = ["全部", "收入", "支出"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "积分明细"
        self.setNavigationItemBack()
    }
    
    
    override func setUpView() {
        
        userHeaderContainerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: CGFloat(tableHeaderViewHeight)))

        userHeader = StoreView(frame: userHeaderContainerView.bounds)
        //设置数据
//        otherViewModel.getUserInfoNet(userId: (postData.object(forKey: "id") as! Int).string)
        userHeader.storeViewClouse = {
            NavigationPushView(self, toConroller: StoreInfoViewController())
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pagingView.frame = self.view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}

extension StoreSegementViewController: JXPagingViewDelegate {
    
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
        let controller = StoreViewController.init()
        controller.initSView(type: index)
        return controller
    }
    
    func mainTableViewDidScroll(_ scrollView: UIScrollView) {
//        userHeader?.scrollViewDidScroll(contentOffsetY: scrollView.contentOffset.y)
    }
}
