//
//  MyPostViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/20.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit


class MyPostViewModel: BaseViewModel {
    
    var myPostArray = NSMutableArray.init()
    var page:Int = 0
    override init() {
        super.init()
        self.getMyPostNet()
    }
    
    
    func tableViewCategoryContentTableViewCellSetData(_ indexPath:IndexPath, cell:CategoryContentTableViewCell) {
        if self.myPostArray.count > 0 {
            let model = TipModel.init(fromDictionary: self.myPostArray[indexPath.section] as! [String : Any])
            if model.status == "0" {
                cell.cellSetData(tipmodel: model)
            }else{
                cell.deleteCellData(tipmodel: model)
            }
        }
    }
    
    func tableViewUserInfoTableViewCellSetData(_ indexPath:IndexPath, cell:UserInfoTableViewCell){
        if self.myPostArray.count > 0 {
            cell.cellSetData(model: TipModel.init(fromDictionary: self.myPostArray[indexPath.section] as! [String : Any]))
        }
    }
    
    func tableViewMCommentTableViewCellSetData(_ indexPath:IndexPath, cell:CommentTableViewCell){
        if self.myPostArray.count > 0 {
            cell.cellSetData(model: TipModel.init(fromDictionary: self.myPostArray[indexPath.section] as! [String : Any]))
        }
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        if indexPath.row != 0 {
            let dicData:NSDictionary = TipModel.init(fromDictionary: self.myPostArray[indexPath.section] as! [String : Any]).toDictionary() as NSDictionary
            if dicData.object(forKey: "status") as! String == "0" {
                (self.controller as! MyPostViewController).postDetailDataClouse(NSMutableDictionary.init(dictionary: dicData),.Hot, indexPath)
            }else{
                _ = Tools.shareInstance.showMessage(KWindow, msg: "该文章已经删除", autoHidder: true)
            }
        }
    }
    
    override func tapViewNoneData() {
        self.page = 0
        self.getMyPostNet()
    }
    
    
    func getMyPostNet(){
        page = page + 1
        let parameters = ["page":page.string, "limit":LIMITNUMBER] as [String : Any]
        BaseNetWorke.getSharedInstance().postUrlWithString(TipgetTipListUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if self.page != 1 {
                    self.myPostArray.addObjects(from: NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array) as! [Any])
                }else{
                    self.myPostArray = NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array)
                }
                self.reloadTableViewData()
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }else{
                 self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
}


extension MyPostViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 52
        }else if indexPath.row == 1 {
            return tableView.fd_heightForCell(withIdentifier: CategoryContentTableViewCell.description(), cacheBy: indexPath, configuration: { (cell) in
                self.tableViewCategoryContentTableViewCellSetData(indexPath, cell: cell as! CategoryContentTableViewCell)
            })
            
        }
        return 32
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 52
        }else if indexPath.row == 1{
            return 52
        }
        return 32
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        (self.controller as! MyPostViewController).listViewDidScrollCallback?(scrollView)
    }
}

extension MyPostViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.myPostArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoTableViewCell.description(), for: indexPath)
            self.tableViewUserInfoTableViewCellSetData(indexPath, cell: cell as! UserInfoTableViewCell)
            cell.selectionStyle = .none
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryContentTableViewCell.description(), for: indexPath)
            self.tableViewCategoryContentTableViewCellSetData(indexPath, cell: cell as! CategoryContentTableViewCell)
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.description(), for: indexPath)
        self.tableViewMCommentTableViewCellSetData(indexPath, cell: cell as! CommentTableViewCell)
        cell.selectionStyle = .none
        return cell
    }
}


