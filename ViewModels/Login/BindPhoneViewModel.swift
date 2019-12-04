//
//  BindPhoneViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class BindPhoneViewModel: BaseViewModel {

    let titles = ["手机号","验证码"]
    let placeholders = ["请输入手机号码","请输入验证码"]
    var phoneSingle:Signal<Bool, Never>?
    var codeSingle:Signal<Bool, Never>?
    var phone:String = ""
    var code:String = ""
    override init() {
        super.init()
    }
    
    func tableViewGloabelTextFieldAndTitleTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelTextFieldAndTitleTableViewCell) {
        cell.cellSetTextFieldCount(number: 11)
        phoneSingle = cell.textFiled.reactive.continuousTextValues.map { (str) -> Bool in
            self.phone = str
            return str.count > 0
        }
        cell.cellSetData(title: titles[indexPath.row], placeholder: placeholders[indexPath.row])
    }
    
    func tableViewGloabelTextFieldButtonTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelTextFieldButtonTableViewCell) {
        codeSingle = cell.textFiled.reactive.continuousTextValues.map { (str) -> Bool in
            self.code = str
            return str.count > 0
        }
        cell.hiddenLineLabel()
        cell.cellSetData(title: titles[indexPath.row], placeholder: placeholders[indexPath.row])
        
        self.codeSingle?.combineLatest(with: self.phoneSingle!).observeValues({ (code,phone) in
            if code && phone {
                self.controller!.navigationItem.rightBarButtonItem?.isEnabled = true
            }else{
                self.controller!.navigationItem.rightBarButtonItem?.isEnabled = false
            }
        })
        
        cell.gloabelTextFieldButtonTableViewCellSendCode = {
            self.sendCodeNetWork(phone: self.phone)
        }
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
    
    func sendCodeNetWork(phone:String){
        let parameters = ["phone":phone]
        BaseNetWorke.getSharedInstance().postUrlWithString(UsersendCodeUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "发送验证码成功", autoHidder: true)
                //                let userInfo = UserInfoModel.yy_model(with: (resultDic.value as! [AnyHashable : Any]))
                
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    
    func bindNetWork(openId:String){
        let parameters = ["phone":self.phone, "code":self.code, "openId":openId]
        BaseNetWorke.getSharedInstance().postUrlWithString(UserLoginBindPhoneUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                let userInfo = UserInfoModel.init(fromDictionary: resultDic.value as! [String : Any])
                CacheManager.getSharedInstance().saveUserInfo(userInfo: userInfo)
                NotificationManager.getSharedInstance().addAlias(alias: userInfo.id.string)
                UserDefaults.init().set(userInfo.token, forKey: CACHEMANAUSERTOKEN)
                let contoller = ResetPasViewController.init()
                contoller.phone = self.phone
                contoller.bindPhone = true
                NavigationPushView(self.controller!, toConroller: contoller)
//                (self.controller as! BindPhoneViewController).navigationController?.popToRootViewController(animated: true)
                //登录成功后读取未读消息数量
                LoadConfigManger.getSharedInstance().loadUnreadUrl()
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
}


extension BindPhoneViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.000001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension BindPhoneViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GloabelTextFieldButtonTableViewCell.description(), for: indexPath)
            self.tableViewGloabelTextFieldButtonTableViewCellSetData(indexPath, cell: cell as! GloabelTextFieldButtonTableViewCell)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: GloabelTextFieldAndTitleTableViewCell.description(), for: indexPath)
        self.tableViewGloabelTextFieldAndTitleTableViewCellSetData(indexPath, cell: cell as! GloabelTextFieldAndTitleTableViewCell)
        return cell
    }
}
