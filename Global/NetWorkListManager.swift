//
//  NetWorkListManager.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/5.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import Alamofire

class NetWorkListManager: NSObject {
    
    let net = NetworkReachabilityManager()
    
    private static let _sharedInstance = NetWorkListManager()
    
    class func getSharedInstance() -> NetWorkListManager {
        return _sharedInstance
    }
    
    private override init() {
        net?.startListening()
    } // 私有化init方法
    
    
    func netWorkList(_ listener:Alamofire.NetworkReachabilityManager.Listener?) {
        net?.listener  = { status in
            listener!(status)
            if self.net?.isReachable ?? false{
                switch status{
                case .notReachable:
                    print("the noework is not reachable")
                case .unknown:
                    print("It is unknown whether the network is reachable")
                case .reachable(.ethernetOrWiFi):
                    print("通过WiFi链接")
                case .reachable(.wwan):
                    print("通过移动网络链接")
                }
            } else {
                print("网络不可用")
            }
        }
    }
}
