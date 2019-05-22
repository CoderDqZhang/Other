//
//  UMengManager.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

typealias UMengManagerShareResponse = (_ date:UMSocialShareResponse) ->Void
typealias UMengManagerUserInfoResponse = (_ data:UMSocialUserInfoResponse) ->Void
class UMengManager: NSObject {
    
    var umengManagerShareResponse:UMengManagerShareResponse!
    var umengManagerUserInfoResponse:UMengManagerUserInfoResponse!
    override init() {
        super.init()
    }
    static let shareInstance = UMengManager()
    
    func setUpUMengManger(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?){
        UMConfigure.initWithAppkey(UMengKey, channel: "App Store")
        //设置加密
        UMConfigure.setEncryptEnabled(true)
        //设置点对点
        MobClick.setScenarioType(.E_UM_NORMAL)
        
//        if UserInfoModel.isLoggedIn() {
//            MobClick.profileSignIn(withPUID: UserInfoModel.shareInstance().idField)
//        }else{
//            MobClick.profileSignIn(withPUID: "UserNoLogin")
//        }
        
    }
    
    func confitUShareSettings(){
        
    }
    
    func configUSharePlatforms(){
        //微信
        UMSocialManager.default()?.setPlaform(.wechatSession, appKey: "", appSecret: "", redirectURL: "")
        //微信
        UMSocialManager.default()?.setPlaform(.wechatTimeLine, appKey: "", appSecret: "", redirectURL: "")
        //QQ
        UMSocialManager.default()?.setPlaform(.QQ, appKey: "", appSecret: "", redirectURL: "")
        //QQ空间
        UMSocialManager.default()?.setPlaform(.qzone, appKey: "", appSecret: "", redirectURL: "")
        //新浪
        UMSocialManager.default()?.setPlaform(.sina, appKey: "", appSecret: "", redirectURL: "")
    }
    
    func loginWithPlatform(type:UMSocialPlatformType,controller:BaseViewController){
        UMSocialManager.default()?.getUserInfo(with: type, currentViewController: controller, completion: { (result, error) in
            if error != nil {
                
            }else{
                if result is UMSocialUserInfoResponse {
                    if self.umengManagerUserInfoResponse != nil {
                        let resp = result as! UMSocialUserInfoResponse
                        self.umengManagerUserInfoResponse(resp)
                    }
                }
            }
        })
    }
    
    func sharePlatformImageTitle(type:UMSocialPlatformType, title:String, descr:String,thumImage:UIImage,controller:BaseViewController){
        let object = UMSocialMessageObject.init()
        let shareObject = UMShareImageObject.shareObject(withTitle: title, descr: descr, thumImage: thumImage)
        object.shareObject = shareObject
        UMSocialManager.default()?.share(to: type, messageObject: object, currentViewController: controller, completion: { (dic, error) in
            if error != nil {
                print("error")
            }else{
                if (dic is UMSocialShareResponse) {
                    let resp = dic as! UMSocialShareResponse
                    if self.umengManagerShareResponse != nil {
                        self.umengManagerShareResponse(resp)
                    }
                }
            }
        })
    }
    
    func sharePlatformImage(type:UMSocialPlatformType,thumImage:UIImage,image_url:String, controller:BaseViewController){
        let object = UMSocialMessageObject.init()
        let shareObject = UMShareImageObject.init()
        shareObject.thumbImage = thumImage
        shareObject.shareImage = image_url
        object.shareObject = shareObject
        UMSocialManager.default()?.share(to: type, messageObject: object, currentViewController: controller, completion: { (dic, error) in
            if error != nil {
                print("error")
            }else{
                if (dic is UMSocialShareResponse) {
                    let resp = dic as! UMSocialShareResponse
                    if self.umengManagerShareResponse != nil {
                        self.umengManagerShareResponse(resp)
                    }
                }
            }
        })
    }
    
    func sharePlatformWeb(type:UMSocialPlatformType, title:String,descr:String,thumImage:UIImage, web_url:String, controller:BaseViewController) {
        let object = UMSocialMessageObject.init()
        let webObject = UMShareWebpageObject.shareObject(withTitle: title, descr: descr, thumImage: thumImage)
        webObject?.webpageUrl = web_url
        object.shareObject = webObject
        UMSocialManager.default()?.share(to: type, messageObject: object, currentViewController: controller, completion: { (dic, error) in
            if error != nil {
                print("error")
            }else{
                if (dic is UMSocialShareResponse) {
                    let resp = dic as! UMSocialShareResponse
                    if self.umengManagerShareResponse != nil {
                        self.umengManagerShareResponse(resp)
                    }
                }
            }
        })
    }
}
