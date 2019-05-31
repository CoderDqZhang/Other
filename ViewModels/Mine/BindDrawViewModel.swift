//
//  BindDrawViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/30.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class BindModel: NSObject {
    var bankNo:String!
    var type:String!
    var bankName:String!
    var bankUserName:String!
    var code:String!
    
    override init() {
        super.init()
        self.bankNo = ""
        self.type = "0"
        self.bankName = ""
        self.code = ""
    }
    
}

class BindDrawViewModel: BaseViewModel {

    let titles = [["姓名","手机号","验证码"],["","收款卡号","收款银行"]]
    let placeholderStrs = [["请输入姓名","请输入手机号","请输入验证码"],["","请输入银行卡号","输入账户自动选择"]]
    var desc:[[String]]!
    var type:AccountTypeTableViewCellType = .bank
    
    var bindModel = BindModel.init()
    var userInfo = CacheManager.getSharedInstance().getUserInfo()!
    
    var bankNameProperty = MutableProperty<Bool>(false)
    let racValue = MutableProperty<Int>(1)

    var bindCodeSingle:Signal<Bool, Never>?
    var bindBankSingle:Signal<Bool, Never>?
    var bindBankNameSingle:Signal<Bool, Never>?
    
    override init() {
        super.init()
    }
    
    func tableViewAccountTypeTableViewCellSetData(_ indexPath:IndexPath, cell:AccountTypeTableViewCell) {
        cell.accountTypeTableViewCellClouse = { type in
            self.type = type
            self.bindModel.type = type.rawValue.string
            self.controller?.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 1)], with: .automatic)
            self.controller?.tableView.reloadRows(at: [IndexPath.init(row: 2, section: 1)], with: .automatic)
            self.controller?.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 2)], with: .automatic)
        }
    }
    
    func tableViewAliPayGloabelTextFieldAndTitleTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelTextFieldAndTitleTableViewCell) {
        if indexPath.row == 1 {
            cell.textFiled.isEnabled = true
            cell.cellSetData(title: "支付宝账户", placeholder: "请输入账户")
            bindBankSingle = cell.textFiled.reactive.continuousTextValues.map({ (str) -> Bool in
                self.bindModel.bankNo = str
                return str.count > 0
            })
            
        }else{
            cell.textFiled.isEnabled = true
            cell.cellSetData(title: "姓名", placeholder: "请输入姓名")
            bindBankNameSingle = cell.textFiled.reactive.continuousTextValues.map({ (str) -> Bool in
                self.bindModel.bankUserName = str
                return str.count > 0
            })
        }
    }
    
    func tableViewGloabelConfirmTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelConfirmTableViewCell) {
        cell.cellSetData(title: "确认绑定")
        cell.anmationButton.reactive.controlEvents(.touchUpInside).observeValues { (button) in
            self.bindBank()
        }
        if self.type == .aliPay {
            let comConfirm = bindBankNameSingle?.combineLatest(with: bindBankSingle!).map({ (bank,bankName) -> Bool in
                return bank && bankName
            })
            
            comConfirm?.combineLatest(with: bindCodeSingle!).observeValues({ (ret,ret1) in
                if ret && ret1 {
                    cell.changeEnabel(isEnabled: true)
                }else{
                    cell.changeEnabel(isEnabled: false)
                }
            })
        }else{
            
            bankNameProperty.signal.combineLatest(with: bindCodeSingle!).map { (ret,ret1) -> Bool in
                return ret1 && ret
                }.combineLatest(with: bindBankSingle!).observeValues { (ret,ret1) in
                    if ret && ret1 {
                        cell.changeEnabel(isEnabled: true)
                    }else{
                        cell.changeEnabel(isEnabled: false)
                    }
            }
        }
    }
    
    func tableViewGloabelTextFieldButtonTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelTextFieldButtonTableViewCell) {
        cell.cellSetData(title: "验证码", placeholder: "验证码")
        bindCodeSingle = cell.textFiled.reactive.continuousTextValues.map({ (str) -> Bool in
            self.bindModel.code = str
            return str.count > 0
        })
    }
    
    func tableViewGloabelTextFieldAndTitleTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelTextFieldAndTitleTableViewCell) {
        cell.cellSetData(title: titles[indexPath.section][indexPath.row], placeholder: placeholderStrs[indexPath.section][indexPath.row])
        if indexPath.section == 1 {
            if indexPath.row == 1 {
                bindBankSingle = cell.textFiled.reactive.continuousTextValues.map({ (str) -> Bool in
                    self.bindModel.bankNo = str
                    if str.count == 19 {
                        self.getBankNameNet()
                    }else{
                        self.bindModel.bankName = ""
                        self.bankNameProperty.value = false
                        self.controller?.tableView.reloadRows(at: [IndexPath.init(row: 2, section: 1)], with: .automatic)
                    }
                    return str.count > 0
                })
            }else{
                cell.textFiled.isEnabled = false
                cell.textFiled.text = self.bindModel.bankName
                bindBankNameSingle = cell.textFiled.reactive.continuousTextValues.map({ (str) -> Bool in
                    return str.count > 0
                })
            }
        }else{
            if indexPath.row == 0 {
                cell.textFiled.text = userInfo.username
                cell.textFiled.isEnabled = false
            }else{
                cell.textFiled.text = userInfo.phone
                cell.textFiled.isEnabled = false
            }
        }
        
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
    
    func getBankNameNet(){
        let url = getAliPayBankNameUrl(banNo: self.bindModel.bankNo)
        BaseNetWorke.sharedInstance.aliPayBankName(url: url, success: { (resultDic) in
            if ReadFileDataManager.getSharedInstance().getBankNameDic() != nil {
                let bankCode = (resultDic as! NSDictionary).object(forKey: "bank")
                if bankCode != nil {
                    self.bindModel.bankName = (ReadFileDataManager.getSharedInstance().getBankNameDic()?.object(forKey: bankCode!)) as? String
                    self.bankNameProperty.value = true
                    self.controller?.tableView.reloadRows(at: [IndexPath.init(row: 2, section: 1)], with: .automatic)
                }else{
                    _ = Tools.shareInstance.showMessage(KWindow, msg: "请检查账户", autoHidder: true)
                }
                
            }
        }) { (dic) in
            
        }
    }
    
    func phoneCodeNetWork(){
        BaseNetWorke.sharedInstance.postUrlWithString(UsersendCodeUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "发送验证码成功", autoHidder: true)
            }
        }
    }
    
    func bindBank(){
        let parameters = ["bankName":self.type == .bank ? self.bindModel.bankName! : self.bindModel.bankUserName!, "type":self.bindModel.type!, "code":self.bindModel.code!,"bankNo":self.bindModel.bankNo!] as [String : Any]
        BaseNetWorke.sharedInstance.postUrlWithString(AccountbindAccountUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "绑定成功", autoHidder: true)
                if self.controller?.postDetailDataClouse != nil {
                    let model = BankModel.init(fromDictionary: resultDic.value as! [String : Any])
                    self.controller?.postDetailDataClouse(model.toDictionary() as NSDictionary, .Hot)
                }
                self.controller?.navigationController?.popViewController()
            }
        }
    }
}


