//
//  FilterViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/1.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class FilterViewModel: BaseViewModel {

    var titles:NSArray!
    var footBalleventsList:NSMutableDictionary!
    var basketBalleventsList:NSMutableDictionary!
    
    var selecFootBallDic:NSMutableDictionary!
    var selecBasketBallDic:NSMutableDictionary!
    
    var isSelectFootBallDic:Bool = false
    var isSelectBasketBallDic:Bool = false
    
    var viewType:ScoreDetailVC!
    
    var filterType:FilterViewControllerType!
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFootBallSelectDic), name: NSNotification.Name.init(CLICKRELOADFOOTBALLEVENTDATA), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadBasketSelectDic), name: NSNotification.Name.init(CLICKRELOADBASKETBALLEVENTDATA), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init(CLICKRELOADFOOTBALLEVENTDATA), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init(CLICKRELOADBASKETBALLEVENTDATA), object: nil)
    }
    
    
    
    func cellFilterCollectionViewCellSetData(_ indexPath:IndexPath, cell:
        FilterCollectionViewCell){
        if self.viewType == .football {
            let array = footBalleventsList?.object(forKey: titles[indexPath.section]) as! NSArray
            switch self.filterType! {
            case .all:
                cell.cellSetFootBallEventData(indexPath, model: FootBallEventModel.init(fromDictionary: array[indexPath.row] as! [String : Any]))
            case .level1:
                cell.cellSetFootBallEventData(indexPath, model: FootBallEventModel.init(fromDictionary: array[indexPath.row] as! [String : Any]))
            case .index:
                cell.cellSetFootBallIndexData(indexPath, model: FootBallIndexModel.init(fromDictionary: array[indexPath.row] as! [String : Any]))
            case .northsigle:
                cell.cellSetNorthSigleData(indexPath, model: NorthSigleModel.init(fromDictionary: array[indexPath.row] as! [String : Any]))
            case .lottery:
                cell.cellSetFootBallLotteryData(indexPath, model: FootBallLotteryModel.init(fromDictionary: array[indexPath.row] as! [String : Any]))
            default:
                break;
            }
        }else{
            let array = basketBalleventsList?.object(forKey: titles[indexPath.section]) as! NSArray
            switch self.filterType! {
            case .all:
                cell.cellSetBaketBallEventData(indexPath, model: BasketBallEventModel.init(fromDictionary: array[indexPath.row] as! [String : Any]))
            case .level1:
                cell.cellSetBaketBallEventData(indexPath, model: BasketBallEventModel.init(fromDictionary: array[indexPath.row] as! [String : Any]))
            default:
                cell.cellSetBasketBallIndexData(indexPath, model: BasketBallIndexModel.init(fromDictionary: array[indexPath.row] as! [String : Any]))
            }
        }
    }
    
    func collectionViewDidSelect(collectView:UICollectionView, indexPath:IndexPath){
        if self.viewType == .football {
            let array = footBalleventsList?.object(forKey: titles[indexPath.section]) as! NSArray
            let dic = array[indexPath.row]
            (array[indexPath.row] as! NSDictionary).setValue(!((dic as! NSDictionary).object(forKey: "is_select") as! Bool), forKey: "is_select")
            self.clickCollectItemSave()
            
        }else{
            let array = basketBalleventsList?.object(forKey: titles[indexPath.section]) as! NSArray
            let dic = array[indexPath.row]
            (array[indexPath.row] as! NSDictionary).setValue(!((dic as! NSDictionary).object(forKey: "is_select") as! Bool), forKey: "is_select")
            self.clickCollectItemSave()
        }
        
    }
    
    func selectTools(type:FilterBottomViewClickType){
        var number = 0
        if type == .allselect {
            if self.viewType == .football {
                for name in footBalleventsList!.allKeys {
                    number = number + (footBalleventsList!.object(forKey: name) as! NSArray).count
                    for dic in (footBalleventsList!.object(forKey: name) as! NSArray) {
                        (dic as! NSDictionary).setValue(true, forKey: "is_select")
                    }
                }
                self.clickCollectItemSave()
            }else{
                for name in basketBalleventsList!.allKeys {
                    number = number + (basketBalleventsList!.object(forKey: name) as! NSArray).count
                    for dic in (basketBalleventsList!.object(forKey: name) as! NSArray) {
                        (dic as! NSDictionary).setValue(true, forKey: "is_select")
                    }
                }
                self.clickCollectItemSave()
            }
        }else{
            if self.viewType == .football {
                for name in footBalleventsList!.allKeys {
                    for dic in (footBalleventsList!.object(forKey: name) as! NSArray) {
                        (dic as! NSDictionary).setValue(!((dic as! NSDictionary).object(forKey: "is_select") as! Bool), forKey: "is_select")
                    }
                }
                self.clickCollectItemSave()
            }else{
                for name in basketBalleventsList!.allKeys {
                    for dic in (basketBalleventsList!.object(forKey: name) as! NSArray) {
                        (dic as! NSDictionary).setValue(!((dic as! NSDictionary).object(forKey: "is_select") as! Bool), forKey: "is_select")
                    }
                }
                self.clickCollectItemSave()
            }
        }
    }
    
    //更新选中数据
    func clickCollectItemSave(){
        if self.viewType == .football {
            isSelectFootBallDic = false
            let tempDic = NSMutableDictionary.init(dictionary: self.footBalleventsList.mutableCopy() as! NSDictionary)
            let eventDic = NSMutableDictionary.init(dictionary: CacheManager.getSharedInstance().getFootBallEventModel()!.mutableCopy() as! NSDictionary)
            let select_event_id = NSMutableArray.init()
            for str in tempDic.allKeys {
                let temp_array = NSMutableArray.init(array: tempDic.object(forKey: str as! String) as! NSArray)
                let event_array = NSMutableArray.init(array:eventDic.object(forKey: str as! String) as! NSArray)
                let result_array = NSMutableArray.init()
                if temp_array.count > 0 {
                    for index in 0...temp_array.count - 1{
                        if ((temp_array[index] as! NSDictionary).object(forKey: "is_select")! as! Bool){
                            isSelectFootBallDic = true
                            if (temp_array[index] as! NSDictionary).object(forKey: "short_name_zh") == nil {
                                for indexs in 0...event_array.count - 1 {
                                    if (event_array[indexs] as! NSDictionary).object(forKey: "short_name_zh") as! String == (temp_array[index] as! NSDictionary).object(forKey: "eventsName") as! String {
                                        result_array.add(event_array[indexs])
                                        select_event_id.add((event_array[indexs] as! NSDictionary).object(forKey: "id")!)
                                        
                                    }
                                }
                            }else{
                                select_event_id.add((temp_array[index] as! NSDictionary).object(forKey: "id")!)
                                result_array.add(temp_array[index])
                            }
                        }
                    }
                }
                tempDic.setValue(result_array, forKey: str as! String)
            }
            self.selecFootBallDic = tempDic
            CacheManager.getSharedInstance().saveFootBallEventIdModel(point: select_event_id)
            CacheManager.getSharedInstance().saveFootBallEventSelectModel(point: self.selecFootBallDic)
            NotificationCenter.default.post(name: NSNotification.Name.init(CLICKRELOADFOOTBALLEVENTDATA), object: self, userInfo: nil)
        }else{
            isSelectBasketBallDic = false
            let tempDic = NSMutableDictionary.init(dictionary: self.basketBalleventsList.mutableCopy() as! NSDictionary)
            let eventDic = NSMutableDictionary.init(dictionary: CacheManager.getSharedInstance().getBasketBallEventModel()!.mutableCopy() as! NSDictionary)
            let select_event_id = NSMutableArray.init()
            for str in tempDic.allKeys {
                let temp_array = NSMutableArray.init(array: tempDic.object(forKey: str as! String) as! NSArray)
                let event_array = NSMutableArray.init(array: eventDic.object(forKey: str as! String) as! NSArray)
                let result_array = NSMutableArray.init()
                if temp_array.count > 0 {
                    for index in 0...temp_array.count - 1{
                        if ((temp_array[index] as! NSDictionary).object(forKey: "is_select")! as! Bool){
                            isSelectBasketBallDic = true
                            if (temp_array[index] as! NSDictionary).object(forKey: "name_zh") == nil {
                                for indexs in 0...event_array.count - 1 {
                                    if (event_array[indexs] as! NSDictionary).object(forKey: "name_zh") as! String == (temp_array[index] as! NSDictionary).object(forKey: "eventsName") as! String {
                                        result_array.add(event_array[indexs])
                                        select_event_id.add((temp_array[index] as! NSDictionary).object(forKey: "id")!)
                                        break
                                    }
                                }
                            }else{
                                select_event_id.add((temp_array[index] as! NSDictionary).object(forKey: "id")!)
                                result_array.add(temp_array[index])
                            }
                        }
                    }
                }
                tempDic.setValue(result_array, forKey: str as! String)
            }
            self.selecBasketBallDic = tempDic
            CacheManager.getSharedInstance().saveBasketBallEventIdModel(point: select_event_id)
            CacheManager.getSharedInstance().saveBasketBallEventSelectModel(point: self.selecBasketBallDic)
            NotificationCenter.default.post(name: NSNotification.Name.init(CLICKRELOADBASKETBALLEVENTDATA), object: self, userInfo: nil)
        }
        
    }
    
    @objc func reloadFootBallSelectDic(){
        if self.viewType == .football {
            let selectTitles:NSMutableArray = NSMutableArray.init()
            let selectDic = CacheManager.getSharedInstance().getFootBallEventSelectModel()!
            for str in selectDic.allKeys {
                for dic in selectDic.object(forKey: str as! String) as! NSArray{
                    selectTitles.add((dic as! NSDictionary).object(forKey: "short_name_zh") == nil ? (dic as! NSDictionary).object(forKey: "eventsName")! : (dic as! NSDictionary).object(forKey: "short_name_zh")!)
                }
            }
            var number = 0
            var allNumber = 0
            switch self.filterType! {
            case .all:
                for str in self.footBalleventsList.allKeys {
                    let array = self.footBalleventsList.object(forKey: str) as! NSArray
                    for index in 0...array.count - 1 {
                        let name = (array[index] as! NSDictionary).object(forKey: "short_name_zh")
                        let isContains = selectTitles.contains(name as Any)
                        if !isContains {
                            number = number + ((array[index] as! NSDictionary).object(forKey: "match_ids") as! NSArray).count
                        }
                        if (array[index] as! NSDictionary).object(forKey: "match_ids") != nil {
                            allNumber = allNumber + ((array[index] as! NSDictionary).object(forKey: "match_ids") as! NSArray).count
                        }
                        (array[index] as! NSDictionary).setValue(isContains, forKey: "is_select")
                    }
                    UserDefaults.standard.set(allNumber, forKey: ALLFOOTBALLMACTH)
                }
            case .level1:
                for str in self.footBalleventsList.allKeys {
                    let array = self.footBalleventsList.object(forKey: str) as! NSArray
                    if array.count > 0 {
                        for index in 0...array.count - 1 {
                            let name = (array[index] as! NSDictionary).object(forKey: "short_name_zh")
                            let isContains = selectTitles.contains(name as Any)
                            if isContains {
                                number = number + ((array[index] as! NSDictionary).object(forKey: "match_ids") as! NSArray).count
                            }
                            (array[index] as! NSDictionary).setValue(isContains, forKey: "is_select")
                        }
                    }
                }
            case .index:
                for str in self.footBalleventsList.allKeys {
                    let array = self.footBalleventsList.object(forKey: str) as! NSArray
                    for index in 0...array.count - 1 {
                        let name = (array[index] as! NSDictionary).object(forKey: "eventsName")
                        
                        let isContains = selectTitles.contains(name as Any)
                        if isContains {
                            number = number + ((array[index] as! NSDictionary).object(forKey: "match_ids") as! NSArray).count
                        }
                        (array[index] as! NSDictionary).setValue(isContains, forKey: "is_select")
                    }
                }
            case .northsigle:
                for str in self.footBalleventsList.allKeys {
                    let array = self.footBalleventsList.object(forKey: str) as! NSArray
                    for index in 0...array.count - 1 {
                        let name = (array[index] as! NSDictionary).object(forKey: "eventsName")
                        let isContains = selectTitles.contains(name as Any)
                        if isContains {
                            number = number + ((array[index] as! NSDictionary).object(forKey: "match_ids") as! NSArray).count
                        }
                        (array[index] as! NSDictionary).setValue(isContains, forKey: "is_select")
                    }
                }
            default:
                for str in self.footBalleventsList.allKeys {
                    let array = self.footBalleventsList.object(forKey: str) as! NSArray
                    for index in 0...array.count - 1 {
                        let name = (array[index] as! NSDictionary).object(forKey: "eventsName")
                        let isContains = selectTitles.contains(name as Any)
                        if isContains {
                            number = number + ((array[index] as! NSDictionary).object(forKey: "match_ids") as! NSArray).count
                        }
                        (array[index] as! NSDictionary).setValue(isContains, forKey: "is_select")
                    }
                }
            }
            if (self.controller! as! FilterViewController).buttomView == nil {
                (self.controller! as! FilterViewController).addBootomView()
            }
            
            DispatchQueue.main.async {
                if self.filterType! == .all {
                    (self.controller! as! FilterViewController).buttomView.changeSelectLabelText(number: number.string)
                }else{
                    
                    let all_number = UserDefaults.standard.object(forKey: ALLFOOTBALLMACTH) as! Int
                    (self.controller! as! FilterViewController).buttomView.changeSelectLabelText(number: (all_number - number).string)
                }
            }
            
            DispatchQueue.main.async {
                if (self.controller as! FilterViewController).collectionView != nil {
                    (self.controller as! FilterViewController).collectionView.reloadData()
                }
            }
        }
    }
    
    @objc func reloadBasketSelectDic(){
        if self.viewType == .basketball {
            let selectTitles:NSMutableArray = NSMutableArray.init()
            let selectDic = CacheManager.getSharedInstance().getBasketBallEventSelectModel()!
            for str in selectDic.allKeys {
                for dic in selectDic.object(forKey: str as! String) as! NSArray{
                    selectTitles.add((dic as! NSDictionary).object(forKey: "name_zh") == nil ? (dic as! NSDictionary).object(forKey: "eventsName")! : (dic as! NSDictionary).object(forKey: "name_zh")!)
                }
            }
            var number = 0
            var allNumber = 0
            switch self.filterType! {
            case .all:
                for str in self.basketBalleventsList.allKeys {
                    let array = self.basketBalleventsList.object(forKey: str) as! NSArray
                    for index in 0...array.count - 1 {
                        let name = (array[index] as! NSDictionary).object(forKey: "name_zh")
                        let isContains = selectTitles.contains(name as Any)
                        if !isContains {
                            number = number + ((array[index] as! NSDictionary).object(forKey: "match_ids") as! NSArray).count
                        }
                        allNumber = allNumber + ((array[index] as! NSDictionary).object(forKey: "match_ids") as! NSArray).count
                        (array[index] as! NSDictionary).setValue(isContains, forKey: "is_select")
                    }
                    UserDefaults.standard.set(allNumber, forKey: ALLBASKETBALLMACTH)
                }
            case .level1:
                for str in self.basketBalleventsList.allKeys {
                    let array = self.basketBalleventsList.object(forKey: str) as! NSArray
                    for index in 0...array.count - 1 {
                        let name = (array[index] as! NSDictionary).object(forKey: "name_zh")
                        let isContains = selectTitles.contains(name as Any)
                        if isContains {
                            number = number + ((array[index] as! NSDictionary).object(forKey: "match_ids") as! NSArray).count
                        }
                        (array[index] as! NSDictionary).setValue(isContains, forKey: "is_select")
                    }
                }
            default:
                for str in self.basketBalleventsList.allKeys {
                    let array = self.basketBalleventsList.object(forKey: str) as! NSArray
                    for index in 0...array.count - 1 {
                        let name = (array[index] as! NSDictionary).object(forKey: "eventsName")
                        let isContains = selectTitles.contains(name as Any)
                        if isContains {
                            number = number + ((array[index] as! NSDictionary).object(forKey: "match_ids") as! NSArray).count
                        }
                        (array[index] as! NSDictionary).setValue(isContains, forKey: "is_select")
                    }
                }
            }
            
            if (self.controller! as! FilterViewController).buttomView == nil {
                (self.controller! as! FilterViewController).addBootomView()
            }
            DispatchQueue.main.async {
                if self.filterType! == .all {
                    (self.controller! as! FilterViewController).buttomView.changeSelectLabelText(number: number.string)
                }else{
                    let all_number = UserDefaults.standard.object(forKey: ALLBASKETBALLMACTH) as! Int
                    (self.controller! as! FilterViewController).buttomView.changeSelectLabelText(number: (all_number - number).string)
                }
            }
            
            DispatchQueue.main.async {
                if (self.controller as! FilterViewController).collectionView != nil {
                    (self.controller as! FilterViewController).collectionView.reloadData()
                }
            }
        }
    }
    
    func saveEvent(){
        if (self.controller as! FilterViewController).filterViewControllerSaveClouse != nil {
            if self.viewType == .football {
                if !isSelectFootBallDic{
                    _ = Tools.shareInstance.showMessage(KWindow, msg: "请选择赛事", autoHidder: true)
                    return
                }
                UserDefaults.standard.set(self.filterType.rawValue, forKey: RELOADCOLLECTFOOTBALLTYPEMODEL)
            }else{
                if !isSelectBasketBallDic{
                    _ = Tools.shareInstance.showMessage(KWindow, msg: "请选择赛事", autoHidder: true)
                    return
                }
                UserDefaults.standard.set(self.filterType.rawValue, forKey: CLICKRELOADBASKETBALLEVENTYPETDATA)
            }
            self.clickCollectItemSave()
            
            (self.controller as! FilterViewController).filterViewControllerSaveClouse()
        }
    }
}

extension FilterViewModel : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.collectionViewDidSelect(collectView: collectionView, indexPath: indexPath)
    }
}

extension FilterViewModel : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return titles == nil ? 0 : titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.viewType == .football {
            let array = footBalleventsList!.object(forKey: titles[section]) as! NSArray
            return array.count
        }
        let array = basketBalleventsList!.object(forKey: titles[section]) as! NSArray
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath)
        
        
        if headerView.subviews.count == 0 {
            let titleLabel = YYLabel.init(frame: CGRect.init(x: 16, y: 5, width: 100, height: 20))
            titleLabel.textAlignment = .left
            titleLabel.font = App_Theme_PinFan_M_12_Font
            titleLabel.textColor = App_Theme_06070D_Color
            titleLabel.text = (titles[indexPath.section] as! String)
            headerView.addSubview(titleLabel)
        }else{
            let titleLabel = headerView.subviews[0] as! YYLabel
            titleLabel.text = (titles[indexPath.section] as! String)
        }
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.description(), for: indexPath)
        self.cellFilterCollectionViewCellSetData(indexPath, cell: cell as! FilterCollectionViewCell)
        return cell
    }
}
