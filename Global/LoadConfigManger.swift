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
    }
    
    func loadConfigUrl(){
        BaseNetWorke.getSharedInstance().getUrlWithString(CommentgetTimetUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                let model = ConfigModel.init(fromDictionary: resultDic.value as! [String : Any])
                CacheManager.getSharedInstance().saveConfigModel(category: model)
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func loadUnreadUrl(){
        BaseNetWorke.getSharedInstance().postUrlWithString(NotifyUnreadUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                let model = UnreadMessageModel.init(fromDictionary: resultDic.value as! [String : Any])
                CacheManager.getSharedInstance().saveUnreadModel(category: model)
                (KWindow.rootViewController as! MainTabBarController).upateUnreadMessage()
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
}

