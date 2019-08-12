//
//  FilterViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/1.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class FilterViewModel: BaseViewModel {

    var titles:NSArray = NSArray.init(array: ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","S","Y","Z"])
    let footBalleventsList = CacheManager.getSharedInstance().getFootBallEventModel()
    let basketBalleventsList = CacheManager.getSharedInstance().getBasketBallEventModel()
    var viewType:ScoreDetailVC!
    
    override init() {
        super.init()
    }
    
    func cellFilterCollectionViewCellSetData(_ indexPath:IndexPath, cell:
        FilterCollectionViewCell){
        if self.viewType == .football {
            let array = footBalleventsList?.object(forKey: titles[indexPath.section]) as! NSArray
            cell.cellSetData(indexPath, model: FootBallEventModel.init(fromDictionary: array[indexPath.row] as! [String : Any]))
        }else{
            let array = basketBalleventsList?.object(forKey: titles[indexPath.section]) as! NSArray
            cell.cellSetBaketBallData(indexPath, model: BasketballEvent.init(fromDictionary: array[indexPath.row] as! [String : Any]))
        }
    }
    
    func collectionViewDidSelect(collectView:UICollectionView, indexPath:IndexPath){
        if self.viewType == .football {
            let array = footBalleventsList?.object(forKey: titles[indexPath.section]) as! NSArray
            let dic = array[indexPath.row]
            (array[indexPath.row] as! NSDictionary).setValue(!((dic as! NSDictionary).object(forKey: "is_select") as! Bool), forKey: "is_select")
            self.footBallNumberOfSelect(isAdd: (dic as! NSDictionary).object(forKey: "is_select") as! Bool)
            collectView.reloadData()
        }else{
            let array = basketBalleventsList?.object(forKey: titles[indexPath.section]) as! NSArray
            let dic = array[indexPath.row]
            (dic as! NSDictionary).setValue(!((dic as! NSDictionary).object(forKey: "is_select") as! Bool), forKey: "is_select")
            self.basketBallNumberOfSelect(isAdd: (dic as! NSDictionary).object(forKey: "is_select") as! Bool)
            collectView.reloadData()
        }
        
    }
    
    func footBallNumberOfSelect(isAdd:Bool){
        var number = 0
        if UserDefaults.standard.bool(forKey: "football\(Date.init().string(withFormat: "yyyyMMdd"))") {
            let temp = isAdd ? 1 : -1
            number = UserDefaults.standard.object(forKey: "football\(Date.init().string(withFormat: "yyyyMMdd"))") as! Int + temp
            UserDefaults.standard.set(number, forKey: "football\(Date.init().string(withFormat: "yyyyMMdd"))")
        }else{
            for name in footBalleventsList!.allKeys {
                number = number + (footBalleventsList!.object(forKey: name) as! NSArray).count
            }
            UserDefaults.standard.set(number, forKey: "football\(Date.init().string(withFormat: "yyyyMMdd"))")
        }
        (self.controller! as! FilterViewController).buttomView.changeSelectLabelText(number: number.string)
    }
    
    func basketBallNumberOfSelect(isAdd:Bool){
        var number = 0
        if UserDefaults.standard.bool(forKey: "basket\(Date.init().string(withFormat: "yyyyMMdd"))") {
            let temp = isAdd ? 1 : -1
            number = UserDefaults.standard.object(forKey: "basket\(Date.init().string(withFormat: "yyyyMMdd"))") as! Int + temp
            UserDefaults.standard.set(number, forKey: "basket\(Date.init().string(withFormat: "yyyyMMdd"))")
        }else{
            for name in basketBalleventsList!.allKeys {
                number = number + (basketBalleventsList!.object(forKey: name) as! NSArray).count
            }
            UserDefaults.standard.set(number, forKey: "basket\(Date.init().string(withFormat: "yyyyMMdd"))")
        }
        (self.controller! as! FilterViewController).buttomView.changeSelectLabelText(number: number.string)
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
                 UserDefaults.standard.set(number, forKey: "football\(Date.init().string(withFormat: "yyyyMMdd"))")
            }else{
                for name in basketBalleventsList!.allKeys {
                    number = number + (basketBalleventsList!.object(forKey: name) as! NSArray).count
                    for dic in (basketBalleventsList!.object(forKey: name) as! NSArray) {
                        (dic as! NSDictionary).setValue(true, forKey: "is_select")
                    }
                }
                UserDefaults.standard.set(number, forKey: "basket\(Date.init().string(withFormat: "yyyyMMdd"))")
            }
        }else{
            if self.viewType == .football {
                for name in footBalleventsList!.allKeys {
                    for dic in (footBalleventsList!.object(forKey: name) as! NSArray) {
                        (dic as! NSDictionary).setValue(false, forKey: "is_select")
                    }
                }
                UserDefaults.standard.set(number, forKey: "football\(Date.init().string(withFormat: "yyyyMMdd"))")
            }else{
                for name in basketBalleventsList!.allKeys {
                    for dic in (basketBalleventsList!.object(forKey: name) as! NSArray) {
                        (dic as! NSDictionary).setValue(false, forKey: "is_select")
                    }
                }
                UserDefaults.standard.set(number, forKey: "basket\(Date.init().string(withFormat: "yyyyMMdd"))")
            }
        }
        (self.controller! as! FilterViewController).collectionView.reloadData()
        (self.controller! as! FilterViewController).buttomView.changeSelectLabelText(number: number.string)
    }
    
    func saveEvent(){
        if self.viewType == .football {
            CacheManager.getSharedInstance().saveFootBallEventModel(point: self.footBalleventsList!)
        }else{
            CacheManager.getSharedInstance().saveBasketBallEventModel(point: self.basketBalleventsList!)
        }
        self.controller?.navigationController?.popViewController()
    }
}

extension FilterViewModel : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.collectionViewDidSelect(collectView: collectionView, indexPath: indexPath)
    }
}

extension FilterViewModel : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return titles.count
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
