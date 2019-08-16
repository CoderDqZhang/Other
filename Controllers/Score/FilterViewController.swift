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
    case index = 3
    case lottery = 4
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func initSView(type:Int) {
        self.filterViewModel.controller = self
        self.filterType = FilterViewControllerType.init(rawValue: type)
        self.filterViewModel.filterType = FilterViewControllerType.init(rawValue: type)
        if self.viewType == .football {
            let temp_dic =  CacheManager.getSharedInstance().getFootBallInfoModel()
            if temp_dic == nil || temp_dic?.object(forKey: Date.init().string(withFormat: "yyyyMMdd")) == nil {
                LoadConfigManger.getSharedInstance().loadScorEvent()
                NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: NSNotification.Name.init(RELOADFOOTBALLEVENTDATA), object: nil)
            }else{
                if CacheManager.getSharedInstance().getFootBallEventModel() == nil {
                    LoadConfigManger.getSharedInstance().saveEventDic(dic: temp_dic?.object(forKey: Date.init().string(withFormat: "yyyyMMdd"))! as! NSDictionary)
                }
                self.loadData()
            }
            
        }else{
            print("")
        }
        
        
        self.bindViewModel(viewModel: filterViewModel, controller: self)
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: CollectItemSizeWidth, height: CollectItemSizeHeight)
        layout.minimumLineSpacing = CollectItemMarginHeight
        layout.minimumInteritemSpacing = CollectIemtMarginWidth
        layout.headerReferenceSize = CGSize.init(width: SCREENWIDTH, height: 30)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 8, left: 15, bottom: 8, right: 15)

        collectionView = UICollectionView.init(frame: CGRect(x:0, y:0, width:SCREENWIDTH, height:SCREENHEIGHT - 108 - 48), collectionViewLayout: layout)
        collectionView?.backgroundColor = App_Theme_F6F6F6_Color
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.description())
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        collectionView?.delegate = filterViewModel
        collectionView?.dataSource = filterViewModel
        self.view.addSubview(collectionView!)
        self.view.sendSubviewToBack(collectionView)
    }
    
    func addBootomView(){
        if self.buttomView == nil {
            buttomView = FilterBottomView.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 48, width: SCREENWIDTH, height: 48), number: "0", click: { (type) in
                if type == .done {
                    self.filterViewModel.saveEvent()
                }else{
                    self.filterViewModel.selectTools(type: type)
                }
            })
            self.view.addSubview(buttomView)
            self.view.bringSubviewToFront(buttomView)
            buttomView.snp.makeConstraints { (make) in
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
    
    @objc func reloadData(){
        self.loadData()
        self.collectionView.reloadData()
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
                self.filterViewModel.reloadSelectDic()
            }
        }else{
            
        }
    }
    
    func addRightView(dic:NSDictionary){
        if indexView == nil {
            let frame = CGRect(x: SCREENWIDTH - indexWidth,
                               y: 0,
                               width: indexWidth,
                               height: SCREENHEIGHT - 108 - 44 - 44)
            indexView = BDKCollectionIndexView.init(frame: frame, indexTitles: dic.allKeys.sorted(by: { (first, seconde) -> Bool in
                return (first as! String) < (seconde as! String)
            }))
            indexView?.delegate = self
            indexView!.autoresizingMask = [.flexibleHeight,.flexibleLeftMargin]
            indexView!.addTarget(self, action: #selector(indexViewValueChanged(sender:)), for: .valueChanged)
            self.view.addSubview(indexView!)
            self.view.bringSubviewToFront(indexView!)
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
        
    }
    
    func collectionIndexView(_ collectionIndexView: BDKCollectionIndexView!, isPressedOn pressedIndex: UInt, indexTitle: String!) {
        
    }
}
