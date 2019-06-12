//
//  DailyViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/11.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class DailyViewModel: BaseViewModel {

    override init() {
        super.init()
        self.getDailyStatus()
    }
    
    func getDailyStatus(){
        BaseNetWorke.getSharedInstance().postUrlWithString(PersonsignStatusInUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                let model = DailyModel.init(fromDictionary: resultDic.value as! [String : Any])
                (self.controller as! DailyViewController).updateDailyModel(model: model)
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
        
    }
    
    func getDailyNet(){
        BaseNetWorke.getSharedInstance().getUrlWithString(PersonsignInUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
}
