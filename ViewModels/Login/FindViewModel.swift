//
//  FindViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class FindViewModel: BaseViewModel {
    
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
        cell.textFiled.keyboardType = .namePhonePad
        cell.cellSetTextFieldCount(number: 11)
        phoneSingle = cell.textFiled.reactive.continuousTextValues.map { (str) -> Bool in
            self.phone = str
            return str.count > 0
        }
        cell.cellSetData(title: titles[indexPath.row], placeholder: placeholders[indexPath.row])
    }
    
    func tableViewGloabelTextFieldButtonTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelTextFieldButtonTableViewCell) {
        cell.textFiled.keyboardType = .numberPad
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
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
    
    
    func forgetNetWork(){
        let parameters = ["phone":self.phone, "code":self.code]
        BaseNetWorke.getSharedInstance().postUrlWithString(UserforgetPasswordUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                let resetPasVC = ResetPasViewController()
                resetPasVC.phone = self.phone
                NavigationPushView(self.controller!, toConroller: resetPasVC)

            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
}


extension FindViewModel: UITableViewDelegate {
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

extension FindViewModel: UITableViewDataSource {
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
