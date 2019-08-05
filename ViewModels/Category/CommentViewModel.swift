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
    
    var imageHeight:CGFloat = 0
    var isUpDataHeight:Bool = false
    override init() {
        super.init()
    }
    
    func tableViewPostDetailCommentTableViewCellSetData(_ indexPath:IndexPath, cell:PostDetailCommentTableViewCell) {
        cell.cellSetData(model: self.commentData, isCommentDetail: true, isShowRepli: false)
        
        cell.postDetailContentTableViewCellImageClickClouse = { tag,browser in
            NavigaiontPresentView(self.controller!, toController: browser)
        }
    }
    
    func tableViewReplyContentTableViewCellSetData(_ indexPath:IndexPath, cell:ReplyContentTableViewCell) {
        let model =  ReplyList.init(fromDictionary:replistList[indexPath.section - 1] as! [String : Any])
        cell.cellSetRepliy(model: model, isReplyComment: model.toNickname == commentData.user.nickname ? true : false)
        cell.replyContentTableViewCellClouse = { model in
            if CacheManager.getSharedInstance().isLogin() {
                if model.userId.string == CacheManager.getSharedInstance().getUserId() {
                    KWindow.addSubview(GloableAlertView.init(titles: ["回复评论","删除回复"], cancelTitle: "取消", buttonClick: { (tag) in
                        if tag == 0 {
                            self.tableViewDidSelect(tableView: self.controller!.tableView, indexPath: indexPath)
                        }else{
                            UIAlertController.showAlertControl(self.controller!, style: .alert, title: "确定删除该条回复?", message: nil, cancel: "取消", doneTitle: "确定", cancelAction: {
                                
                            }, doneAction: {
                                let model = ReplyList.init(fromDictionary: self.replistList[indexPath.section - 1] as! [String : Any])
                                self.deleteApproveNet(approveId: model.id.string, model: model, indexPath: indexPath)
                            })
                        }
                    }, cancelAction: {
                        //                            print("cancel")
                    }))
                }else{
                    KWindow.addSubview(GloableAlertView.init(titles: ["回复评论","举报回复"], cancelTitle: "取消", buttonClick: { (tag) in
                        if tag == 0 {
                            self.tableViewDidSelect(tableView: self.controller!.tableView, indexPath: indexPath)
                        }else{
                            UIAlertController.showAlertControl(self.controller!, style: .alert, title: "确定举报该条回复?", message: nil, cancel: "取消", doneTitle: "确定", cancelAction: {
                                
                            }, doneAction: {
                                let model = ReplyList.init(fromDictionary: self.replistList[indexPath.section - 1] as! [String : Any])
                                self.reportApproveNet(approveId: model.id.string, model: model, indexPath: indexPath)
                            })
                        }
                    }, cancelAction: {
                        //                            print("cancel")
                    }))
                }
            }
        }
    }
    
    func tableViewPostDetailCommentUserTableViewCellSetData(_ indexPath:IndexPath, cell:PostDetailCommentUserTableViewCell){
        if indexPath.section == 0 {
            cell.cellSetData(model: self.commentData, indexPath: indexPath)
            cell.postDetailCommentUserTableViewCellClouse = { indexPath, type in
                if type == .like {
                    self.likeCommentNet(commentId: self.commentData.id.string)
                }else{
                    let dic:NSDictionary = self.commentData.user.toDictionary() as NSDictionary
                    let otherMineVC = OtherMineViewController()
                    otherMineVC.postData = dic
                    NavigationPushView(self.controller!, toConroller: otherMineVC)
                }
            }
        }else{
            cell.cellSetRepliy(model:  ReplyList.init(fromDictionary: replistList[indexPath.section - 1] as! [String : Any]), indexPath: indexPath)
            cell.postDetailCommentUserTableViewCellClouse = { indexPath,type in
                if type == .like {
                    self.likeNet(model: ReplyList.init(fromDictionary: self.replistList[indexPath.section - 1] as! [String : Any]))
                }else {
//                    let dic:NSDictionary = ReplyList.init(fromDictionary: self.replistList[indexPath.section - 1] as! [String : Any]).user.toDictionary() as NSDictionary
//                    let otherMineVC = OtherMineViewController()
//                    otherMineVC.postData = dic
//                    NavigationPushView(self.controller!, toConroller: otherMineVC)
                }
            }
        }
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        if indexPath.section != 0 {
            
            let model = ReplyList.init(fromDictionary: self.replistList[indexPath.section - 1] as! [String : Any])
            if model.status == "0" {
                (self.controller! as! CommentViewController).gloableCommentView.textView.placeholderText = "回复\(String(describing: model.nickname!))"
                self.selectReply = model
                (self.controller! as! CommentViewController).gloableCommentView.textView.becomeFirstResponder()
            }else{
                _ = Tools.shareInstance.showMessage(KWindow, msg: "回复已删除", autoHidder: true)
            }
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
                    self.replistList.addObjects(from: NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array) as! [Any])
                }else{
                    self.replistList.removeAllObjects()
                    self.replistList = NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array)
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
            parameters = ["content":content, "toUserId":self.selectReply.userId.string, "commentId":self.commentData.id.string] as [String : Any]
        }
        BaseNetWorke.getSharedInstance().postUrlWithString(ReplyreplyUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                let model = ReplyList.init(fromDictionary: resultDic.value as! [String : Any])
                self.commentData.replyList.append(model)
                if (self.controller! as! CommentViewController).commentViewControllerApproveClouse != nil {
                    (self.controller! as! CommentViewController).commentViewControllerApproveClouse(self.commentData.toDictionary() as NSDictionary)
                }
                _ = Tools.shareInstance.showMessage(KWindow, msg: "回复成功", autoHidder: true)
                self.replyDone()
                if self.controller?.reloadDataClouse != nil {
                    self.controller?.reloadDataClouse()
                }
                self.controller?.tableView.mj_header.beginRefreshing()
            }
        }
    }
    
    func likeCommentNet(commentId:String){
        let parameters = ["commentId":commentId]
        BaseNetWorke.getSharedInstance().postUrlWithString(CommentcommentApprovetUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if self.commentData.isFollow == 1 {
                    self.commentData.isFollow = 0
                    self.commentData.approveNum = self.commentData.approveNum - 1
                }else{
                    self.commentData.isFollow = 1
                    self.commentData.approveNum = self.commentData.approveNum + 1
                }
                if (self.controller! as! CommentViewController).commentViewControllerApproveClouse != nil {
                    (self.controller! as! CommentViewController).commentViewControllerApproveClouse(self.commentData.toDictionary() as NSDictionary)
                }
                _ = Tools.shareInstance.showMessage(KWindow, msg: "操作成功", autoHidder: true)
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func deleteApproveNet(approveId:String, model:ReplyList, indexPath:IndexPath){
        let parameters = ["replyId":approveId]
        BaseNetWorke.getSharedInstance().postUrlWithString(ReplyreplyreplyDeleteUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                model.content = "回复已删除"
                model.status = "1" //自己删除
                self.replistList.replaceObject(at: indexPath.section - 1, with: model.toDictionary())
                self.reloadTableViewData()
                _ = Tools.shareInstance.showMessage(KWindow, msg: "操作成功", autoHidder: true)
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func reportApproveNet(approveId:String, model:ReplyList, indexPath:IndexPath){
        let parameters = ["param":approveId,"type":"2"]
        BaseNetWorke.getSharedInstance().postUrlWithString(ReportAddReportUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "举报成功", autoHidder: true)
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func replyDone(){
        (self.controller! as! CommentViewController).gloableCommentView.textView.placeholderText = "请输入你的精彩回复"
        self.selectReply = nil
    }
    
    func getContentHeight() ->CGFloat{
    
        let contentSize = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_15_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: self.commentData.content, yyLabel: YYLabel.init())
        if self.commentData != nil {
            imageHeight = self.imageContentHeight(image: self.commentData.img, contentWidth: SCREENWIDTH - 30)
        }
        return contentSize.textBoundingSize.height + imageHeight + 25
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
            return self.getContentHeight()
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
