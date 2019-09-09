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

    var tableHeaderViewHeight: CGFloat = 148
    var heightForHeaderInSection: Int = 44

    let storeViewModel = StoreSegmentViewModel.init()
    
    var gloableNavigationBar:GLoabelNavigaitonBar!

    
    let titles = ["全部", "收入", "支出"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        if #available(iOS 11.0, *) {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: -NAV_HEIGHT/2, width: SCREENWIDTH, height: 64 + NAV_HEIGHT), title: "积分明细", rightButton: nil, click: { (type) in
                if type == .backBtn{
                    self.navigationController?.popViewController()
                }
            })
        } else {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 64), title: "积分明细", rightButton: nil, click: { (type) in
                if type == .backBtn{
                    self.navigationController?.popViewController()
                }
            })
            // Fallback on earlier versions
        }
        pagingView.pinSectionHeaderVerticalOffset = gloableNavigationBar.height - 64
        self.view.addSubview(gloableNavigationBar)
    }
    
    
    override func setUpView() {
        if #available(iOS 11.0, *) {
            userHeaderContainerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: CGFloat(tableHeaderViewHeight + NAV_HEIGHT / 2)))
        } else {
            // Fallback on earlier versions
             userHeaderContainerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: CGFloat(tableHeaderViewHeight)))
        }

        userHeader = StoreView(frame: userHeaderContainerView.bounds)
        //设置数据
        storeViewModel.controller = self
        storeViewModel.getAccountInfoNet()
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
        
        //增加底部边框
        segmentedView.border(for: App_Theme_F6F6F6_Color!, borderWidth: 1, borderType: UIBorderSideType.bottom)
        
        let lineView = JXSegmentedIndicatorLineView()
        lineView.indicatorColor = App_Theme_FFD512_Color!
        lineView.indicatorWidth = 30
        lineView.verticalOffset = 4
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
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}

extension StoreSegementViewController: JXPagingViewDelegate {
    
    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        if #available(iOS 11.0, *) {
            return Int(tableHeaderViewHeight) - 60 + Int(NAV_HEIGHT)
        } else {
            return Int(tableHeaderViewHeight) - 98
            // Fallback on earlier versions
        }
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
        userHeader?.scrollViewDidScroll(contentOffsetY: scrollView.contentOffset.y)
        self.gloableNavigationBar.changeBackGroundColor(transparency: 1)
    }
}
