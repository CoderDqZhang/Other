//
//  WithdrawViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/29.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class WithdrawViewModel: BaseViewModel {

    var accountInfo:AccountInfoModel!
    
    override init() {
        super.init()
    }
    
    func tableViewTopUpTableViewCellSetData(_ indexPath:IndexPath, cell:TopUpTableViewCell) {
        cell.cellSetData(model: self.accountInfo)
    }
    
    func tableViewTopUpToolsTableViewCellSetData(_ indexPath:IndexPath, cell:TopUpToolsTableViewCell) {
        
    }
    
    func tableViewTopUpConfirmTableViewCellSetData(_ indexPath:IndexPath, cell:TopUpConfirmTableViewCell) {
        
    }
    
    func tableViewTopUpWarningTableViewCellSetData(_ indexPath:IndexPath, cell:TopUpWarningTableViewCell) {
        
    }
    
    func tableViewDidSelect( tableView:UITableView,  indexPath:IndexPath){
        
    }
    
    func getAccount(){
        BaseNetWorke.sharedInstance.postUrlWithString(AccountfindAccountUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                let model = AccountInfoModel.init(fromDictionary: resultDic.value as! [String : Any])
                self.accountInfo = model
                self.reloadTableViewData()
            }
        }
    }
    
    func getAccountInfoNet(userId:String){
        BaseNetWorke.sharedInstance.postUrlWithString(AccountfindAccountUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.accountInfo = AccountInfoModel.init(fromDictionary: resultDic.value as! [String : Any])
                self.reloadTableViewData()
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
            return AnimationTouchViewHeight * 2 + AnimationTouchViewMarginItemY + 60
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

extension WithdrawViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
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

