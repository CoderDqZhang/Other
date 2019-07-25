//
//  BackGroundManager.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/25.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class BackGroundManager: NSObject {
    private static let _sharedInstance = BackGroundManager()
    
    class func getSharedInstance() -> BackGroundManager {
        return _sharedInstance
    }
    
    private override init() {} // 私有化init方法
    
    func background(){
        let date = NSDate.dateNow()
        let timeNow = date!.timeIntervalSince1970
        let model = APPActiveModel.init(fromDictionary: ["background":timeNow,"active":0])
        CacheManager.getSharedInstance().saveAPPActiveModel(category: model)
        
        SocketManager.getSharedInstance().mSocket.disconnect()
    }
    
    func active(){
        let model = CacheManager.getSharedInstance().getAPPActiveModel()
        if model != nil {
            let date = NSDate.dateNow()
            let timeNow = date!.timeIntervalSince1970
            let backDate = NSDate.init(timeIntervalSince1970: timeNow)
            let time = backDate.minutes(before: date)
            if time > 0 {
                LoadConfigManger.getSharedInstance().setUpADView(controller: current() as! BaseViewController, model: CacheManager.getSharedInstance().getADModel()!)
            }
        }
        
        SocketManager.getSharedInstance().connect()
    }
}
