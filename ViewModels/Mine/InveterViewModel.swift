//
//  InveterViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/11.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class InveterViewModel: BaseViewModel {

    var inviteModel:InviteModel!
    override init() {
        super.init()
        self.getInviteNet()
    }
    
    func getInviteNet(){
        BaseNetWorke.getSharedInstance().postUrlWithString(AccountfindInviteUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.inviteModel = InviteModel.init(fromDictionary: resultDic.value as! [String : Any])
                let view = (self.controller as! InviteUserViewController).view.viewWithTag(1000)?.viewWithTag(2000)
                self.updateText(view: view!)
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func updateText(view:UIView){
        let inviteNoLabel = view.viewWithTag(100) as! YYLabel
        inviteNoLabel.text = self.inviteModel.inviteNo.string
        
        let recomCoinLabel = view.viewWithTag(200) as! YYLabel
        recomCoinLabel.text = self.inviteModel.recomCoin.string
        
        let firstNumLabel = view.viewWithTag(300) as! YYLabel
        firstNumLabel.text = self.inviteModel.firstNum.string
        
        let secondeNumLabel = view.viewWithTag(400) as! YYLabel
        secondeNumLabel.text = self.inviteModel.secondNum.string
        
        let thirdNumLabel = view.viewWithTag(500) as! YYLabel
        thirdNumLabel.text = self.inviteModel.thirdNum.string
    }
}
