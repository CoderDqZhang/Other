//
//  NewsViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class NewsViewModel: BaseViewModel {

    var categoryArray = NSMutableArray.init()
    var tipListArray = NSMutableArray.init()
    
    let categoryType = [CategoryType.BasketBall,CategoryType.FootBall,CategoryType.FootBallEurope,CategoryType.BasketBallEurope]
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
        cell.categoryTableViewCellClouseClick = { tag in
            let dic = NSDictionary.init(dictionary: self.categoryArray[tag] as! [String:Any])
            (self.controller! as! NewsViewController).categoryDetailClouse(dic,self.categoryType[tag])
        }
    }
    
    func tableViewCategoryContentTableViewCellSetData(_ indexPath:IndexPath, cell:CategoryContentTableViewCell) {
        if self.tipListArray.count > 0 {
            cell.cellSetData(tipmodel: TipModel.init(fromDictionary: self.tipListArray[indexPath.section - 2] as! [String : Any]))
        }
    }
    
    func tableViewUserInfoTableViewCellSetData(_ indexPath:IndexPath, cell:UserInfoTableViewCell){
        if self.tipListArray.count > 0 {
            cell.cellSetData(model: TipModel.init(fromDictionary: self.tipListArray[indexPath.section - 2] as! [String : Any]))
        }
    }
    
    func tableViewMCommentTableViewCellSetData(_ indexPath:IndexPath, cell:CommentTableViewCell){
        if self.tipListArray.count > 0 {
            cell.cellSetData(model: TipModel.init(fromDictionary: self.tipListArray[indexPath.section - 2] as! [String : Any]))
        }
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        if indexPath.row != 0 {
//            let dicData = NSDictionary.init(dictionary: ["contentStrs":contentStrs[indexPath.section - 2],"images":images[indexPath.section - 2]], copyItems: true)
//            (self.controller! as! NewsViewController).postDetailDataClouse(dicData,.OutFall)
        }
    }
    
    func getCategoryNet(){
        BaseNetWorke.sharedInstance.postUrlWithString(TribetribeListUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.categoryArray = NSMutableArray.init(array: resultDic.value as! Array)
                self.reloadTableViewData()
            }
        }
    }
    
    func getTribeListNet(){
        page = page + 1
        let parameters = ["page":page.string, "limit":"3", "tribeId":"0", "isCollect":"0"]
        BaseNetWorke.sharedInstance.postUrlWithString(TipgetTipListUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if self.page != 1 {
                    self.tipListArray.addObjects(from: NSMutableArray.init(array: resultDic.value as! Array) as! [Any])
                }else{
                    self.tipListArray = NSMutableArray.init(array: resultDic.value as! Array)
                }
                self.reloadTableViewData()
                if self.controller?.tableView.mj_header != nil {
                    self.controller?.stopRefresh()
                }
                if self.controller?.tableView.mj_footer != nil {
                    self.controller?.stopLoadMoreData()
                }
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
                return tableView.fd_heightForCell(withIdentifier: CategoryContentTableViewCell.description(), cacheBy: indexPath, configuration: { (cell) in
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

extension NewsViewModel : DZNEmptyDataSetDelegate {
    
}

extension NewsViewModel : DZNEmptyDataSetSource {
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
