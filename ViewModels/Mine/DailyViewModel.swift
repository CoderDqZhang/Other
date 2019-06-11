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
        self.getDailyNet()
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
