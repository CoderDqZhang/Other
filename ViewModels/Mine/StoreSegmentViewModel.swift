//
//  StoreSegmentViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/30.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class StoreSegmentViewModel: BaseViewModel {

    override init() {
        super.init()
    }
    
    func getAccountInfoNet(){
        BaseNetWorke.getSharedInstance().postUrlWithString(AccountfindAccountUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                let accountInfo = AccountInfoModel.init(fromDictionary: resultDic.value as! [String : Any])
                (self.controller! as! StoreSegementViewController).userHeader.storeViewChangeText(accountInfo.integral.string)
            }
        }
    }
}
