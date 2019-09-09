//
//  TargerUserViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/15.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit


class TargerUserViewModel: BaseViewModel {
    
    let tarInfoTitle = ["最近@的人","","我的关注"]
    override init() {
        super.init()
    }
    
    func tableViewTagerUserTableViewCellSetData(_ indexPath:IndexPath, cell:TagerUserTableViewCell) {
        
    }
    
    func tableViewTargerUserInfoTableViewCellSetData(_ indexPath:IndexPath, cell:TargerUserInfoTableViewCell) {
        cell.cellSetData(str: tarInfoTitle[indexPath.section])
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        (self.controller as! TargerUserViewController).resultDicNavigationController(["":"","":""])
    }
}


extension TargerUserViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 || section == 2{
            return 2
        }else if section == 1 {
            return 5
        }
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 || indexPath.section == 2 {
            return 30
        }
        return 60
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension TargerUserViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 2{
            return 1
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 || indexPath.section == 2  {
            let cell = tableView.dequeueReusableCell(withIdentifier: TargerUserInfoTableViewCell.description(), for: indexPath)
            self.tableViewTargerUserInfoTableViewCellSetData(indexPath, cell: cell as! TargerUserInfoTableViewCell)
            cell.backgroundColor = App_Theme_FFFFFF_Color
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: TagerUserTableViewCell.description(), for: indexPath)
        self.tableViewTagerUserTableViewCellSetData(indexPath, cell: cell as! TagerUserTableViewCell)
        cell.backgroundColor = App_Theme_FFFFFF_Color
        cell.selectionStyle = .none
        return cell
    }
}

