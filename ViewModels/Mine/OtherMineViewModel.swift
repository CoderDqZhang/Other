//
//  OtherMineViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/20.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class OtherMineViewModel: BaseViewModel {
    
    override init() {
        super.init()
    }
    
    
    func getUserInfoNet(userId:String){
        let parameters = ["userId":userId]
        BaseNetWorke.sharedInstance.getUrlWithString(UserInfoUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                let model = UserInfoModel.init(fromDictionary: resultDic.value as! [String : Any])
                (self.controller as! OtherMineViewController).gloableNavigationBar.changeToolsButtonType(followed: model.isFollow == 1 ? false : true)
                (self.controller as! OtherMineViewController).userHeader.cellSetData(model: model)
            }
        }
    }
    
    func followNet(userId:String, status:Bool){
        let parameters = ["userId":userId]
        BaseNetWorke.sharedInstance.postUrlWithString(PersonfollowUserUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if status {
                    _ = Tools.shareInstance.showMessage(KWindow, msg: "取消关注成功", autoHidder: true)
                }else{
                    _ = Tools.shareInstance.showMessage(KWindow, msg: "关注成功", autoHidder: true)
                }
                self.changeFollowStatus(status: !status)
            }
        }
    }
    
    func changeFollowStatus(status:Bool){
        (self.controller as! OtherMineViewController).gloableNavigationBar.changeToolsButtonType(followed: status)
        (self.controller as! OtherMineViewController).userHeader.changeToolsButtonType(followed: status)
    }
    
    func pushPostDetailViewController(_ data:NSDictionary, _ type:PostType) {
        let postDetail = PostDetailViewController()
        postDetail.postData = data
        postDetail.postType = type
        NavigationPushView(self.controller!, toConroller: postDetail)
    }
}
