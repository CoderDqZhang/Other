//
//  LoadConfigManger.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class LoadConfigManger: NSObject {
    
    private static let _sharedInstance = LoadConfigManger()
    
    class func getSharedInstance() -> LoadConfigManger {
        return _sharedInstance
    }
    
    private override init() {} // 私有化init方法
    
    func setUp(){
        self.loadConfigUrl()
        self.loadUnreadUrl()
        self.loadPointdUrl()
    }
    
    func loadConfigUrl(){
        BaseNetWorke.getSharedInstance().getUrlWithString(CommentgetTimetUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                let model = ConfigModel.init(fromDictionary: resultDic.value as! [String : Any])
                CacheManager.getSharedInstance().saveConfigModel(category: model)
            }
        }
    }
    
    func loadUnreadUrl(){
        if CacheManager.getSharedInstance().isLogin() {
            let parameters = ["type":"0"]
            BaseNetWorke.getSharedInstance().postUrlWithString(NotifyUnreadUrl, parameters: parameters as AnyObject).observe { (resultDic) in
                if !resultDic.isCompleted {
                    let model = UnreadMessageModel.init(fromDictionary: resultDic.value as! [String : Any])
                    CacheManager.getSharedInstance().saveUnreadModel(category: model)
                    (KWindow.rootViewController as! MainTabBarController).upateUnreadMessage()
                }
            }
        }
    }
    
    func loadPointdUrl(){
        if CacheManager.getSharedInstance().isLogin() {
            BaseNetWorke.getSharedInstance().getUrlWithString(CommentgetPointUrl, parameters: nil).observe { (resultDic) in
                if !resultDic.isCompleted {
                    let model = NSMutableArray.init(array: resultDic.value as! Array)
                    CacheManager.getSharedInstance().savePointModel(point: model)
                }
            }
        }
    }
    
    func setUpADView(controller:BaseViewController, model:AdModel){
        let adView = AdView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT), url: model.image) {
            let controllerVC = AdViewController.init()
            controllerVC.url = model.url
            NavigationPushView(controller, toConroller: controllerVC)
        }
        KWindow.addSubview(adView)
    }
}

