//
//  ChangePasswordViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class ChangePasswordViewModel: BaseViewModel {
    
    let titles = ["原密码","新密码","确认密码"]
    let placeholders = ["请输入旧密码","请输入新密码","请再次输入密码"]
    override init() {
        super.init()
    }
    
    func tableViewGloabelTextFieldTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelTextFieldTableViewCell) {
        cell.textFiled.textType = .password
        cell.cellSetData(title: titles[indexPath.row], placeholder: placeholders[indexPath.row])
    }
    
    func tableViewGloabelConfirmTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelConfirmTableViewCell) {
        cell.anmationButton.addAction({ (button) in
            
        }, for: .touchUpInside)
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
}


extension ChangePasswordViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let gloabelView = TableViewHeaderView.init(frame: CGRect.init(x: 15, y: 0, width: SCREENWIDTH, height: 30), title: "忘记密码", isMush: false)
        return gloabelView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 62
        }
        return 47
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension ChangePasswordViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GloabelConfirmTableViewCell.description(), for: indexPath)
            self.tableViewGloabelConfirmTableViewCellSetData(indexPath, cell: cell as! GloabelConfirmTableViewCell)
            cell.contentView.backgroundColor = .clear
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: GloabelTextFieldTableViewCell.description(), for: indexPath)
        self.tableViewGloabelTextFieldTableViewCellSetData(indexPath, cell: cell as! GloabelTextFieldTableViewCell)
        return cell
    }
}
