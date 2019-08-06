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
        //获取球队信息
//        self.loadScorTeam()
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
    
//    func loadScorTeam(){
//        if CacheManager.getSharedInstance().getFootTeamBallModel() == nil {
//            BaseNetWorke.getSharedInstance().sportnanoApi(url: FootBallInfoUrl, parameters: nil, success: { (resultDic) in
//                let models = NSMutableArray.init(array: resultDic as! Array)
//                let sql_models:NSMutableArray = NSMutableArray.init()
//                for model in models{
//                    let temp_model = BallTeamSqlModel.init(fromDictionary: ["id":(model as! NSDictionary).object(forKey: "id") as Any,"team":BallTeamModel.init(fromDictionary: model as! [String : Any])])
//                    sql_models.add(temp_model)
//                }
//                CacheManager.getSharedInstance().saveFootTeamBallModel(point: sql_models)
//            }) { (failt) in
//                print("请求失败")
//            }
//        }
//    }
}

