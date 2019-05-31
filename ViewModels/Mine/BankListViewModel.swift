//
//  BankListViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class BankListViewModel: BaseViewModel {

    var bankListk:NSMutableArray!
    override init() {
        super.init()
    }
    
    func tableViewBankTableViewCellSetData(_ indexPath:IndexPath, cell:BankTableViewCell) {
        cell.cellSetData(model: BankModel.init(fromDictionary: bankListk![indexPath.row] as! [String : Any]))
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        if self.controller?.postDetailDataClouse != nil {
            self.controller?.postDetailDataClouse(bankListk![indexPath.row] as! NSDictionary,.Hot)
            self.controller?.navigationController?.popViewController()
        }
    }
    
    func deleteAccount(indexPath:IndexPath){
        let parameters = ["id":((self.bankListk[indexPath.row] as! NSDictionary).object(forKey: "id") as! Int).string]
        BaseNetWorke.sharedInstance.postUrlWithString(AccountDeleteAccountUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if (self.controller as! BindBankListViewController).bindBankListViewControllerDeleteClouse != nil {
                    (self.controller as! BindBankListViewController).bindBankListViewControllerDeleteClouse(self.bankListk[indexPath.row] as! NSDictionary)
                }
                self.reloadTableViewData()
            }
        }
        
    }
}


extension BankListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 47
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let rowAction = UITableViewRowAction.init(style: .default, title: "删除") { (action, indexPath) in
            self.deleteAccount(indexPath: indexPath)
        }
        return [rowAction]
    }
}

extension BankListViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankListk.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BankTableViewCell.description(), for: indexPath)
        self.tableViewBankTableViewCellSetData(indexPath, cell: cell as! BankTableViewCell)
        cell.selectionStyle = .none
        return cell
    }
}

extension BankListViewModel : DZNEmptyDataSetDelegate {
    
}

extension BankListViewModel : DZNEmptyDataSetSource {
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
