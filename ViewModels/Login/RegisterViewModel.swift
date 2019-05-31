//
//  RegisterViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import YYCache

class RegisterViewModel: BaseViewModel {

    override init() {
        super.init()
    }
    
    func resgisterNetWork(phone:String,password:String,code:String){
        let parameters = ["phone":phone, "password":AddAESKeyPassword(str: password), "code":code]
        BaseNetWorke.sharedInstance.postUrlWithString(UserregisterUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if resultDic.value != nil {
                    let userInfo = UserInfoModel.yy_model(with: (resultDic.value as! [AnyHashable : Any]))
                    CacheManager.getSharedInstance().saveUserInfo(userInfo: userInfo!)
                    self.controller?.navigationController?.popToRootViewController(animated: true)
                }
                
            }
        }
    }
    
    func sendCodeNetWork(phone:String){
        let parameters = ["phone":phone]
        BaseNetWorke.sharedInstance.postUrlWithString(UsersendCodeUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
//                let userInfo = UserInfoModel.yy_model(with: (resultDic.value as! [AnyHashable : Any]))
            }
        }
    }
}
