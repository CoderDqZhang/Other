//
//  StoreDetailViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/10/12.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class StoreDetailViewModel: BaseViewModel {

    override init() {
        super.init()
    }
    
    func exchangeNet(goodsId:String, remark:String){
        let parameters = ["remark":remark, "goodsId":goodsId, "platformType":"0"]
        BaseNetWorke.getSharedInstance().postUrlWithString(StoreGoodsAddBuyUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "兑换成功", autoHidder: true)
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
}
