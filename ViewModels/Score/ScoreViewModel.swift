//
//  ScoreViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/25.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class ScoreViewModel: BaseViewModel {

    override init() {
        super.init()
        self.loadADUrl()
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
}
