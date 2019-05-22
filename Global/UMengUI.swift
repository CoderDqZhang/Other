//
//  UMengUI.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class UMengUI: NSObject {

    override init() {
        super.init()
        self.createPlatForm()
    }
    
    func createPlatForm(){
    UMSocialUIManager.setPreDefinePlatforms([NSNumber(integerLiteral:UMSocialPlatformType.wechatSession.rawValue),NSNumber(integerLiteral:UMSocialPlatformType.QQ.rawValue),NSNumber(integerLiteral:UMSocialPlatformType.sina.rawValue)])
        UMSocialUIManager.showShareMenuViewInWindow { (platformType, userInfo) in
            print(platformType)
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
