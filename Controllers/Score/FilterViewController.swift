//
//  FilterViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/1.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import JXSegmentedView
import BDKCollectionIndexView
import MBProgressHUD

let CollectIemtCount:CGFloat = 3
let CollectIemtMarginWidth:CGFloat = 12
let CollectItemMarginHeight:CGFloat = 8
let CollectItemSizeWidth:CGFloat = ((SCREENWIDTH - 30) - CollectIemtCount * CollectIemtMarginWidth) / CollectIemtCount
let CollectItemSizeHeight:CGFloat = 34

typealias FilterViewControllerSaveClouse = () ->Void
typealias FilterViewControllerReloadSaveClouse = (_ isAdd:Bool, _ dic:NSDictionary) ->Void

enum FilterViewControllerType:Int {
    case all = 0
    case level1 = 1
    case northsigle = 2
    case lottery = 3
    case index = 4
}

class FilterViewController: BaseViewController {

    var filterViewModel = FilterViewModel.init()
    
    var collectionView:UICollectionView!
    
    var buttomView:FilterBottomView!
    var indexView:BDKCollectionIndexView!
    
    var viewType:ScoreDetailVC!
    var filterType:FilterViewControllerType!
    
    let indexWidth:CGFloat = 28
    
    var filterViewControllerSaveClouse:FilterViewControllerSaveClouse!
    
    var filterViewControllerReloadSaveClouse:FilterViewControllerReloadSaveClouse!
    
