//
//  MyCommentViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/20.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class MyCommentViewModel: BaseViewModel {
    
    let contentStrs = ["你认为今年的中超冠军会是谁？","你认为今年的中超冠军会是谁？","你认为今年的中超冠军会是谁？你认为今年的中超冠军会是谁？你认为今年的中超冠军会是谁？你认为今年的中超冠军会是谁？","你认为今年的中超冠军会是谁？","你认为今年的中超冠军会是谁？","你认为今年的中超冠军会是谁？"]
    let images = [[],["https://placehold.jp/150x150.png","https://placehold.jp/150x150.png","https://placehold.jp/150x150.png"],[],["https://placehold.jp/150x150.png","https://placehold.jp/150x150.png"],["https://placehold.jp/150x150.png"],["https://placehold.jp/150x150.png"]]
    
    override init() {
        super.init()
    }
    
    
    func tableViewCategoryContentTableViewCellSetData(_ indexPath:IndexPath, cell:CategoryContentTableViewCell) {
//        cell.cellSetData(content: contentStrs[indexPath.section], images: images[indexPath.section])
    }
    
    func tableViewUserInfoTableViewCellSetData(_ indexPath:IndexPath, cell:UserInfoTableViewCell){
        
    }
    
    func tableViewMCommentTableViewCellSetData(_ indexPath:IndexPath, cell:CommentTableViewCell){
        
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        if indexPath.row != 0 {
            let dicData = NSDictionary.init(dictionary: ["contentStrs":contentStrs[indexPath.section],"images":images[indexPath.section]], copyItems: true)
            (self.controller! as! NewsViewController).postDetailDataClouse(dicData,.OutFall)
        }
    }
}


extension MyCommentViewModel: UITableViewDelegate {
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
        (self.controller as! RecommendViewController).listViewDidScrollCallback?(scrollView)
    }
}

extension MyCommentViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return contentStrs.count
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

extension MyCommentViewModel : DZNEmptyDataSetDelegate {
    
}

extension MyCommentViewModel : DZNEmptyDataSetSource {
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