extension BindDrawViewModel: UITableViewDelegate {
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
        if indexPath.section == 2 {
            return 47
        }
        return 62
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension BindDrawViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 3
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: GloabelTextFieldButtonTableViewCell.description(), for: indexPath)
                self.tableViewGloabelTextFieldButtonTableViewCellSetData(indexPath, cell: cell as! GloabelTextFieldButtonTableViewCell)
                
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: GloabelTextFieldAndTitleTableViewCell.description(), for: indexPath)
            self.tableViewGloabelTextFieldAndTitleTableViewCellSetData(indexPath, cell: cell as! GloabelTextFieldAndTitleTableViewCell)
            
            return cell
        case 1:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: AccountTypeTableViewCell.description(), for: indexPath)
                self.tableViewAccountTypeTableViewCellSetData(indexPath, cell: cell as! AccountTypeTableViewCell)
                return cell
                
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: GloabelTextFieldAndTitleTableViewCell.description(), for: indexPath)
            if self.type == .bank {
                self.tableViewGloabelTextFieldAndTitleTableViewCellSetData(indexPath, cell: cell as! GloabelTextFieldAndTitleTableViewCell)
            }else{
                 self.tableViewAliPayGloabelTextFieldAndTitleTableViewCellSetData(indexPath, cell: cell as! GloabelTextFieldAndTitleTableViewCell)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: GloabelConfirmTableViewCell.description(), for: indexPath)
            self.tableViewGloabelConfirmTableViewCellSetData(indexPath, cell: cell as! GloabelConfirmTableViewCell)
            return cell
        }
        
    }
}
