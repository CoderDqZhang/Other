//
//  DailyViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/11.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class DailyViewModel: BaseViewModel {

    var model:DailyModel!
    override init() {
        super.init()
        self.getDailyStatus()
    }
    
    func getDailyStatus(){
        BaseNetWorke.getSharedInstance().postUrlWithString(PersonsignStatusInUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.model = DailyModel.init(fromDictionary: resultDic.value as! [String : Any])
                self.updatePoints()
                (self.controller as! DailyViewController).updateDailyModel(model: self.model)
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
        
    }
    
    func getDailyNet(){
        BaseNetWorke.getSharedInstance().getUrlWithString(PersonsignInUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.model.signIn = self.model.signIn + 1
                self.model.status = 1
                self.updatePoints()
                (self.controller as! DailyViewController).updateDailyModel(model: self.model)
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func updatePoints(){
        let pointModels = CacheManager.getSharedInstance().getPointModel()
        if pointModels == nil {
            LoadConfigManger.getSharedInstance().loadPointdUrl()
            return
        }
        for item in pointModels! {
            
            if (item as! NSDictionary).object(forKey: "typeId") as! Int == 2 && (item as! NSDictionary).object(forKey: "text") as! String == model.signIn.string {
                self.model.points = ((item as! NSDictionary).object(forKey: "value") as? String)!
            }
        }
    }
}
