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
        BaseNetWorke.getSharedInstance().postUrlWithString(UserregisterUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if resultDic.value != nil {
                    let userInfo = UserInfoModel.init(fromDictionary: resultDic.value as! [String : Any])
                    CacheManager.getSharedInstance().saveUserInfo(userInfo: userInfo)
                    NotificationManager.getSharedInstance().addAlias(alias: userInfo.id.string)
                    UserDefaults.init().set(userInfo.token, forKey: CACHEMANAUSERTOKEN)
                    self.controller?.navigationController?.popToRootViewController(animated: true)
                }
                
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func sendCodeNetWork(phone:String){
        let parameters = ["phone":phone]
        BaseNetWorke.getSharedInstance().postUrlWithString(UsersendCodeUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                let userInfo = UserInfoModel.init(fromDictionary: resultDic.value as! [String : Any])
                CacheManager.getSharedInstance().saveUserInfo(userInfo: userInfo)
                NotificationManager.getSharedInstance().addAlias(alias: userInfo.id.string)
                UserDefaults.init().set(userInfo.token, forKey: CACHEMANAUSERTOKEN)
                self.controller?.navigationController?.popToRootViewController(animated: true)
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
}
