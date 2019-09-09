//
//  LoginViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/21.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class ThirdLoginModel: NSObject {
    var openId:String!
    var type:String!
    var nickname:String!
    var img:String!
    var descriptions:String!
}

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
                    NotificationManager.getSharedInstance().addAlias(alias: userInfo.id.string)
                    UserDefaults.init().set(userInfo.token, forKey: CACHEMANAUSERTOKEN)
                    (self.controller as! LoginViewController).navigationController?.popViewController(animated: true, {
                        if (self.controller as! LoginViewController).loginDoneClouse != nil {
                            (self.controller as! LoginViewController).loginDoneClouse()
                        }
                    })
                    //登录成功后读取未读消息数量
                    LoadConfigManger.getSharedInstance().loadUnreadUrl()
                    self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
                    
                    //登录成功后执行操作
                    
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
                    NotificationManager.getSharedInstance().addAlias(alias: userInfo.id.string)
                    CacheManager.getSharedInstance().saveUserInfo(userInfo: userInfo)
                    UserDefaults.init().set(userInfo.token, forKey: CACHEMANAUSERTOKEN)
                    (self.controller as! LoginViewController).navigationController?.popViewController(animated: true, {
                        if (self.controller as! LoginViewController).loginDoneClouse != nil {
                            (self.controller as! LoginViewController).loginDoneClouse()
                        }
                    })
                    //登录成功后读取未读消息数量
                    LoadConfigManger.getSharedInstance().loadUnreadUrl()
                    self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
                }
                
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func loginThirdPlathom(model:ThirdLoginModel){
        let parameters = ["openId":model.openId, "type":model.type,"nickname":model.nickname,"img":model.img,"description":model.descriptions]
        BaseNetWorke.getSharedInstance().postUrlWithString(UserLoginThirdPartyUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if resultDic.value != nil {
                    if resultDic.value is NSDictionary {
                        let userInfo = UserInfoModel.init(fromDictionary: resultDic.value as! [String : Any])
                        CacheManager.getSharedInstance().saveUserInfo(userInfo: userInfo)
                        NotificationManager.getSharedInstance().addAlias(alias: userInfo.id.string)
                        UserDefaults.init().set(userInfo.token, forKey: CACHEMANAUSERTOKEN)
                        (self.controller as! LoginViewController).navigationController?.popToRootViewController(animated: true)
                        //登录成功后读取未读消息数量
                        LoadConfigManger.getSharedInstance().loadUnreadUrl()
                        self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
                    }else{
                        let bindPhoneVC = BindPhoneViewController()
                        bindPhoneVC.openId = model.openId
                        NavigationPushView(self.controller!, toConroller: bindPhoneVC)
                    }
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
