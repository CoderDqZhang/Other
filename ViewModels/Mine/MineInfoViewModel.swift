//
//  MineInfoViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit


class MineInfoViewModel: BaseViewModel {
    
    let titles = [["头像","名称","个人简介","手机号","电子邮箱"],["微信"]]
    var userInfo:UserInfoModel!
    var desc:[[String]]!
    override init() {
        super.init()
    }
    
    func bindLoginc(){
        if CacheManager.getSharedInstance().isLogin() {
            if userInfo == nil {
                userInfo = CacheManager.getSharedInstance().getUserInfo()!
            }
            desc = [["",userInfo.nickname,userInfo.descriptionField,userInfo.phone,userInfo.email],[userInfo.openId == "0" ? "已绑定" : "未绑定"]]
        }
    }
    
    func tableViewTitleLableAndDetailLabelDescRightSetData(_ indexPath:IndexPath, cell:TitleLableAndDetailLabelDescRight) {
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.cellSetData(title: titles[indexPath.section][indexPath.row], desc: desc[indexPath.section][indexPath.row], leftImage: nil, rightImage: userInfo.img, isDescHidden: false)
        }else{
            cell.cellSetData(title: titles[indexPath.section][indexPath.row], desc: desc[indexPath.section][indexPath.row], leftImage: nil, rightImage: nil, isDescHidden: false)
        }
        if indexPath.row == titles[indexPath.section].count - 1 {
            cell.lineLableHidden()
        }
        cell.updateDescFontAndColor(App_Theme_06070D_Color!, App_Theme_PinFan_R_14_Font!)
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                (self.controller as! MineInfoViewController).setUpAlerViewController()
            }else if indexPath.row == 1 {
                let changeInfo = ChangeInfoViewController()
                changeInfo.changeInfoViewControllerClouse = { type,str in
                    self.updateuserInfo(key: "nickname", value: str)
                    self.userInfo.nickname = str
                }
                changeInfo.changeInfoType(text: "", type: .name, placeholder: "更改名称")
                NavigaiontPresentView(self.controller!, toController: UINavigationController.init(rootViewController: changeInfo))
            }else if indexPath.row == 2{
                let changeInfo = ChangeInfoViewController()
                changeInfo.changeInfoViewControllerClouse = { type,str in
                    self.updateuserInfo(key: "description", value: str)
                    self.userInfo.descriptionField = str
                }
                changeInfo.changeInfoType(text: "", type: .desc, placeholder: "更改简介")
                NavigaiontPresentView(self.controller!, toController: UINavigationController.init(rootViewController: changeInfo))
            }else if indexPath.row == 4 {
                let changeInfo = ChangeInfoViewController()
                changeInfo.changeInfoViewControllerClouse = { type,str in
                    self.updateuserInfo(key: "email", value: str)
                    self.userInfo.email = str
                }
                changeInfo.changeInfoType(text: "", type: .email, placeholder: "更改邮箱")
                NavigaiontPresentView(self.controller!, toController: UINavigationController.init(rootViewController: changeInfo))
            }
            
        default:
            self.loginThirdPard()
            
        }
    }
    
    func updateuserInfo(key:String,value:String){
        let parameters = ["key":key,"value":value]
        BaseNetWorke.getSharedInstance().postUrlWithString(PersonupdateUserUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.bindLoginc()
                if key != "img" {
                    self.reloadTableViewData()
                }
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func loginThirdPard(){
        UMengManager.getSharedInstance().loginWithPlatform(type: UMSocialPlatformType.wechatSession, controller: self.controller!, loginType: .weichat)
        UMengManager.getSharedInstance().umengManagerUserInfoResponse = { response,type in
            let model = ThirdLoginModel()
            model.openId = response.openid
            model.nickname = ((response.originalResponse as! NSDictionary).object(forKey: "nickname") as! String)
            model.img = ((response.originalResponse as! NSDictionary).object(forKey: "headimgurl") as! String)
            model.type = "0"
            model.descriptions = ""
            self.bindPhone(model:model)
        }
    }
    
    func bindPhone(model:ThirdLoginModel){
        let parameters = ["openId":model.openId, "type":model.type,"nickname":model.nickname,"img":model.img,"description":model.descriptions]
        BaseNetWorke.getSharedInstance().postUrlWithString(UserLoginThirdPartyUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if resultDic.value != nil {
                    _ = Tools.shareInstance.showMessage(KWindow, msg: "绑定成功", autoHidder: true)
                    self.desc[1][0] = "已绑定"
                    self.userInfo.openId = "0"
                    self.reloadTableViewData()
                    
                }
                
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
}


extension MineInfoViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 47
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension MineInfoViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titles[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleLableAndDetailLabelDescRight.description(), for: indexPath)
        self.tableViewTitleLableAndDetailLabelDescRightSetData(indexPath, cell: cell as! TitleLableAndDetailLabelDescRight)
        cell.selectionStyle = .none
        return cell
    }
}
