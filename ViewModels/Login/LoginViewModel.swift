//
//  LoginViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/21.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class LoginViewModel: BaseViewModel {

    override init() {
        super.init()
    }
    
    func loginCodeNetWork(phone:String,code:String){
        let parameters = ["username":phone, "code":code]
        BaseNetWorke.sharedInstance.postUrlWithString(UserLoginUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if resultDic.value != nil {
                    let userInfo = UserInfoModel.init(fromDictionary: resultDic.value as! [String : Any])
                    CacheManager.getSharedInstance().saveUserInfo(userInfo: userInfo)
                    UserDefaults.init().set(userInfo.token, forKey: "UserToken")
                    (self.controller as! LoginViewController).navigationController?.popToRootViewController(animated: true)
                }
                
            }
        }
    }
    
    func loginPasswordNetWork(phone:String,password:String){
        let parameters = ["username":phone, "password":AddAESKeyPassword(str: password)]
        BaseNetWorke.sharedInstance.postUrlWithString(UserLoginUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if resultDic.value != nil {
                    let userInfo = UserInfoModel.init(fromDictionary: resultDic.value as! [String : Any])
                    CacheManager.getSharedInstance().saveUserInfo(userInfo: userInfo)
                    UserDefaults.init().set(userInfo.token, forKey: "UserToken")
                    (self.controller as! LoginViewController).navigationController?.popToRootViewController(animated: true)
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
