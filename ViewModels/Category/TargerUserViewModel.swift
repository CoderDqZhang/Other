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
    var tagerArray = NSMutableArray.init()
    var normalTarget = CacheManager.getSharedInstance().getTargetModels() ?? NSMutableArray.init()
    override init() {
        super.init()
        self.getCategoryNet()
    }
    
    func tableViewTagerUserTableViewCellSetData(_ indexPath:IndexPath, cell:TagerUserTableViewCell) {
        if normalTarget.count > 0 {
            if indexPath.section == 1{
                cell.cellSetFansData(model: FansFlowwerModel.init(fromDictionary: self.normalTarget[indexPath.row] as! [String : Any]))
            }else if indexPath.section == 3 {
                cell.cellSetFansData(model: FansFlowwerModel.init(fromDictionary: self.tagerArray[indexPath.row] as! [String : Any]))
            }
        }else{
            cell.cellSetFansData(model: FansFlowwerModel.init(fromDictionary: self.tagerArray[indexPath.row] as! [String : Any]))
        }
    }
    
    func tableViewTargerUserInfoTableViewCellSetData(_ indexPath:IndexPath, cell:TargerUserInfoTableViewCell) {
        cell.cellSetData(str: tarInfoTitle[indexPath.section])
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        if indexPath.section == 1 {
            (self.controller as! TargerUserViewController).resultDicNavigationController(self.normalTarget[indexPath.row] as! NSDictionary)
        }else{
            (self.controller as! TargerUserViewController).resultDicNavigationController(self.tagerArray[indexPath.row] as! NSDictionary)
        }
    }
    
    func getCategoryNet(){
        var parameters:[String : Any]?
        parameters = ["page":1, "limit":LIMITNUMBER] as [String : Any]
        BaseNetWorke.getSharedInstance().postUrlWithString(PersonmyfollowUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.tagerArray = NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array)
                self.reloadTableViewData()
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
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
        if normalTarget.count > 0 {
            if indexPath.section == 0 || indexPath.section == 2 {
                return 30
            }
            return 60
        }else{
            return 60
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension TargerUserViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if normalTarget.count > 0 {
            return 4
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if normalTarget.count > 0 {
            if section == 0 || section == 2{
                return 1
            }else if section == 1 {
                return self.normalTarget.count
            }
            return self.tagerArray.count
        }else{
            return self.tagerArray.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if normalTarget.count > 0 {
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
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: TagerUserTableViewCell.description(), for: indexPath)
            self.tableViewTagerUserTableViewCellSetData(indexPath, cell: cell as! TagerUserTableViewCell)
            cell.backgroundColor = App_Theme_FFFFFF_Color
            cell.selectionStyle = .none
            return cell
        }
    }
}

