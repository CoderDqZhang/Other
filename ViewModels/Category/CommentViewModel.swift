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

    
    var commentData:CommentModel!
    var selectReply:ReplyList!
    var replistList = NSMutableArray.init()
    var page:Int = 0
    var content:String = ""
    
    override init() {
        super.init()
    }
    
    func tableViewPostDetailCommentTableViewCellSetData(_ indexPath:IndexPath, cell:PostDetailCommentTableViewCell) {
        cell.cellSetData(model: self.commentData, isCommentDetail: false, isShowRepli: false)
        cell.postDetailContentTableViewCellImageClickClouse = { tag,browser in
            NavigaiontPresentView(self.controller!, toController: browser)
        }
    }
    
    func tableViewReplyContentTableViewCellSetData(_ indexPath:IndexPath, cell:ReplyContentTableViewCell) {
        let model =  ReplyList.init(fromDictionary:replistList[indexPath.section - 1] as! [String : Any])
        cell.cellSetRepliy(model: model, isReplyComment: model.toNickname == commentData.user.nickname ? true : false)
    }
    
    func tableViewPostDetailCommentUserTableViewCellSetData(_ indexPath:IndexPath, cell:PostDetailCommentUserTableViewCell){
        if indexPath.section == 0 {
            cell.cellSetData(model: self.commentData, indexPath: indexPath)
        }else{
            cell.cellSetRepliy(model:  ReplyList.init(fromDictionary: replistList[indexPath.section - 1] as! [String : Any]), indexPath: indexPath)
            cell.postDetailCommentUserTableViewCellClouse = { indexPath in
                self.likeNet(model: ReplyList.init(fromDictionary: self.replistList[indexPath.section - 1] as! [String : Any]))
            }
        }
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        if indexPath.section != 0 {
            let model = ReplyList.init(fromDictionary: self.replistList[indexPath.section - 1] as! [String : Any])
            (self.controller! as! CommentViewController).gloableCommentView.textView.placeholderText = "回复\(String(describing: model.nickname!))"
            self.selectReply = model
            (self.controller! as! CommentViewController).gloableCommentView.textView.becomeFirstResponder()
            
        }
    }
    
    func likeNet(model:ReplyList){
        let parameters = ["replyId":model.id!.string,"userId":model.userId.string]
        BaseNetWorke.getSharedInstance().postUrlWithString(CommentReplyApprovetUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "点赞成功", autoHidder: true)
            }
        }
    }
    
    func getReplitList(){
        page = page + 1
        let parameters = ["page":page.string, "limit":LIMITNUMBER, "commentId": self.commentData.id.string]
        BaseNetWorke.getSharedInstance().postUrlWithString(ReplyreplyreplyListUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if self.page != 1 {
                    self.replistList.addObjects(from: NSMutableArray.init(array: resultDic.value as! Array) as! [Any])
                }else{
                    self.replistList.removeAllObjects()
                    self.replistList = NSMutableArray.init(array: resultDic.value as! Array)
                }
                self.reloadTableViewData()
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func setUpReplit(content:String){
        if content == "" {
            _ = Tools.shareInstance.showMessage(KWindow, msg: "请输入数据", autoHidder: true)
            return
        }
        var parameters:[String : Any]
        if self.selectReply == nil {
            parameters = ["content":content, "toUserId":self.commentData.user.id.string, "commentId":self.commentData.id.string] as [String : Any]
        }else{
            if self.selectReply.userId.string == CacheManager.getSharedInstance().getUserId() {
                self.replyDone()
                _ = Tools.shareInstance.showMessage(KWindow, msg: "不能够回复自己", autoHidder: true)
                return
            }
            parameters = ["content":content, "toUserId":self.selectReply.userId.string, "commentId":self.commentData.id.string] as [String : Any]
        }
        BaseNetWorke.getSharedInstance().postUrlWithString(ReplyreplyUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "回复成功", autoHidder: true)
                self.replyDone()
                if self.controller?.reloadDataClouse != nil {
                    self.controller?.reloadDataClouse()
                }
                self.controller?.tableView.mj_header.beginRefreshing()
            }
        }
    }
    
    func replyDone(){
        (self.controller! as! CommentViewController).gloableCommentView.textView.placeholderText = "请输入你的精彩回复"
        self.selectReply = nil
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
        if indexPath.section == 0 {
            return tableView.fd_heightForCell(withIdentifier: PostDetailCommentTableViewCell.description(), cacheByKey: (self.commentData), configuration: { (cell) in
                self.tableViewPostDetailCommentTableViewCellSetData(indexPath, cell: cell  as! PostDetailCommentTableViewCell)
            })
        }
        return tableView.fd_heightForCell(withIdentifier: ReplyContentTableViewCell.description(), cacheByKey: (self.replistList[indexPath.section - 1] as! NSCopying), configuration: { (cell) in
            self.tableViewReplyContentTableViewCellSetData(indexPath, cell: cell  as! ReplyContentTableViewCell)
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
        return replistList.count + 1
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
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailCommentTableViewCell.description(), for: indexPath)
            self.tableViewPostDetailCommentTableViewCellSetData(indexPath, cell: cell as! PostDetailCommentTableViewCell)
            cell.selectionStyle = .none
            if indexPath.section == 0 {
                (cell as! PostDetailCommentTableViewCell).lineLabel.isHidden = true
            }
            return cell

        }
        let cell = tableView.dequeueReusableCell(withIdentifier: ReplyContentTableViewCell.description(), for: indexPath)
        self.tableViewReplyContentTableViewCellSetData(indexPath, cell: cell as! ReplyContentTableViewCell)
        cell.selectionStyle = .none
        if indexPath.section == 0 {
            (cell as! ReplyContentTableViewCell).lineLabel.isHidden = true
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
