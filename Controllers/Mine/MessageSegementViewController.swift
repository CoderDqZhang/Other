//
//  MessageSegementViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import JXSegmentedView

enum NotificationType:Int {
    case system = 0
    case comment = 1
    case commentMe = 2
    case approve = 3
}

class MessageSegementViewController: BaseViewController {

    var segmentedViewDataSource: JXSegmentedDotDataSource!
    var segmentedView: JXSegmentedView!
    var listContainerView: JXSegmentedListContainerView!
    
    let messageViewModel = MessageViewModel.init()

    let titles = ["系统", "评论", "@我的", "点赞"]
    var tableHeaderViewHeight: CGFloat = 138
    var heightForHeaderInSection: Int = 44
    let unreadModel:UnreadMessageModel = CacheManager.getSharedInstance().getUnreadModel()!
    var dotStates:[Bool]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "消息"
        self.setNavigationItemBack()
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: messageViewModel, controller: self)
        dotStates = [unreadModel.violation > 0 ? true : false, unreadModel.commentMine > 0 ? true : false,unreadModel.atMine > 0 ? true : false,unreadModel.approveMine > 0 ? true : false,]
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedViewDataSource = JXSegmentedDotDataSource()
        segmentedViewDataSource.titles = titles
        segmentedViewDataSource.titleSelectedColor = App_Theme_06070D_Color!
        segmentedViewDataSource.titleNormalColor = App_Theme_999999_Color!
        segmentedViewDataSource.isTitleZoomEnabled = false
        segmentedViewDataSource.isTitleColorGradientEnabled = true
        segmentedViewDataSource.dotStates = self.dotStates
        segmentedViewDataSource.reloadData(selectedIndex: 0)
        
        segmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: CGFloat(heightForHeaderInSection)))
        segmentedView.backgroundColor = App_Theme_FFFFFF_Color
        segmentedView.defaultSelectedIndex = 0
        segmentedView.dataSource = segmentedViewDataSource
        segmentedView.isContentScrollViewClickTransitionAnimationEnabled = true
        
        let lineView = JXSegmentedIndicatorLineView()
        lineView.indicatorColor = App_Theme_FFD512_Color!
        lineView.indicatorWidth = 26
        segmentedView.indicators = [lineView]
        
        segmentedView.delegate = self
        
        
        self.view.addSubview(segmentedView)
        
        //5、初始化JXSegmentedListContainerView
        listContainerView = JXSegmentedListContainerView(dataSource: self)
        listContainerView.didAppearPercent = 0.9
        view.addSubview(listContainerView)
        
        //6、将listContainerView.scrollView和segmentedView.contentScrollView进行关联
        segmentedView.contentScrollView = listContainerView.scrollView
    }
    
    func realoadSegementView(index:Int){
        switch index {
        case NotificationType.system.rawValue:
            if unreadModel.violation == 0{
                //先更新数据源的数据
                segmentedViewDataSource.dotStates[index] = false
                //再调用reloadItem(at: index)
                segmentedView.reloadItem(at: index)
            }
        case NotificationType.comment.rawValue:
            if unreadModel.commentMine == 0{
                //先更新数据源的数据
                segmentedViewDataSource.dotStates[index] = false
                //再调用reloadItem(at: index)
                segmentedView.reloadItem(at: index)
            }
        case NotificationType.approve.rawValue:
            if unreadModel.approveMine == 0{
                //先更新数据源的数据
                segmentedViewDataSource.dotStates[index] = false
                //再调用reloadItem(at: index)
                segmentedView.reloadItem(at: index)
            }
        default:
            if unreadModel.atMine == 0{
                //先更新数据源的数据
                segmentedViewDataSource.dotStates[index] = false
                //再调用reloadItem(at: index)
                segmentedView.reloadItem(at: index)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        listContainerView.frame = CGRect(x: 0, y: 50, width: view.bounds.size.width, height: view.bounds.size.height - 50)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        //处于第一个item的时候，才允许屏幕边缘手势返回
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = (self.segmentedView.selectedIndex == 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
}

extension MessageSegementViewController : JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        //传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
        self.realoadSegementView(index: index)
        listContainerView.didClickSelectedItem(at: index)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        //传递scrollingFrom事件给listContainerView，必须调用！！！
        listContainerView.segmentedViewScrolling(from: leftIndex, to: rightIndex, percent: percent, selectedIndex: segmentedView.selectedIndex)
    }
}

extension MessageSegementViewController: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return titles.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let controller = NotificationViewController.init()
        controller.unreadModel = self.unreadModel
        controller.initSView(type: index)
        controller.notificationViewControllerReloadClouse = { index in
            self.realoadSegementView(index: index)
        }
        controller.postDetailDataClouse = { data, type, indexPath in
            self.messageViewModel.pushPostDetailViewController(data, type, indexPath!)
        }
        return controller
    }
}
