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

    
    var commentData:NSDictionary!
    var commentList:[ReplyList]!
    
    override init() {
        super.init()
    }
    
    func tableViewPostDetailCommentTableViewCellSetData(_ indexPath:IndexPath, cell:PostDetailCommentTableViewCell) {
//        if indexPath.section == 0 {
//            cell.cellSetData(images: commentData.object(forKey: "images") as! [String], secondeContents: [], content: commentData.object(forKey: "commet") as! String, isCommentDetail: true)
//        }else{
//            cell.cellSetData(images: [], secondeContents: [], content: commentList[indexPath.section - 1].contentStr, isCommentDetail: false)
//
//        }
    }
    
    func tableViewPostDetailCommentUserTableViewCellSetData(_ indexPath:IndexPath, cell:PostDetailCommentUserTableViewCell){
        cell.postDetailCommentUserTableViewCellClouse = {
            
        }
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
}


extension CommentViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 5
        }
        return 0.001
    }
    
    // 165 / 375
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 56
        }
        return tableView.fd_heightForCell(withIdentifier: PostDetailCommentTableViewCell.description(), cacheBy: indexPath, configuration: { (cell) in
            self.tableViewPostDetailCommentTableViewCellSetData(indexPath, cell: cell  as! PostDetailCommentTableViewCell)
        })
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 56
        }
        return 150
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension CommentViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return commentList.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailCommentUserTableViewCell.description(), for: indexPath)
            self.tableViewPostDetailCommentUserTableViewCellSetData(indexPath, cell: cell as! PostDetailCommentUserTableViewCell)
            cell.selectionStyle = .none
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailCommentTableViewCell.description(), for: indexPath)
        self.tableViewPostDetailCommentTableViewCellSetData(indexPath, cell: cell as! PostDetailCommentTableViewCell)
        cell.selectionStyle = .none
        if indexPath.section == 0 {
            (cell as! PostDetailCommentTableViewCell).lineLabel.isHidden = true
        }
        return cell
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
