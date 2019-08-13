//
//  UMengManager.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

typealias UMengManagerShareResponse = (_ date:UMSocialShareResponse) ->Void
typealias UMengManagerUserInfoResponse = (_ data:UMSocialUserInfoResponse, _ type:GloableThirdLoginType) ->Void
class UMengManager: NSObject {
    
    var umengManagerShareResponse:UMengManagerShareResponse!
    var umengManagerUserInfoResponse:UMengManagerUserInfoResponse!
    
    private static let _sharedInstance = UMengManager()
    
    class func getSharedInstance() -> UMengManager {
        return _sharedInstance
    }
    
    private override init() {} // 私有化init方法
    
    func setUpUMengManger(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?){
        UMConfigure.initWithAppkey(UMengKey, channel: "App Store")
        //设置加密
        UMConfigure.setEncryptEnabled(true)
        //设置点对点
        MobClick.setScenarioType(.E_UM_NORMAL)
        //设置自动采集模板
        MobClick.setAutoPageEnabled(true)
        MobClick.setCrashReportEnabled(true)
        UMengManager.getSharedInstance().configUSharePlatforms()
        UMengManager.getSharedInstance().confitUShareSettings()
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
        UMSocialManager.default()?.setPlaform(.wechatSession, appKey: WeiXinAppID, appSecret: WeiXinAppSecret, redirectURL: "")
        //微信
        UMSocialManager.default()?.setPlaform(.wechatTimeLine, appKey: WeiXinAppID, appSecret: WeiXinAppSecret, redirectURL: "")
        //QQ
        UMSocialManager.default()?.setPlaform(.QQ, appKey: QQAPPID, appSecret: QQAPPKEY, redirectURL: "")
        //QQ空间
        UMSocialManager.default()?.setPlaform(.qzone, appKey: QQAPPID, appSecret: QQAPPKEY, redirectURL: "")
        //新浪
        UMSocialManager.default()?.setPlaform(.sina, appKey: WeiboAPPKEY, appSecret: WeiboAppSecret, redirectURL: WeiboRedirectUrl)
    }
    
    func loginWithPlatform(type:UMSocialPlatformType,controller:BaseViewController, loginType:GloableThirdLoginType){
        UMSocialManager.default()?.getUserInfo(with: type, currentViewController: controller, completion: { (result, error) in
            if error != nil {
                print(error ?? "")
            }else{
                if result is UMSocialUserInfoResponse {
                    if self.umengManagerUserInfoResponse != nil {
                        let resp = result as! UMSocialUserInfoResponse
                        self.umengManagerUserInfoResponse(resp,loginType)
                    }
                }
            }
        })
    }
    
    //文字加多媒体
    func sharePlatformImageTitle(type:UMSocialPlatformType, title:String, descr:String,thumImage:UIImage,controller:BaseViewController,completion:UMSocialRequestCompletionHandler){
        let object = UMSocialMessageObject.init()
        object.title = title
        object.text = descr
        let shareObject = UMShareImageObject.shareObject(withTitle: title, descr: descr, thumImage: thumImage)
        shareObject?.title = title
        shareObject?.descr = descr
        shareObject?.thumbImage = thumImage
        shareObject?.shareImage = thumImage
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
    
    //单纯分享图片
    func sharePlatformImage(type:UMSocialPlatformType,thumImage:UIImage,image_url:String, controller:BaseViewController,completion:UMSocialRequestCompletionHandler){
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
    
    //分享网页链接
    func sharePlatformWeb(type:UMSocialPlatformType, title:String,descr:String,thumImage:UIImage, web_url:String, controller:BaseViewController,completion:UMSocialRequestCompletionHandler) {
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
