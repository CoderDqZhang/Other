//
//  SquareSegmentViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/15.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import JXSegmentedView

typealias AritcleDetialClouse = (_ data:NSDictionary,_ type:ArticleTypeModel, _ indexPath:IndexPath) ->Void

class SquareSegmentViewController: BaseViewController {

    var segmentedViewDataSource: JXSegmentedTitleDataSource!
    var segmentedView: JXSegmentedView!
    var listContainerView: JXSegmentedListContainerView!
    
    var titles:[String]!
    let temp_titles:[String]! = []
    var articleTypeArray:NSMutableArray!
    
    var heightForHeaderInSection: Int = 44
    
    var aritcleDetialClouse:AritcleDetialClouse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func initSView(type:Int) {
        segmentedViewDataSource = JXSegmentedTitleDataSource()
        segmentedViewDataSource.titles = titles == nil ? temp_titles : titles
        segmentedViewDataSource.titleSelectedColor = App_Theme_06070D_Color!
        segmentedViewDataSource.titleNormalColor = App_Theme_666666_Color!
        segmentedViewDataSource.isTitleColorGradientEnabled = true
        segmentedViewDataSource.isTitleZoomEnabled = false
        segmentedViewDataSource.reloadData(selectedIndex: 0)
        
        segmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: CGFloat(heightForHeaderInSection)))
        segmentedView.backgroundColor = App_Theme_FFFFFF_Color
        segmentedView.defaultSelectedIndex = 0
        segmentedView.dataSource = segmentedViewDataSource
        segmentedView.isContentScrollViewClickTransitionAnimationEnabled = true
        
        //增加底部边框
        segmentedView.border(for: App_Theme_F6F6F6_Color!, borderWidth: 1, borderType: UIBorderSideType.bottom)
        
        let lineView = JXSegmentedIndicatorLineView()
        lineView.indicatorColor = App_Theme_FFD512_Color!
        lineView.indicatorWidth = 30
        lineView.verticalOffset = 4
        segmentedView.indicators = [lineView]
        
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if listContainerView != nil {
            listContainerView.frame = CGRect(x: 0, y: 44, width: view.bounds.size.width, height: view.bounds.size.height - 50)
        }
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

extension SquareSegmentViewController : JXSegmentedListContainerViewListDelegate {
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

extension SquareSegmentViewController : JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        //传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
        listContainerView.didClickSelectedItem(at: index)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        //传递scrollingFrom事件给listContainerView，必须调用！！！
        listContainerView.segmentedViewScrolling(from: leftIndex, to: rightIndex, percent: percent, selectedIndex: segmentedView.selectedIndex)
    }
}

extension SquareSegmentViewController: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return titles == nil ? temp_titles.count : titles.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let squareVC = SquareViewController()
        let type = ArticleTypeModel.init(fromDictionary: self.articleTypeArray![index] as! [String : Any])
        squareVC.articleType = type
        squareVC.squareViewControllerClouse = { data, indexPath in
            if self.aritcleDetialClouse != nil {
                self.aritcleDetialClouse(data,type,indexPath)
            }
        }
        squareVC.initSView(type: index)
        return squareVC
    }
}

