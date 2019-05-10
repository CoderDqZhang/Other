//
//  CommentViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class CommentViewModel: BaseViewModel {

    var postType:PostType!
    var categoryData:NSDictionary!
    
    var isTrans:Bool = false
    override init() {
        
    }
    
    func tableViewCommentContentTableViewCellSetData(_ indexPath:IndexPath, cell:CommentContentTableViewCell) {
        
    }
    
    func tableViewOutFallCategoryContentTableViewCellSetData(_ indexPath:IndexPath, cell:OutFallCategoryContentTableViewCell) {
        cell.cellSetData(content: categoryData.object(forKey: "contentStrs") as! String, translate: categoryData.object(forKey: "translateStrs") as! String, images: categoryData.object(forKey: "contentStrs") as! [String], isTrans: false, indexPath: indexPath, transButtonClicks: { indexPath in
            self.isTrans = true
            self.controller?.tableView.reloadRows(at: [indexPath], with: .automatic)
        })
    }
    
    func tableViewUserInfoTableViewCellSetData(_ indexPath:IndexPath, cell:UserInfoTableViewCell){
        
    }
    
    func tableViewOutFallCategoryUserInfoTableViewCellSetData(_ indexPath:IndexPath, cell:OutFallCategoryUserInfoTableViewCell){
        
    }
    
    func tableViewCategoryContentTableViewCellSetData(_ indexPath:IndexPath, cell:CategoryContentTableViewCell) {
        cell.cellSetData(content: categoryData.object(forKey: "contentStrs") as! String, images: self.categoryData.object(forKey: "images") as! [String])
    }
    
    func tableViewMCommentTableViewCellSetData(_ indexPath:IndexPath, cell:CommentTableViewCell){
        
    }
    
    func tableViewCommentTableViewCellSetData(_ indexPath:IndexPath, cell:CommentTableViewCell){
        
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
    
    ///获取内容高度
    func getHeight(_ indexPath:IndexPath, isTrans:Bool) -> CGFloat{
        let stringHeight = (categoryData.object(forKey: "contentStrs") as! String).nsString.height(with: App_Theme_PinFan_M_14_Font, constrainedToWidth: SCREENWIDTH - 30)
        let transHeight = (self.categoryData.object(forKey: "contentStrs") as! String).nsString.height(with: App_Theme_PinFan_M_14_Font, constrainedToWidth: SCREENWIDTH - 30)
        let imageHeight = (self.categoryData.object(forKey: "images") as! [String]).count > 1 ? contentImageHeight : 0
        if isTrans {
            return stringHeight + transHeight + imageHeight + 50
        }
        return stringHeight + imageHeight + 50
        
    }
}


extension CommentViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            
            if indexPath.row == 0 {
                return 52
            }else{
                if self.postType == .OutFall {
                    return self.getHeight(indexPath, isTrans: self.isTrans)
                }
                return tableView.fd_heightForCell(withIdentifier: CategoryContentTableViewCell.description(), cacheBy: indexPath, configuration: { (cell) in
                    (cell as! CategoryContentTableViewCell).cellSetData(content: self.categoryData.object(forKey: "contentStrs") as! String, images: self.categoryData.object(forKey: "images") as! [String])
                })
            }
        default:
            return 69
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension CommentViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if self.postType == .OutFall{
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: OutFallCategoryUserInfoTableViewCell.description(), for: indexPath)
                    self.tableViewOutFallCategoryUserInfoTableViewCellSetData(indexPath, cell: cell as! OutFallCategoryUserInfoTableViewCell)
                    cell.selectionStyle = .none
                    return cell
                }
                let cell = tableView.dequeueReusableCell(withIdentifier: OutFallCategoryContentTableViewCell.description(), for: indexPath)
                self.tableViewOutFallCategoryContentTableViewCellSetData(indexPath, cell: cell as! OutFallCategoryContentTableViewCell)
                cell.selectionStyle = .none
                return cell
            }else{
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoTableViewCell.description(), for: indexPath)
                    self.tableViewUserInfoTableViewCellSetData(indexPath, cell: cell as! UserInfoTableViewCell)
                    cell.selectionStyle = .none
                    return cell
                }
                let cell = tableView.dequeueReusableCell(withIdentifier: CategoryContentTableViewCell.description(), for: indexPath)
                self.tableViewCategoryContentTableViewCellSetData(indexPath, cell: cell as! CategoryContentTableViewCell)
                cell.selectionStyle = .none
                return cell
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: CommentContentTableViewCell.description(), for: indexPath)
            self.tableViewCommentContentTableViewCellSetData(indexPath, cell: cell as! CommentContentTableViewCell)
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension CommentViewModel : DZNEmptyDataSetDelegate {
    
}

extension CommentViewModel : DZNEmptyDataSetSource {
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

