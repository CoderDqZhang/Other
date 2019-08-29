//
//  NewsViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit


class NewsViewModel: BaseViewModel {

    var categoryArray = NSMutableArray.init()
    var tipListArray = NSMutableArray.init()
    
    var page:Int! = 0
    
    override init() {
        super.init()
        self.getCategoryNet()
        self.getTribeListNet()
    }
    
    func tableViewHotDetailTableViewCellSetData(_ indexPath:IndexPath, cell:HotDetailTableViewCell) {
        cell.cellSetData(detail: "热门讨论", number: "")
    }
    
    func tableViewCategoryTableViewCellSetData(_ indexPath:IndexPath, cell:CategoryTableViewCell) {
        if self.categoryArray.count > 0 {
            cell.cellSetData(models: self.categoryArray)
        }
        cell.categoryTableViewCellClouseClick = { category in
            let dic:NSDictionary = category.toDictionary() as NSDictionary
            let categoryVC = CategoryDetailViewController.init()
            categoryVC.categoryData = dic
            categoryVC.categoryType = .BasketBall
            NavigationPushView(self.controller!, toConroller: categoryVC)
        }
    }
    
    func tableViewCategoryContentTableViewCellSetData(_ indexPath:IndexPath, cell:CategoryContentTableViewCell) {
        if self.tipListArray.count > 0 {
            cell.cellSetData(tipmodel: TipModel.init(fromDictionary: self.tipListArray[indexPath.section - 2] as! [String : Any]))
        }
    }
    
    func tableViewUserInfoTableViewCellSetData(_ indexPath:IndexPath, cell:UserInfoTableViewCell){
         if self.tipListArray.count > 0  {
            cell.cellSetData(model: TipModel.init(fromDictionary: self.tipListArray[indexPath.section - 2] as! [String : Any]))
        }
    }
    
    override func tapViewNoneData() {
        self.page = 0
        self.getCategoryNet()
        self.getTribeListNet()
    }
    
    func tableViewMCommentTableViewCellSetData(_ indexPath:IndexPath, cell:CommentTableViewCell){
        if self.tipListArray.count > 0 {
            cell.cellSetData(model: TipModel.init(fromDictionary: self.tipListArray[indexPath.section - 2] as! [String : Any]))
        }
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        if indexPath.section != 0 && indexPath.section != 1 {
            let dicData:NSDictionary = TipModel.init(fromDictionary: self.tipListArray[indexPath.section - 2] as! [String : Any]).toDictionary() as NSDictionary
            let postDetail = PostDetailViewController()
            postDetail.changeAllCommentAndLikeNumberClouse = { type, status in
                let muDic = NSMutableDictionary.init(dictionary: dicData)
                if type == .comment {
                    if status == .add {
                        muDic.setValue(dicData["commentTotal"] as! Int + 1, forKey: "commentTotal")
                    }else{
                        muDic.setValue(dicData["commentTotal"] as! Int - 1, forKey: "commentTotal")
                    }
                }else{
                    if status == .add {
                        muDic.setValue(dicData["favor"] as! Int + 1, forKey: "favor")
                    }else{
                        muDic.setValue(dicData["favor"] as! Int - 1, forKey: "favor")
                    }
                }
                self.tipListArray.replaceObject(at: indexPath.section - 2, with: muDic)
                self.reloadTableViewData()
            }
            
            postDetail.deleteArticleClouse = {
                self.tipListArray.removeObject(at: indexPath.section - 2)
                self.reloadTableViewData()
            }
            
            postDetail.postData = dicData
            postDetail.postType = .Hot
            NavigationPushView(self.controller!, toConroller: postDetail)
        }
    }
    
    func getCategoryNet(){
        BaseNetWorke.getSharedInstance().postUrlWithString(TribetribeListUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.categoryArray = NSMutableArray.init(array: resultDic.value as! Array)
                self.reloadTableViewData()
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func getTribeListNet(){
        page = page + 1
        let parameters = ["page":page.string, "limit":LIMITNUMBER, "tribeId":"0", "isCollect":"0"] as [String : Any]
        BaseNetWorke.getSharedInstance().postUrlWithString(TipgetTipListUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if self.page != 1 {
                    self.tipListArray.addObjects(from: NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array) as! [Any])
                }else{
                    self.tipListArray = NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array)
                }
                self.reloadTableViewData()
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
}


extension NewsViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 1
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return CategoryViewHeight + 25
        case 1:
            return 32
        default:
            if indexPath.row == 0 {
                return 52
            }else if indexPath.row == 1 {
                return tableView.fd_heightForCell(withIdentifier: CategoryContentTableViewCell.description(), cacheByKey: (self.tipListArray[indexPath.section - 2] as! NSCopying), configuration: { (cell) in
                    self.tableViewCategoryContentTableViewCellSetData(indexPath, cell: cell as! CategoryContentTableViewCell)
                })
            }
            return 32
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return CategoryViewHeight + 25
        case 1:
            return 32
        default:
            if indexPath.row == 0 {
                return 52
            }else if indexPath.row == 1{
                return 52
            }
            return 32
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
}

extension NewsViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tipListArray.count + 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.description(), for: indexPath)
            self.tableViewCategoryTableViewCellSetData(indexPath, cell: cell as! CategoryTableViewCell)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: HotDetailTableViewCell.description(), for: indexPath)
            self.tableViewHotDetailTableViewCellSetData(indexPath, cell: cell as! HotDetailTableViewCell)
            cell.selectionStyle = .none
            return cell
        default:
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
}
