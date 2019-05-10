//
//  SegmentViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import BetterSegmentedControl

class SegmentViewController: BaseViewController, UIScrollViewDelegate {

    let newController = NewsViewController()
    let outFallController = OutFallViewController()
    var viewControllers:[BaseViewController] = []
    let segmentViewModel = SegmentViewModel()
    var control:BetterSegmentedControl!
    var scrollerView:UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createSegementController()
        self.createNavigationItem()
        self.createScrollerView()
        // Do any additional setup after loading the view.
    }
    
    func createSegementController(){
        viewControllers = [newController,outFallController]

        control = BetterSegmentedControl(
            frame: CGRect(x: 50, y: 0, width: SCREENWIDTH - 100, height: 44),
            segments: LabelSegment.segments(withTitles: ["最新", "出墙"],
                                            normalFont: App_Theme_PinFan_R_16_Font,
                                            normalTextColor: App_Theme_5B4D0E_Color,
                                            selectedFont: App_Theme_PinFan_R_16_Font,
                                            selectedTextColor: App_Theme_06070D_Color),
            index: 0,
            options: [.backgroundColor(.clear),
                      .indicatorViewBackgroundColor(.clear)])
        control.addTarget(self, action: #selector(self.controlValueChanged(index:)), for: .valueChanged)
        self.navigationController?.navigationBar.addSubview(control)
        
    }
    
    override func bindViewModelLogic(){
        self.bindViewModel(viewModel: segmentViewModel, controller: self)
        self.newController.postDetailDataClouse = { data, type in
            self.segmentViewModel.pushPostDetailViewController(data, type)
        }
        
        self.newController.categoryDetailClouse = { data, type in
            self.segmentViewModel.pushCategoryDetailViewController(data, type)
        }
        
        self.outFallController.postDetailDataClouse = { data, type in
            self.segmentViewModel.pushPostDetailViewController(data, type)
        }
        
    }
    
    func createNavigationItem(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "发表")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.rightBarItemClick))
    }
    
    @objc func rightBarItemClick(){
        segmentViewModel.pushPostVC()
    }
    
    @objc func controlValueChanged(index:Int){
        self.scrollerView.setContentOffset(CGPoint.init(x: CGFloat(self.control.index) * SCREENWIDTH, y: 0), animated: true)
    }
    
    func createScrollerView(){
        
        scrollerView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT - 64 - 100))
        scrollerView.backgroundColor = UIColor.red
        scrollerView.bounces = false
        scrollerView.isPagingEnabled = true
        scrollerView.showsHorizontalScrollIndicator = false
        scrollerView.showsVerticalScrollIndicator = false
        scrollerView.delegate = self
        scrollerView.contentSize = CGSize.init(width: SCREENWIDTH * CGFloat(viewControllers.count), height: SCREENHEIGHT)
        self.view.addSubview(scrollerView)
        var index:CGFloat = 0
        for vc in viewControllers {
            vc.view.frame = CGRect.init(x: 0 + index * SCREENWIDTH, y: 0, width: SCREENWIDTH, height: scrollerView.bounds.size.height)
            scrollerView.addSubview(vc.view)
            index = index + 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.control.isHidden = false
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.control.isHidden = true
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

extension SegmentViewController{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.control.setIndex(UInt(scrollView.contentOffset.x/SCREENWIDTH))
    }
}