    var hud:MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func initSView(type:Int) {
        self.filterViewModel.controller = self
        self.filterType = FilterViewControllerType.init(rawValue: type)
        self.filterViewModel.filterType = FilterViewControllerType.init(rawValue: type)
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            if self.viewType == .football {
                let temp_dic =  CacheManager.getSharedInstance().getFootBallInfoModel()
                if temp_dic == nil || temp_dic?.object(forKey: Date.init().string(withFormat: "yyyyMMdd")) == nil {
                    LoadConfigManger.getSharedInstance().loadFootBallScorEvent()
                    NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: NSNotification.Name.init(RELOADFOOTBALLEVENTDATA), object: nil)
                }else{
                    if CacheManager.getSharedInstance().getFootBallEventModel() == nil {
                        LoadConfigManger.getSharedInstance().saveFootBallEventDic(dic: temp_dic?.object(forKey: Date.init().string(withFormat: "yyyyMMdd"))! as! NSDictionary)
                    }
                    self.loadData()
                }
                
            }else{
                let temp_dic =  CacheManager.getSharedInstance().getBasketBallInfoModel()
                if temp_dic == nil || temp_dic?.object(forKey: Date.init().string(withFormat: "yyyyMMdd")) == nil {
                    LoadConfigManger.getSharedInstance().loadBasketBallScorEvent()
                    NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: NSNotification.Name.init(RELOADBASKETBALLEVENTDATA), object: nil)
                }else{
                    if CacheManager.getSharedInstance().getBasketBallEventModel() == nil {
                        LoadConfigManger.getSharedInstance().saveBasketBallEventDic(dic: temp_dic?.object(forKey: Date.init().string(withFormat: "yyyyMMdd"))! as! NSDictionary)
                    }
                    self.loadData()
                }
            }
        }
        
        self.bindViewModel(viewModel: filterViewModel, controller: self)
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: CollectItemSizeWidth, height: CollectItemSizeHeight)
        layout.minimumLineSpacing = CollectItemMarginHeight
        layout.minimumInteritemSpacing = CollectIemtMarginWidth
        layout.headerReferenceSize = CGSize.init(width: SCREENWIDTH, height: 30)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 8, left: 15, bottom: 8, right: 15)

        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)

        collectionView?.backgroundColor = App_Theme_F6F6F6_Color
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.description())
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        collectionView?.delegate = filterViewModel
        collectionView?.dataSource = filterViewModel
        self.view.addSubview(collectionView!)
        self.view.sendSubviewToBack(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11.0, *) {
            collectionView.frame = CGRect(x:0, y:0, width:SCREENWIDTH, height:view.bounds.size.height - 48 - TABBAR_HEIGHT)
        } else {
            // Fallback on earlier versions
            collectionView.frame = CGRect(x:0, y:0, width:SCREENWIDTH, height:view.bounds.size.height - 48)
        }
        if self.indexView != nil {
            if #available(iOS 11.0, *) {
                indexView.frame = CGRect(x: SCREENWIDTH - self.indexWidth,
                                         y: 0,
                                         width: self.indexWidth,
                                         height: view.bounds.size.height - 48 - TABBAR_HEIGHT)
            } else {
                // Fallback on earlier versions
                indexView.frame = CGRect(x: SCREENWIDTH - self.indexWidth,
                                         y: 0,
                                         width: self.indexWidth,
                                         height: view.bounds.size.height - 48)
            }
        }
        
    }
    
    func addBootomView(){
        DispatchQueue.main.async {
            if self.buttomView == nil {
                self.buttomView = FilterBottomView.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 48, width: SCREENWIDTH, height: 48), number: "0", click: { (type) in
                    if type == .done {
                        self.filterViewModel.saveEvent()
                    }else{
                        self.filterViewModel.selectTools(type: type)
                    }
                })
                self.view.addSubview(self.buttomView)
                self.view.bringSubviewToFront(self.buttomView)
                self.buttomView.snp.makeConstraints { (make) in
                    make.bottom.equalToSuperview()
                    make.left.equalToSuperview()
                    make.right.equalToSuperview()
                    if #available(iOS 11.0, *) {
                        make.height.equalTo(48 + TABBAR_HEIGHT)
                    } else {
                        // Fallback on earlier versions
                        make.height.equalTo(48)
                    }
                }
            }
        }
    }
    
    @objc func reloadData(){
        self.loadData()
        
    }
    
    func loadData(){
        self.filterViewModel.viewType = self.viewType
        self.addBootomView()
        if self.viewType == .football {
            switch self.filterType! {
            case .all:
                self.filterViewModel.footBalleventsList = NSMutableDictionary.init(dictionary:CacheManager.getSharedInstance().getFootBallEventModel()!)
            case .level1:
                self.filterViewModel.footBalleventsList = NSMutableDictionary.init(dictionary:CacheManager.getSharedInstance().getFootBallEventLevelModel() == nil ? [:] : CacheManager.getSharedInstance().getFootBallEventLevelModel()!)
            case .northsigle:
                self.filterViewModel.footBalleventsList = NSMutableDictionary.init(dictionary:CacheManager.getSharedInstance().getFootBallNorthSigleModel() == nil ? [:] :CacheManager.getSharedInstance().getFootBallNorthSigleModel()!)
            case .index:
                self.filterViewModel.footBalleventsList = NSMutableDictionary.init(dictionary:CacheManager.getSharedInstance().getFootBallIndexModel() == nil ? [:] : CacheManager.getSharedInstance().getFootBallIndexModel()!)
            default:
                self.filterViewModel.footBalleventsList = NSMutableDictionary.init(dictionary:CacheManager.getSharedInstance().getFootBallLotteryModel() == nil ? [:] : CacheManager.getSharedInstance().getFootBallLotteryModel()!)
            }
            if self.filterViewModel.footBalleventsList != nil {
                self.addRightView(dic: self.filterViewModel.footBalleventsList)
                self.filterViewModel.titles = self.filterViewModel.footBalleventsList.allKeys.sorted(by: { (first, seconde) -> Bool in
                    return (first as! String) < (seconde as! String)
                }) as NSArray
                self.filterViewModel.selecFootBallDic = NSMutableDictionary.init(dictionary:CacheManager.getSharedInstance().getFootBallEventSelectModel()!)
                self.filterViewModel.reloadFootBallSelectDic()
            }
        }else{
            switch self.filterType! {
            case .all:
                self.filterViewModel.basketBalleventsList = NSMutableDictionary.init(dictionary:CacheManager.getSharedInstance().getBasketBallEventModel()!)
            case .level1:
                self.filterViewModel.basketBalleventsList = NSMutableDictionary.init(dictionary:CacheManager.getSharedInstance().getBasketBallEventLevelModel() == nil ? [:] : CacheManager.getSharedInstance().getBasketBallEventLevelModel()!)
            default:
               self.filterViewModel.basketBalleventsList = NSMutableDictionary.init(dictionary:CacheManager.getSharedInstance().getBasketBallIndexModel() == nil ? [:] : CacheManager.getSharedInstance().getBasketBallIndexModel()!)
            }
            if self.filterViewModel.basketBalleventsList != nil {
                self.addRightView(dic: self.filterViewModel.basketBalleventsList)
                self.filterViewModel.titles = self.filterViewModel.basketBalleventsList.allKeys.sorted(by: { (first, seconde) -> Bool in
                    return (first as! String) < (seconde as! String)
                }) as NSArray
                self.filterViewModel.selecBasketBallDic = NSMutableDictionary.init(dictionary:CacheManager.getSharedInstance().getBasketBallEventSelectModel()!)
                self.filterViewModel.reloadBasketSelectDic()
            }
        }
    }
    
    func addRightView(dic:NSDictionary){
        DispatchQueue.main.async {
            if self.indexView == nil && dic.allKeys.count > 0{
                let frame:CGRect! = CGRect.zero
                self.indexView = BDKCollectionIndexView.init(frame: frame, indexTitles: dic.allKeys.sorted(by: { (first, seconde) -> Bool in
                    return (first as! String) < (seconde as! String)
                }))
                
                self.indexView.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
                self.indexView?.delegate = self
                self.indexView!.addTarget(self, action: #selector(self.indexViewValueChanged(sender:)), for: .valueChanged)
                self.view.addSubview(self.indexView!)
                self.view.bringSubviewToFront(self.indexView!)
            }
        }
    }
    
    @objc func indexViewValueChanged(sender: BDKCollectionIndexView) {
        let path = NSIndexPath(item: 0, section: Int(sender.currentIndex))
        collectionView.scrollToItem(at: path as IndexPath, at: .top, animated: false)
        // If you're using a collection view, bump the y-offset by a certain number of points
        // because it won't otherwise account for any section headers you may have.
        collectionView.contentOffset = CGPoint(x: collectionView.contentOffset.x,
                                               y: collectionView.contentOffset.y - 45.0)
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

extension FilterViewController : JXSegmentedListContainerViewListDelegate {
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

extension FilterViewController : BDKCollectionIndexViewDelegate {
    func collectionIndexView(_ collectionIndexView: BDKCollectionIndexView!, liftedFingerFrom pressedIndex: UInt) {
        hud.hide(animated: true, afterDelay: 0.5)
        hud = nil
    }
    
    func collectionIndexView(_ collectionIndexView: BDKCollectionIndexView!, isPressedOn pressedIndex: UInt, indexTitle: String!) {
        
        if hud == nil {
            hud = Tools.shareInstance.showMessage(KWindow, msg: indexTitle, autoHidder: false)
        }else{
            hud.label.text = indexTitle
        }
    }
}
