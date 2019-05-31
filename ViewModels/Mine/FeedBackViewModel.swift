//
//  FeedBackViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class FeedBackViewModel: BaseViewModel {
    
    let placeholders = "请输入反馈内容"
    var content:String = ""
    var isEnabel:Bool = false
    override init() {
        super.init()
    }
    
    func tableViewGloabelConfirmTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelConfirmTableViewCell) {
        cell.changeEnabel(isEnabled: self.isEnabel)
        cell.anmationButton.addAction({ (button) in
            self.feedBackNet(content: self.content)
        }, for: .touchUpInside)
    }
    
    func tableViewGloabelTextViewTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelTextViewTableViewCell) {
        cell.gloabelTextViewTableViewCellClouse = { (text, isEnabel) in
            self.content = text
            if self.isEnabel != isEnabel {
                self.isEnabel = isEnabel
                (self.controller as! FeedBackViewController).tableView.reloadRows(at: [IndexPath.init(row: 0, section: 1)], with: .automatic)
            }
        }
        cell.cellSetData(placeholder: placeholders)
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
    
    func feedBackNet(content:String){
        let parameters = ["content":content]
        BaseNetWorke.sharedInstance.postUrlWithString(UserFeedBackinsertFeedbackUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "反馈成功", autoHidder: true)
                self.controller!.navigationController?.popViewController()
            }
        }
    }
}


extension FeedBackViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 12
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 227
        }
        return 47
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension FeedBackViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GloabelTextViewTableViewCell.description(), for: indexPath)
            self.tableViewGloabelTextViewTableViewCellSetData(indexPath, cell: cell as! GloabelTextViewTableViewCell)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: GloabelConfirmTableViewCell.description(), for: indexPath)
        self.tableViewGloabelConfirmTableViewCellSetData(indexPath, cell: cell as! GloabelConfirmTableViewCell)
        cell.contentView.backgroundColor = .clear
        return cell
    }
}
