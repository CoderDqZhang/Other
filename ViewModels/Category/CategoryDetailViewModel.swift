//
//  CategoryDetailViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet


class CategoryDetailViewModel: BaseViewModel {
    
    var categoryType:CategoryType!
    var categoryData:CategoryModel!
    var categoryHeaderHeight:CGFloat!
    var tipListArray = NSMutableArray.init()
    
    var page = 0
    override init() {
        super.init()
        if #available(iOS 11.0, *) {
            categoryHeaderHeight = NAV_HEIGHT + SCREENWIDTH * 165 / 375
        } else {
            categoryHeaderHeight = SCREENWIDTH * 165 / 375
        }

    }
    
    func tableViewCommentTableViewCellSetData(_ indexPath:IndexPath, cell:CommentTableViewCell) {
        if self.tipListArray.count > 0 {
            cell.cellSetData(model: TipModel.init(fromDictionary: self.tipListArray[indexPath.section - 1] as! [String : Any]))
        }
    }
    
    func tableViewUserInfoTableViewCellSetData(_ indexPath:IndexPath, cell:UserInfoTableViewCell){
        if self.tipListArray.count > 0  {
            cell.cellSetData(model: TipModel.init(fromDictionary: self.tipListArray[indexPath.section - 1] as! [String : Any]))
        }
    }
    
    func tableViewCategoryContentTableViewCellSetData(_ indexPath:IndexPath, cell:CategoryContentTableViewCell) {
        if self.tipListArray.count > 0 {
            cell.cellSetData(tipmodel: TipModel.init(fromDictionary: self.tipListArray[indexPath.section - 1] as! [String : Any]))
        }
    }
    
    func tableViewCategoryHeaderTableViewCellSetData(_ indexPath:IndexPath, cell:CategoryHeaderTableViewCell){
        cell.cellSetData(model: self.categoryData)
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
    
    func getCategoryNet(){
        page = page + 1
        let parameters = ["page":page.string, "limit":LIMITNUMBER, "tribeId":self.categoryData.id.string, "isCollect":"0"] as [String : Any]
        BaseNetWorke.sharedInstance.postUrlWithString(TipgetTipListUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
                if self.page != 1 {
                    self.tipListArray.addObjects(from: NSMutableArray.init(array: resultDic.value as! Array) as! [Any])
                }else{
                    self.tipListArray = NSMutableArray.init(array: resultDic.value as! Array)
                }
                self.reloadTableViewData()
                self.controller?.stopRefresh()
            }
        }
    }
}


extension CategoryDetailViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section != 0 {
            return 5
        }
        return 0.001
    }
    
    // 165 / 375
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return categoryHeaderHeight
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
            return categoryHeaderHeight
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
        var alpa:CGFloat = 0
        if #available(iOS 11.0, *) {
            alpa = scrollView.contentOffset.y / (categoryHeaderHeight - 64 - NAV_HEIGHT)
        } else {
            alpa = scrollView.contentOffset.y / (categoryHeaderHeight - 64)
            // Fallback on earlier versions
        }
        (self.controller as! CategoryDetailViewController).gloableNavigationBar.changeBackGroundColor(transparency: alpa > 1 ? 1 :alpa)
    }
}

extension CategoryDetailViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tipListArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryHeaderTableViewCell.description(), for: indexPath)
            self.tableViewCategoryHeaderTableViewCellSetData(indexPath, cell: cell as! CategoryHeaderTableViewCell)
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
            self.tableViewCommentTableViewCellSetData(indexPath, cell: cell as! CommentTableViewCell)
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension CategoryDetailViewModel : DZNEmptyDataSetDelegate {
    
}

extension CategoryDetailViewModel : DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributed = "暂时还没有数据哦！"
        let attributedString = NSMutableAttributedString.init(string: attributed)
        attributedString.addAttributes([NSAttributedString.Key.font:App_Theme_PinFan_M_16_Font!,NSAttributedString.Key.foregroundColor:App_Theme_CCCCCC_Color ?? ""], range: NSRange.init(location: 0, length: 9))
        
        return attributedString
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "pic_toy")
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -64
    }
}
