//
//  StoreInfoViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class StoreInfoViewModel: BaseViewModel {

    var storeList = NSMutableArray.init()
    var page = 0
    
    override init() {
        super.init()
    }
    
    func cellStoreInfoCollectionViewCellSetData(_ indexPath:IndexPath, cell:StoreInfoCollectionViewCell) {
        if self.storeList.count > 0 {
            cell.cellSetData(model: StoreInfoModel.init(fromDictionary: self.storeList[indexPath.row] as! [String : Any]))
        }
    }
    
    func collectionViewDidSelect(collectView: UICollectionView, indexPath: IndexPath) {
        let stroreDetailVC = StoreDetailViewController()
        let model = StoreInfoModel.init(fromDictionary: self.storeList[indexPath.row] as! [String : Any])
        stroreDetailVC.goodsId = model.id.string
        stroreDetailVC.loadPage(url: "\(StoreUrl)\(model.id!)")
        NavigationPushView(self.controller!, toConroller: stroreDetailVC)
    }
    
    func getStoreList(){
        page = page + 1
        let parameters = ["page":page.string, "limit":LIMITNUMBER] as [String : Any]
        BaseNetWorke.getSharedInstance().getUrlWithString(StoreGoodsListUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if self.page != 1 {
                    self.storeList.addObjects(from: NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array) as! [Any])
                }else{
                    self.storeList = NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array)
                }
                (self.controller! as! StoreInfoViewController).collectionView.reloadData()
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
}

extension StoreInfoViewModel : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.collectionViewDidSelect(collectView: collectionView, indexPath: indexPath)
    }
}

extension StoreInfoViewModel : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storeList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreInfoCollectionViewCell.description(), for: indexPath)
        self.cellStoreInfoCollectionViewCellSetData(indexPath, cell: cell as! StoreInfoCollectionViewCell)
        return cell
    }
}
