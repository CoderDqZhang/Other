//
//  RealNameViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class RealNameViewModel: BaseViewModel {

    let titles = ["姓名","身份证"]
    let placeholders = ["请输入你的真实姓名","请填写正确的身份证号码"]
    var username:String = ""
    var idnumber:String = ""
    var userNameSingle:Signal<Bool, Never>?
    var idNumberSingle:Signal<Bool, Never>?
    override init() {
        super.init()
    }
    
    func tableViewGloabelTextFieldAndTitleTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelTextFieldAndTitleTableViewCell) {
        cell.textFiled.keyboardType = .default
        if indexPath.row == 0 {
            userNameSingle = cell.textFiled.reactive.continuousTextValues.map { (str) -> Bool in
                self.username = str
                return str.count > 0
            }
        }else{
            idNumberSingle = cell.textFiled.reactive.continuousTextValues.map { (str) -> Bool in
                self.idnumber = str
                return str.count > 0
            }
        }
        cell.cellSetData(title: titles[indexPath.row], placeholder: placeholders[indexPath.row])
    }
    
    func tableViewGloabelConfirmTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelConfirmTableViewCell) {
        cell.anmationButton.setTitle("提交", for: .normal)
        userNameSingle?.combineLatest(with: idNumberSingle!).observeValues({ (username, idnumber) in
            if username && idnumber {
                cell.changeEnabel(isEnabled: true)
            }else{
                cell.changeEnabel(isEnabled: false)
            }
        })
        cell.anmationButton.addAction({ (button) in
            self.realNameNet()
        }, for: .touchUpInside)
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
    
    func realNameNet(){
        let parameters = ["username":self.username,"idNumber":self.idnumber]
        BaseNetWorke.sharedInstance.postUrlWithString(PersonnameAuthUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "提交成功，等待审核", autoHidder: true)
                self.controller?.navigationController?.popViewController()
            }
        }
    }
}


extension RealNameViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
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

extension RealNameViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ?  2 : 1
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

