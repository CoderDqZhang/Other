//
//  BankListViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit


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
            self.controller?.postDetailDataClouse(NSMutableDictionary.init(dictionary: bankListk![indexPath.row] as! NSDictionary) ,.Hot, indexPath)
            self.controller?.navigationController?.popViewController()
        }
    }
    
    func deleteAccount(indexPath:IndexPath){
        let parameters = ["cashAccountId":((self.bankListk[indexPath.row] as! NSDictionary).object(forKey: "id") as! Int).string]
        BaseNetWorke.getSharedInstance().postUrlWithString(AccountDeleteAccountUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if (self.controller as! BindBankListViewController).bindBankListViewControllerDeleteClouse != nil {
                    (self.controller as! BindBankListViewController).bindBankListViewControllerDeleteClouse(self.bankListk[indexPath.row] as! NSDictionary)
                }
                self.reloadTableViewData()
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
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

