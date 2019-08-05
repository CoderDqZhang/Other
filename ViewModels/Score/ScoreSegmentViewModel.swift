//
//  ScoreSegmentViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

enum ScoreDetailVC:Int {
    case basketball = 1
    case football = 0
}

enum ScoreDetailTypeVC:Int {
    case timely = 0
    case underway = 1
    case competition = 2
    case amidithion = 3
    case attention = 4
}

class ScoreSegmentViewModel: BaseViewModel {

    override init() {
        super.init()
        //广告
//        self.loadADUrl()
    }
    
    func loadADUrl(){
        let parameters = ["typeId" : "3"]
        BaseNetWorke.getSharedInstance().postUrlWithString(ADvertiseUsableAdvertise, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                let array = NSMutableArray.init(array: (resultDic.value as! Array))
                let model = AdModel.init(fromDictionary: array[0] as! [String : Any])
                CacheManager.getSharedInstance().saveADModel(category: model)
                LoadConfigManger.getSharedInstance().setUpADView(controller: self.controller!, model: model)
            }
        }
    }
    
    func pushScoreDetailViewController(_ data:NSDictionary, _ type:ScoreDetailVC,_ scoreType:ScoreDetailTypeVC, _ indexPath:IndexPath){
        
    }
    
    func pushMoreVC(){
        
    }
    
    func pushFilterVC(_ type:ScoreDetailVC){
        let fileterSegment = FilterSegmentViewController()
        fileterSegment.viewType = type
        fileterSegment.initSView(type: type.rawValue)
        //更新数据
        fileterSegment.filterSegmentViewControllerReloadDataClouse = {
            
        }
        NavigationPushView(self.controller!, toConroller: fileterSegment)
    }
}
