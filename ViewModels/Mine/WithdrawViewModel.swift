//
//  WithdrawViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/29.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import ReactiveCocoa
import ReactiveSwift

class WithdrawViewModel: BaseViewModel {

    var accountInfo:AccountInfoModel!
    var bankLiskArray = NSMutableArray.init()
    var bankModel:BankModel!
    var cashMoney:Double = 0.00
    var bindMuchSingle:Signal<Bool, Never>?
    
    var isCheckBool:Bool = false
    
    override init() {
        super.init()
        self.getAccountInfoList()
    }
    
    func tableViewTopUpTableViewCellSetData(_ indexPath:IndexPath, cell:TopUpTableViewCell) {
        if self.accountInfo != nil {
            cell.cellSetsData(model: self.accountInfo)
        }
        
    }
    
    func tableViewWithDrawMuchTableViewCellSetData(_ indexPath:IndexPath, cell:WithDrawMuchTableViewCell) {
        cell.muchTextFiled.reactive.continuousTextValues.observeValues { (str) in
            if str.double() != nil {
                self.cashMoney = str.double()!
            }
        }
        
        bindMuchSingle = cell.muchTextFiled.reactive.continuousTextValues.map({ (str) -> Bool in
            return str.count > 0
        })
        
        cell.withDrawMuchTableViewAllMuchClouse = {
            cell.muchTextFiled.text = (self.accountInfo.recomCoin + self.accountInfo.inviteCoin).string
        }
    }
    
    func tableViewGloabelConfirmTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelConfirmTableViewCell) {
        bindMuchSingle?.observeValues({ (ret) in
            if ret {
                cell.changeEnabel(isEnabled: true)
            }else{
                cell.changeEnabel(isEnabled: false)
            }
        })
        cell.anmationButton.reactive.controlEvents(.touchUpInside).observeValues { (button) in
            self.drawUpNet()
        }
    }
    
    func tableViewWithDrawTypeTableViewCellSetData(_ indexPath:IndexPath, cell:WithDrawTypeTableViewCell) {
        if bankLiskArray.count == 0 {
            cell.cellSetData(model: nil)
        }else{
            if self.bankModel == nil {
                self.bankModel = BankModel.init(fromDictionary: bankLiskArray[0] as! [String : Any])
            }
            cell.cellSetData(model: self.bankModel)
        }
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
    
    func tableViewTopUpWarningTableViewCellSetData(_ indexPath:IndexPath, cell:TopUpWarningTableViewCell) {
        
    }
    
    func tableViewDidSelect( tableView:UITableView,  indexPath:IndexPath){
        if indexPath.section == 1 {
            if self.bankLiskArray.count > 0 {
                let bindWithVC = BindBankListViewController()
                bindWithVC.bankListk = self.bankLiskArray
                bindWithVC.postDetailDataClouse = { dic,type in
                    self.bankModel = BankModel.init(fromDictionary: dic as! [String : Any])
                    self.controller?.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 1)], with: .automatic)
                }
                bindWithVC.bindBankListViewControllerDeleteClouse = { dic in
                    self.bankLiskArray.remove(dic)
                }
                bindWithVC.bindBankListViewControllerAddClouse = { dic in
                    self.bankLiskArray.add(dic)
                }
                NavigationPushView(self.controller!, toConroller: bindWithVC)
            }else{
                let bindWithVC = BindWithdrawViewController()
                bindWithVC.postDetailDataClouse = { dic,type in
                    self.bankLiskArray.add(dic)
                    self.bankModel = BankModel.init(fromDictionary: dic as! [String : Any])
                    self.controller?.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 1)], with: .automatic)
                }
                NavigationPushView(self.controller!, toConroller: bindWithVC)
            }
        }
    }
    
    func getAccount(){
        BaseNetWorke.getSharedInstance().postUrlWithString(AccountfindAccountUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                let model = AccountInfoModel.init(fromDictionary: resultDic.value as! [String : Any])
                self.accountInfo = model
                self.reloadTableViewData()
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func getAccountInfoList(){
        BaseNetWorke.getSharedInstance().postUrlWithString(AccountFindCashAccountUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.bankLiskArray = NSMutableArray.init(array: resultDic.value as! Array)
                self.reloadTableViewData()
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func drawUpNet(){
        let parameters = ["cashMoney":self.cashMoney,"accountId":self.bankModel.id.string] as [String : Any]
        BaseNetWorke.getSharedInstance().postUrlWithString(AccountcashUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.controller?.navigationController?.popViewController()
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
}


extension WithdrawViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    //1
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            //185/375
            return 189
        case 1:
            //79/375
            return 47
        case 2:
            //79/375
            return 127
        case 3:
            return 41
        case 4:
            return 47
        default:
            return 100
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var alpa:CGFloat = 0
        if #available(iOS 11.0, *) {
            alpa = scrollView.contentOffset.y / (SCREENWIDTH * 189 / 375 - 64 - NAV_HEIGHT)
        } else {
            alpa = scrollView.contentOffset.y / (SCREENWIDTH * 189 / 375 - 64)
            // Fallback on earlier versions
        }
        (self.controller as! WithdrawViewController).gloableNavigationBar.changeBackGroundColor(transparency: alpa > 1 ? 1 :alpa)
    }
}

extension WithdrawViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopUpTableViewCell.description(), for: indexPath)
            self.tableViewTopUpTableViewCellSetData(indexPath, cell: cell as! TopUpTableViewCell)
            cell.selectionStyle = .none
            cell.contentView.backgroundColor = App_Theme_F6F6F6_Color
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: WithDrawTypeTableViewCell.description(), for: indexPath)
            self.tableViewWithDrawTypeTableViewCellSetData(indexPath, cell: cell as! WithDrawTypeTableViewCell)
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: WithDrawMuchTableViewCell.description(), for: indexPath)
            self.tableViewWithDrawMuchTableViewCellSetData(indexPath, cell: cell as! WithDrawMuchTableViewCell)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: ConfirmProtocolTableViewCell.description(), for: indexPath)
            self.tableViewConfirmProtocolTableViewCellSetData(indexPath, cell: cell as! ConfirmProtocolTableViewCell)
            cell.selectionStyle = .none
            cell.backgroundColor = App_Theme_F6F6F6_Color
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: GloabelConfirmTableViewCell.description(), for: indexPath)
            self.tableViewGloabelConfirmTableViewCellSetData(indexPath, cell: cell as! GloabelConfirmTableViewCell)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopUpWarningTableViewCell.description(), for: indexPath)
            self.tableViewTopUpWarningTableViewCellSetData(indexPath, cell: cell as! TopUpWarningTableViewCell)
            cell.selectionStyle = .none
            cell.backgroundColor = App_Theme_F6F6F6_Color
            return cell
        }
    }
}

extension WithdrawViewModel : DZNEmptyDataSetDelegate {
    
}

extension WithdrawViewModel : DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributed = "暂时还没有数据哦！"
        let attributedString = NSMutableAttributedString.init(string: attributed)
        attributedString.addAttributes([NSAttributedString.Key.font:App_Theme_PinFan_M_16_Font!,NSAttributedString.Key.foregroundColor:App_Theme_CCCCCC_Color!], range: NSRange.init(location: 0, length: 9))
        
        return attributedString
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "pic_toy")
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -64
    }
}

