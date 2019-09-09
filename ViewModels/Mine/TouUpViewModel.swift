//
//  TouUpViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/27.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

import ReactiveCocoa

class TouUpViewModel: BaseViewModel {

    var accountInfo:AccountInfoModel!
    var coinsModel = NSMutableArray.init()
    
    override init() {
        super.init()
        self.getCoinsInfoNet()
    }
    
    func tableViewTopUpTableViewCellSetData(_ indexPath:IndexPath, cell:TopUpTableViewCell) {
        cell.cellSetData(model: self.accountInfo)
        cell.topUpTableViewCellClouse = {
            NavigationPushView(self.controller!, toConroller: WithdrawViewController())
        }
    }
    
    func tableViewTopUpToolsTableViewCellSetData(_ indexPath:IndexPath, cell:TopUpToolsTableViewCell) {
        if self.coinsModel.count > 0 {
            cell.cellSetData(array: self.coinsModel)
            cell.topUpToolsTableViewCellClouse = { dic in
                let model = CoinsModel.init(fromDictionary: dic as! [String : Any])
                InPurchaseManager.getSharedInstance().gotoApplePay(productID: model.value)
                print(dic)
                InPurchaseManager.getSharedInstance().inPurchaseManagerCheckClouse = { dic in
                    self.checkPaySuccess(model: model, code:dic.object(forKey: "receipt") as! String)
                }
            }
        }
    }
    
    func tableViewTopUpConfirmTableViewCellSetData(_ indexPath:IndexPath, cell:TopUpConfirmTableViewCell) {
    
    }
    
    func tableViewTopUpWarningTableViewCellSetData(_ indexPath:IndexPath, cell:TopUpWarningTableViewCell) {
    
    }
    
    func tableViewDidSelect( tableView:UITableView,  indexPath:IndexPath){
        if indexPath.section == 0 {
            NavigationPushView(self.controller!, toConroller: WithdrawViewController())
        }
    }
    
    override func tapViewNoneData() {
        self.getAccount()
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
    
    func getAccountInfoNet(userId:String){
        BaseNetWorke.getSharedInstance().postUrlWithString(AccountfindAccountUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.accountInfo = AccountInfoModel.init(fromDictionary: resultDic.value as! [String : Any])
                self.reloadTableViewData()
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func getCoinsInfoNet(){
        BaseNetWorke.getSharedInstance().getUrlWithString(CommentgetRechargeUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.coinsModel = NSMutableArray.init(array: resultDic.value as! Array)
                self.reloadTableViewData()
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func checkPaySuccess(model:CoinsModel,code:String){
        let parameters = ["receipt":code,"type":"3"]
        BaseNetWorke.getSharedInstance().postUrlWithString(PayUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.accountInfo.chargeCoin = self.accountInfo.chargeCoin + model.text.double()!
                self.reloadTableViewData()
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
}


extension TouUpViewModel: UITableViewDelegate {
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
            return AnimationTouchViewHeight * 2 + AnimationTouchViewMarginItemY + 160
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
        (self.controller as! TopUpViewController).gloableNavigationBar.changeBackGroundColor(transparency: alpa > 1 ? 1 :alpa)
    }
}

extension TouUpViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
            let cell = tableView.dequeueReusableCell(withIdentifier: TopUpToolsTableViewCell.description(), for: indexPath)
            self.tableViewTopUpToolsTableViewCellSetData(indexPath, cell: cell as! TopUpToolsTableViewCell)
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopUpWarningTableViewCell.description(), for: indexPath)
            self.tableViewTopUpWarningTableViewCellSetData(indexPath, cell: cell as! TopUpWarningTableViewCell)
            cell.selectionStyle = .none
            return cell
        }
    }
}


