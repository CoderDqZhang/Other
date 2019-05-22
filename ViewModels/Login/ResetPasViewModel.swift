//
//  ResetPasViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class ResetPasViewModel: BaseViewModel {
    
    let titles = ["手机号","验证码"]
    let placeholders = ["请输入手机号码","请输入验证码"]
    var passwordSingle:Signal<Bool, Never>?
    var confirmPasSingle:Signal<Bool, Never>?
    var newPas:String!
    var confirmPas:String!
    
    override init() {
        super.init()
    }
    
    func tableViewGloabelTextFieldTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelTextFieldTableViewCell) {
        if indexPath.row == 0 {
            passwordSingle = cell.textFiled.reactive.continuousTextValues.map { (str) -> Bool in
                self.newPas = str
                return str.count > 0
            }
        }else{
            confirmPasSingle = cell.textFiled.reactive.continuousTextValues.map { (str) -> Bool in
                self.confirmPas = str
                return str.count > 0
            }
        }
        self.passwordSingle?.combineLatest(with: self.confirmPasSingle!).observeValues({ (code,phone) in
            if code && phone {
                self.controller!.navigationItem.rightBarButtonItem?.isEnabled = true
            }else{
                self.controller!.navigationItem.rightBarButtonItem?.isEnabled = false
            }
        })
        cell.cellSetData(title: titles[indexPath.row], placeholder: placeholders[indexPath.row])
    }
    
    func setNewPassword(){
        if self.newPas != self.confirmPas {
            _ = Tools.shareInstance.showMessage(KWindow, msg: "两次密码不一致", autoHidder: true)
            return
        }
        self.controller?.navigationController?.popToRootViewController(animated: true)
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
}


extension ResetPasViewModel: UITableViewDelegate {
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

extension ResetPasViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GloabelTextFieldTableViewCell.description(), for: indexPath)
        self.tableViewGloabelTextFieldTableViewCellSetData(indexPath, cell: cell as! GloabelTextFieldTableViewCell)
        return cell
    }
}
