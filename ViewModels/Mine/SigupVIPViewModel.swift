//
//  SigupVIPViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class SigupVIPViewModel: BaseViewModel {

    let titles = ["姓名","身份证"]
    let placeholders = ["请输入你的真实姓名","请填写正确的身份证号码"]
    var fontImage:UIImage?
    var backImage:UIImage?
    var takeHandImage:UIImage?
    var userNameSingle:Signal<Bool, Never>?
    var cartNumberSingle:Signal<Bool, Never>?
    var isCheckBool:Bool = false
    
    override init() {
        super.init()
    }
    
    func tableViewConfirmProtocolTableViewCellSetData(_ indexPath:IndexPath, cell:ConfirmProtocolTableViewCell) {
        cell.checkBox.addAction({ (button) in
            if button?.tag == 100 {
                self.isCheckBool = true
                cell.checkBox.tag = 101
                cell.checkBox.setBackgroundImage(UIImage.init(named: "check_select"), for: .normal)
            }else{
                self.isCheckBool = false
                cell.checkBox.tag = 100
                cell.checkBox.setBackgroundImage(UIImage.init(named: "check_normal"), for: .normal)
            }
        }, for: UIControl.Event.touchUpInside)
    }
    
    func tableViewTakeVCartTableViewCellSetData(_ indexPath:IndexPath, cell:TakeVCartTableViewCell) {
        cell.cellSetData(fontImage: takeHandImage)
        cell.takeCartButton.reactive.controlEvents(.touchUpInside).observe { (button) in
            (self.controller as! SingUpVIPViewController).uploadIDCart(.hand)
        }
    }
    
    func tableViewUploadCartTableViewCellSetData(_ indexPath:IndexPath, cell:UploadCartTableViewCell) {
        cell.cellSetData(fontImage: fontImage, backImage: backImage)
        cell.uploadCartTableViewCellClouse = { type in
            (self.controller as! SingUpVIPViewController).uploadIDCart(type)
        }
    }
    
    func tableViewGloabelTextFieldTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelTextFieldTableViewCell) {
        cell.textFiled.keyboardType = .default
        if indexPath.row == 3 {
            cell.hiddenLineLabel()
        }
        if indexPath.row == 2 {
            userNameSingle = cell.textFiled.reactive.continuousTextValues.map { (str) -> Bool in
                return str.count > 0
            }
        }else{
            cartNumberSingle = cell.textFiled.reactive.continuousTextValues.map { (str) -> Bool in
                return str.count > 0
            }
        }
        
        cell.cellSetData(title: titles[indexPath.row - 2], placeholder: placeholders[indexPath.row - 2])
    }
    
    func tableViewGloabelConfirmTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelConfirmTableViewCell) {
        userNameSingle?.combineLatest(with: cartNumberSingle!).observeValues({ (username,cart) in
            if username && cart && self.fontImage != nil && self.backImage != nil && self.takeHandImage != nil && self.isCheckBool {
                cell.changeEnabel(isEnabled: true)
            }else{
                cell.changeEnabel(isEnabled: false)
            }
        })
        cell.anmationButton.setTitle("提交", for: .normal)
        cell.anmationButton.addAction({ (button) in
            
        }, for: .touchUpInside)
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
}


extension SigupVIPViewModel: UITableViewDelegate {
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
        if section == 0 {
            return 40
        }
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 157
            }else if indexPath.row == 1{
                return 157
            }
            return 62
        }
        return 47
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension SigupVIPViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ?  4 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 2 || indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: GloabelTextFieldTableViewCell.description(), for: indexPath)
                self.tableViewGloabelTextFieldTableViewCellSetData(indexPath, cell: cell as! GloabelTextFieldTableViewCell)
                return cell
            }else if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: UploadCartTableViewCell.description(), for: indexPath)
                self.tableViewUploadCartTableViewCellSetData(indexPath, cell: cell as! UploadCartTableViewCell)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: TakeVCartTableViewCell.description(), for: indexPath)
                self.tableViewTakeVCartTableViewCellSetData(indexPath, cell: cell as! TakeVCartTableViewCell)
                return cell
            }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ConfirmProtocolTableViewCell.description(), for: indexPath)
            self.tableViewConfirmProtocolTableViewCellSetData(indexPath, cell: cell as! ConfirmProtocolTableViewCell)
            cell.contentView.backgroundColor = .clear
            cell.backgroundColor = .clear
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: GloabelConfirmTableViewCell.description(), for: indexPath)
            self.tableViewGloabelConfirmTableViewCellSetData(indexPath, cell: cell as! GloabelConfirmTableViewCell)
            cell.contentView.backgroundColor = .clear
            cell.backgroundColor = .clear
            return cell
        }
    }
}
