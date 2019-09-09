//
//  UMengUI.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class UMengUI: NSObject {

    
    private static let _sharedInstance = UMengUI()
    
    class func getSharedInstance() -> UMengUI {
        return _sharedInstance
    }
    
    private override init() {
        super.init()
    } // 私有化init方法
    
    func createPlatForm(block:@escaping UMSocialSharePlatformSelectionBlock){
    UMSocialUIManager.setPreDefinePlatforms([NSNumber(integerLiteral:UMSocialPlatformType.wechatSession.rawValue),NSNumber(integerLiteral:UMSocialPlatformType.QQ.rawValue),NSNumber(integerLiteral:UMSocialPlatformType.sina.rawValue),NSNumber(integerLiteral:UMSocialPlatformType.dingDing.rawValue),NSNumber(integerLiteral:UMSocialPlatformType.qzone.rawValue)])
        UMSocialUIManager.showShareMenuViewInWindow { (platformType, userInfo) in
            print(platformType)
            block(platformType, userInfo)
        }
        UMSocialUIManager.setShareMenuViewDelegate(self)
    }
    
    func configShareUIConfig(){
        UMSocialShareUIConfig.shareInstance()?.shareTitleViewConfig.isShow = false
    }
}

extension UMengUI : UMSocialShareMenuViewDelegate {
    func umSocialShareMenuViewDidAppear() {
        
    }
    
    func umSocialShareMenuViewDidDisappear() {
        
    }
}
