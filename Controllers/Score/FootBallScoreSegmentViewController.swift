//
//  FootBallScoreSegmentViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import JXSegmentedView

class FootBallScoreSegmentViewController: BaseViewController {

    var segmentedViewDataSource: JXSegmentedTitleDataSource!
    var segmentedView: JXSegmentedView!
    var listContainerView: JXSegmentedListContainerView!
    
    var titles:[String]!
    var heightForHeaderInSection: Int = 33
    
    var viewType:ScoreDetailVC! = .football
    var viewDesc:ScoreDetailTypeVC! = .timely
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func initSView(type:Int) {
        self.viewDesc = ScoreDetailTypeVC.init(rawValue: type)
        segmentedViewDataSource = JXSegmentedTitleDataSource()
        segmentedViewDataSource.titles = titles
        segmentedViewDataSource.titleNumberOfLines = 2
        segmentedViewDataSource.titleSelectedColor = App_Theme_06070D_Color!
        segmentedViewDataSource.titleNormalColor = App_Theme_666666_Color!
        segmentedViewDataSource.titleNormalFont = App_Theme_PinFan_M_10_Font!
        segmentedViewDataSource.titleSelectedFont = App_Theme_PinFan_M_10_Font!
        segmentedViewDataSource.isTitleColorGradientEnabled = true
        segmentedViewDataSource.isTitleZoomEnabled = false
        segmentedViewDataSource.reloadData(selectedIndex: 0)
        
        segmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: CGFloat(heightForHeaderInSection)))
        segmentedView.backgroundColor = App_Theme_F1F1F1_Color
        segmentedView.defaultSelectedIndex = 0
        segmentedView.dataSource = segmentedViewDataSource
        segmentedView.isContentScrollViewClickTransitionAnimationEnabled = true
        
        let indicator = JXSegmentedIndicatorBackgroundView()
        indicator.backgroundWidthIncrement = 10
        indicator.indicatorHeight = 33
        indicator.indicatorCornerRadius = 2
        indicator.indicatorColor = App_Theme_FFD210_Color!
        segmentedView.indicators = [indicator]
        
        segmentedView.delegate = self
        
        
        self.view.addSubview(segmentedView)
        
        //5、初始化JXSegmentedListContainerView
        listContainerView = JXSegmentedListContainerView(dataSource: self)
        listContainerView.didAppearPercent = 0.9
        view.addSubview(listContainerView)
        
        //6、将listContainerView.scrollView和segmentedView.contentScrollView进行关联
        segmentedView.contentScrollView = listContainerView.scrollView
        
        //6、将listContainerView.scrollView和segmentedView.contentScrollVi
        
    }
    
    override func bindViewModelLogic() {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        listContainerView.frame = CGRect(x: 0, y: 33, width: view.bounds.size.width, height: view.bounds.size.height - 33)
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

extension FootBallScoreSegmentViewController : JXSegmentedListContainerViewListDelegate {
    override func listView() -> UIView {
        return view
    }
    
    override func listDidAppear() {
        print("listDidAppear")
    }
    
    override func listDidDisappear() {
        print("listDidDisappear")
    }
}

extension FootBallScoreSegmentViewController : JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        //传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
        listContainerView.didClickSelectedItem(at: index)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        //传递scrollingFrom事件给listContainerView，必须调用！！！
        listContainerView.segmentedViewScrolling(from: leftIndex, to: rightIndex, percent: percent, selectedIndex: segmentedView.selectedIndex)
    }
}

extension FootBallScoreSegmentViewController: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return titles.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let footBallVC = FootBallViewController()
        footBallVC.viewType = self.viewType
        footBallVC.viewDesc = self.viewDesc
        footBallVC.initSView(type: index, titles:titles[index])
        return footBallVC
    }
}
