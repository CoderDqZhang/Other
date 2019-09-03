//
//  ScoreSegementViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import JXSegmentedView

class ScoreSegementViewController: BaseViewController,UIScrollViewDelegate {

    let titles = ["足球", "篮球"]
    let segmentViewModel = ScoreSegmentViewModel.init()    
    
    let baseketBallScoreSegmentVC = BaseScoreSegmentViewController.init()
    let baseScoreFootBallSegmentVC = BaseScoreSegmentViewController.init()
    
    var segmentedViewDataSource: JXSegmentedTitleDataSource!
    var segmentedView: JXSegmentedView!
    var listContainerView: JXSegmentedListContainerView!
    
    var tableHeaderViewHeight: CGFloat = 138
    var heightForHeaderInSection: Int = 44
    
    
    var selectViewType:ScoreDetailVC = .football
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createSegementController()
        self.createNavigationItem()
        // Do any additional setup after loading the view.
    }
    
    func createSegementController(){
        
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedViewDataSource = JXSegmentedTitleDataSource()
        segmentedViewDataSource.titles = titles
        segmentedViewDataSource.titleSelectedColor = App_Theme_06070D_Color!
        segmentedViewDataSource.titleNormalColor = App_Theme_06070D_Color!
        segmentedViewDataSource.titleSelectedFont = App_Theme_PinFan_M_21_Font!
        segmentedViewDataSource.titleNormalFont = App_Theme_PinFan_R_18_Font!
        segmentedViewDataSource.isTitleColorGradientEnabled = true
        segmentedViewDataSource.isTitleZoomEnabled = false
        segmentedViewDataSource.reloadData(selectedIndex: 0)
        
        segmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: CGFloat(heightForHeaderInSection)))
        segmentedView.backgroundColor = .clear
        
        segmentedView.contentEdgeInsetRight = 72
        segmentedView.contentEdgeInsetLeft = 72
        segmentedView.defaultSelectedIndex = 0
        segmentedView.dataSource = segmentedViewDataSource
        segmentedView.isContentScrollViewClickTransitionAnimationEnabled = true
        
        let triangleView = JXSegmentedIndicatorTriangleView()
        triangleView.indicatorColor = App_Theme_FFFFFF_Color!
        triangleView.indicatorWidth = 12
        triangleView.indicatorHeight = 6
        segmentedView.indicators = [triangleView]
        
        segmentedView.delegate = self
        
        
        self.view.addSubview(segmentedView)
        
        //5、初始化JXSegmentedListContainerView
        listContainerView = JXSegmentedListContainerView(dataSource: self)
        listContainerView.didAppearPercent = 0.9
        view.addSubview(listContainerView)
        
        //6、将listContainerView.scrollView和segmentedView.contentScrollView进行关联
        segmentedView.contentScrollView = listContainerView.scrollView
    }
    
    override func bindViewModelLogic(){
        self.bindViewModel(viewModel: segmentViewModel, controller: self)
        
        self.baseketBallScoreSegmentVC.scoreDetailDataClouse = { data, type, scoreType, indexPath in
            self.segmentViewModel.pushScoreDetailViewController(data, type, scoreType, indexPath!)
        }
        
        self.baseScoreFootBallSegmentVC.scoreDetailDataClouse = { data, type, scoreType, indexPath in
            self.segmentViewModel.pushScoreDetailViewController(data, type, scoreType, indexPath!)
        }
    }
    
    func createNavigationItem(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "ic_more")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.rightBarItemClick))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "ic_filte")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.leftBarItemClick))
        self.navigationItem.titleView = self.segmentedView
    }
    
    @objc func rightBarItemClick(){
        segmentViewModel.pushMoreVC()
    }
    
    @objc func leftBarItemClick(){
        segmentViewModel.pushFilterVC(self.selectViewType)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        listContainerView.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: view.bounds.height - 44)            
    }
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension ScoreSegementViewController : JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        //传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
        listContainerView.didClickSelectedItem(at: index)
        self.selectViewType = ScoreDetailVC.init(rawValue: index)!
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        //传递scrollingFrom事件给listContainerView，必须调用！！！
        listContainerView.segmentedViewScrolling(from: leftIndex, to: rightIndex, percent: percent, selectedIndex: segmentedView.selectedIndex)
    }
}

extension ScoreSegementViewController: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return titles.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        switch index {
        case 0:
            baseScoreFootBallSegmentVC.initSView(type: index)
            return baseScoreFootBallSegmentVC
        default:
            baseketBallScoreSegmentVC.initSView(type: index)
            return baseketBallScoreSegmentVC
        }
    }
}
