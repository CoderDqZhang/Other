//
//  ChangePasswordViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class ChangePasswordViewModel: BaseViewModel {
    
    let titles = ["原密码","新密码","确认密码"]
    let placeholders = ["请输入旧密码","请输入新密码","请再次输入密码"]
    var oldPasSingle:Signal<Bool, Never>?
    var newPasSingle:Signal<Bool, Never>?
    var confirmPasSingle:Signal<Bool, Never>?
    var oldPassword:String = ""
    var newPassword:String = ""
    var confirmPassword:String = ""
    override init() {
        super.init()
    }
    
    func tableViewGloabelTextFieldAndTitleTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelTextFieldAndTitleTableViewCell) {
        cell.textFiled.textType = .password
        if indexPath.row == 0 {
            oldPasSingle = cell.textFiled.reactive.continuousTextValues.map { (str) -> Bool in
                self.oldPassword = str
                return str.count > 0
            }
        }else if indexPath.row == 1 {
            newPasSingle = cell.textFiled.reactive.continuousTextValues.map { (text) -> Bool in
                self.newPassword = text
                return text.count > 0
            }
        }else if indexPath.row == 2 {
            confirmPasSingle = cell.textFiled.reactive.continuousTextValues.map { (text) -> Bool in
                self.confirmPassword = text
                return text.count > 0
            }
        }
        cell.cellSetData(title: titles[indexPath.row], placeholder: placeholders[indexPath.row])
    }
    
    func tableViewGloabelConfirmTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelConfirmTableViewCell) {
        let ret =  oldPasSingle?.combineLatest(with: newPasSingle!).map({ (old,new) -> Bool in
            return old && new
        })
        
        ret?.combineLatest(with: confirmPasSingle!).observeValues({ (old,new) in
            if old && new {
                cell.changeEnabel(isEnabled: true)
            }else{
                cell.changeEnabel(isEnabled: false)
            }
        })
        
        cell.anmationButton.addAction({ (button) in
            if self.confirmPassword != self.newPassword {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "两次密码不一致", autoHidder: true)
                return
            }
            self.changePasswordNet(oldPas: AddAESKeyPassword(str: self.oldPassword), newPas: AddAESKeyPassword(str: self.newPassword))
        }, for: .touchUpInside)
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
    
    func changePasswordNet(oldPas:String,newPas:String){
        let parameters = ["oldPassword":oldPas,"password":newPas]
        BaseNetWorke.getSharedInstance().postUrlWithString(SurePasswordUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "修改成功", autoHidder: true)
                self.controller!.navigationController?.popViewController()
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
}


extension ChangePasswordViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let gloabelView = TableViewHeaderView.init(frame: CGRect.init(x: 15, y: 0, width: SCREENWIDTH, height: 30), title: "忘记密码", isMush: false)
            return gloabelView
        }
        return nil
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 62
        }
        return 47
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension ChangePasswordViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ?  3 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GloabelConfirmTableViewCell.description(), for: indexPath)
            self.tableViewGloabelConfirmTableViewCellSetData(indexPath, cell: cell as! GloabelConfirmTableViewCell)
            cell.contentView.backgroundColor = .clear
            cell.backgroundColor = .clear
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: GloabelTextFieldAndTitleTableViewCell.description(), for: indexPath)
        self.tableViewGloabelTextFieldAndTitleTableViewCellSetData(indexPath, cell: cell as! GloabelTextFieldAndTitleTableViewCell)
        return cell
    }
}
