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
        BaseNetWorke.getSharedInstance().postUrlWithString(UserLoginUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if resultDic.value != nil {
                    let userInfo = UserInfoModel.init(fromDictionary: resultDic.value as! [String : Any])
                    CacheManager.getSharedInstance().saveUserInfo(userInfo: userInfo)
                    UserDefaults.init().set(userInfo.token, forKey: "UserToken")
                    (self.controller as! LoginViewController).navigationController?.popToRootViewController(animated: true)
                }
                
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func loginPasswordNetWork(phone:String,password:String){
        let parameters = ["username":phone, "password":AddAESKeyPassword(str: password)]
        BaseNetWorke.getSharedInstance().postUrlWithString(UserLoginUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if resultDic.value != nil {
                    let userInfo = UserInfoModel.init(fromDictionary: resultDic.value as! [String : Any])
                    CacheManager.getSharedInstance().saveUserInfo(userInfo: userInfo)
                    UserDefaults.init().set(userInfo.token, forKey: "UserToken")
                    (self.controller as! LoginViewController).navigationController?.popToRootViewController(animated: true)
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
                _ = Tools.shareInstance.showMessage(KWindow, msg: "发送验证码成功", autoHidder: true)
                //                let userInfo = UserInfoModel.yy_model(with: (resultDic.value as! [AnyHashable : Any]))
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
}
