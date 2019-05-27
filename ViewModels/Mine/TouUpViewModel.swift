//
//  TouUpViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/27.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class TouUpViewModel: BaseViewModel {

    override init() {
        super.init()
    }
    
    func getAccount(){
        BaseNetWorke.sharedInstance.postUrlWithString(AccountfindAccountUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                let model = AccountCoinsModel.init(fromDictionary: resultDic.value as! [String : Any])
                (self.controller! as! TopUpViewController).coinsView.viewSetData(model: model)
            }
        }
    }
}
