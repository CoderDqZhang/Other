//
//  OtherMineViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/20.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import JXSegmentedView

typealias OtherMineViewControlerReloadFansButtonClouse = (_ status:Bool) ->Void

class OtherMineViewController: BaseViewController {

    var pagingView:JXPagingView!
    var userHeader:GloabelHeader!
    var userHeaderContainerView: UIView!
    var segmentedViewDataSource: JXSegmentedTitleDataSource!
    var segmentedView: JXSegmentedView!
    let titles = ["推荐", "发表", "竞猜"]
    var tableHeaderViewHeight: CGFloat = 148
    var heightForHeaderInSection: Int = 44
    
    let recommendVC = RecommendViewController()
    let otherGuessVC = OtherGuessViewController()
    let otherPostVC = OtherPostViewController()
    
    var postData:NSDictionary!
    var otherViewModel = OtherMineViewModel.init()
    
    var gloableNavigationBar:GLoabelNavigaitonBar!
    
    var otherMineViewControlerReloadFansButtonClouse:OtherMineViewControlerReloadFansButtonClouse!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        let followButton = AnimationButton.init(type: .custom)
        followButton.frame = CGRect.init(x: SCREENWIDTH - 100, y: 0, width: 61, height: 27)
        followButton.cornerRadius = 14
        followButton.titleLabel?.font = App_Theme_PinFan_R_14_Font
        followButton.layer.masksToBounds = true
        followButton.isHidden = true
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
        self.view.addSubview(gloableNavigationBar)
    }
    
    override func setUpView() {
        if #available(iOS 11.0, *) {
            userHeaderContainerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: CGFloat(tableHeaderViewHeight + NAV_HEIGHT / 2)))
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
        userHeader.mineInfoTableViewCellClouse = { type in
            switch type {
            case .fans:
                let fansVC = FansViewController()
                fansVC.userId = (self.postData.object(forKey: "id") as! Int).string
                NavigationPushView(self, toConroller: fansVC)
            default:
                let followsVC = FollowsViewController()
                followsVC.userId = (self.postData.object(forKey: "id") as! Int).string
                NavigationPushView(self, toConroller: followsVC)
            }
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
        
//        segmentedViewDataSource = JXSegmentedTitleDataSource(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: CGFloat(JXheightForHeaderInSection)))
//        segmentedViewDataSource.titles = titles
//        segmentedViewDataSource.backgroundColor = UIColor.white
//        segmentedViewDataSource.titleSelectedColor = UIColor(red: 105/255, green: 144/255, blue: 239/255, alpha: 1)
//        segmentedViewDataSource.titleColor = UIColor.black
//        segmentedViewDataSource.isTitleColorGradientEnabled = true
//        segmentedViewDataSource.isTitleLabelZoomEnabled = true
//        segmentedViewDataSource.delegate = self
        
        segmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: CGFloat(heightForHeaderInSection)))
        segmentedView.backgroundColor = App_Theme_FFFFFF_Color
        segmentedView.defaultSelectedIndex = 1
        segmentedView.delegate = self
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
        
        //扣边返回处理，下面的代码要加上
        pagingView.listContainerView.collectionView.panGestureRecognizer.require(toFail: self.navigationController!.interactivePopGestureRecognizer!)
        pagingView.mainTableView.panGestureRecognizer.require(toFail: self.navigationController!.interactivePopGestureRecognizer!)
        
         pagingView.mainTableView.gestureDelegate = self
        
        self.view.addSubview(pagingView)
        
        segmentedView.contentScrollView = pagingView.listContainerView.collectionView
    }

    override func bindViewModelLogic() {
        self.bindViewModel(viewModel: otherViewModel, controller: self)
        self.recommendVC.postDetailDataClouse = { data, type, indexPath in
            self.otherViewModel.pushPostDetailViewController(data, type)
        }
        
        self.otherPostVC.postDetailDataClouse = { data, type, indexPath in
            self.otherViewModel.pushPostDetailViewController(data, type)
        }
        
        self.otherGuessVC.postDetailDataClouse = { data, type, indexPath in
            self.otherViewModel.pushPostDetailViewController(data, type)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pagingView.frame = self.view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = segmentedView.selectedIndex == 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
   
}


extension OtherMineViewController : JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        //传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
    }

    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        //传递scrollingFrom事件给listContainerView，必须调用！！！

    }
}

extension OtherMineViewController: JXPagingViewDelegate {
    
    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        return Int(tableHeaderViewHeight) - 60
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
            alpa = scrollView.contentOffset.y / 60
        } else {
            alpa = scrollView.contentOffset.y / 60
            // Fallback on earlier versions
        }
        if scrollView.contentOffset.y < 0 {
            alpa = 1
        }
        gloableNavigationBar.rigthButton.isHidden = scrollView.contentOffset.y > 40 ? false : true

        self.gloableNavigationBar.changeBackGroundColor(transparency: alpa > 1 ? 1 :alpa)
    }
}

//extension OtherMineViewController: JXCategoryViewDelegate {
//    func categoryView(_ categoryView: JXCategoryBaseView!, didSelectedItemAt index: Int) {
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = (index == 0)
//    }
//
//    func categoryView(_ categoryView: JXCategoryBaseView!, didClickedItemContentScrollViewTransitionTo index: Int){
//        //请务必实现该方法
//        //因为底层触发列表加载是在代理方法：`- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath`回调里面
//        //所以，如果当前有5个item，当前在第1个，用于点击了第5个。categoryView默认是通过设置contentOffset.x滚动到指定的位置，这个时候有个问题，就会触发中间2、3、4的cellForItemAtIndexPath方法。
//        //如此一来就丧失了延迟加载的功能
//        //所以，如果你想规避这样的情况发生，那么务必按照这里的方法处理滚动。
//        self.pagingView.listContainerView.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
//
//
//        //如果你想相邻的两个item切换时，通过有动画滚动实现。未相邻的两个item直接切换，可以用下面这段代码
//        /*
//         let diffIndex = abs(categoryView.selectedIndex - index)
//         if diffIndex > 1 {
//         self.pagingView.listContainerView.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
//         }else {
//         self.pagingView.listContainerView.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
//         }
//         */
//    }
//}

extension OtherMineViewController: JXPagingMainTableViewGestureDelegate {
    func mainTableViewGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        //禁止Nest嵌套效果的时候，上下和左右都可以滚动
//        if otherGestureRecognizer.view == nestContentScrollView {
//            return false
//        }
//        //禁止categoryView左右滑动的时候，上下和左右都可以滚动
//        if otherGestureRecognizer == categoryView?.collectionView.panGestureRecognizer {
//            return false
//        }
        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.classForCoder()) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.classForCoder())
    }
}
