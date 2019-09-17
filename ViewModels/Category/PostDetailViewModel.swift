//
//  PostViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit


class PostDetailViewModel: BaseViewModel {

    var postType:PostType!
    var tipDetailModel:TipModel!
    var commentListArray = NSMutableArray.init()
    var page:Int = 0
    var imageHeight:CGFloat = 0
    var isUpDataHeight:Bool = false
    override init() {
        super.init()
    }
    
    func tableViewPostDetailUserInfoTableViewCellSetData(_ indexPath:IndexPath, cell:PostDetailUserInfoTableViewCell) {
        if tipDetailModel != nil {
            cell.cellSetData(model: self.tipDetailModel)
        }
        cell.postDetailUserTagInfoClouse = {
            let dic:NSDictionary = self.tipDetailModel.user.toDictionary() as NSDictionary
            let otherMineVC = OtherMineViewController()
            otherMineVC.postData = dic
            NavigationPushView(self.controller!, toConroller: otherMineVC)
        }
        cell.postDetailUserInfoClouse = { type in
            self.followNet(status: type == GloabelButtonType.select ? true : false)
        }
    }
    
    func tableViewPostDetailContentTableViewCellSetData(_ indexPath:IndexPath, cell:PostDetailContentTableViewCell) {
        if tipDetailModel != nil {
            cell.cellSetData(model: self.tipDetailModel)
        }
        cell.postDetailContentTableViewCellClouse = { type, status in
            switch type {
            case .like:
               self.likeNet(status)
            case .login:
                let loginVC = LoginViewController()
                if status == .loginadd{
                    loginVC.loginDoneClouse = {
                        cell.likeButtonClick()
                    }
                }else{
                    loginVC.loginDoneClouse = {
                        cell.collectButtonClick()
                    }
                }
                NavigationPushView(self.controller!, toConroller: loginVC)
            default:
                 self.collectNet()
            }
        }
        
        cell.postDetailContentTableViewCellImageClickClouse = { tag,browser in
            NavigaiontPresentView(self.controller!, toController: browser)
        }
    }
    
    func tableViewPostDetailCommentTableViewCellSetData(_ indexPath:IndexPath, cell:PostDetailCommentTableViewCell) {
        if self.commentListArray.count > 0 {
            cell.cellSetData(model: CommentModel.init(fromDictionary: self.commentListArray[indexPath.section - 2] as! [String : Any]), isCommentDetail: false, isShowRepli: true)
            cell.postDetailCommentTableViewCellClouse = { model in
                if CacheManager.getSharedInstance().isLogin() {
                    if model.user.id.string == CacheManager.getSharedInstance().getUserId() {
                        KWindow.addSubview(GloableAlertView.init(titles: ["查看评论","删除评论"], cancelTitle: "取消", buttonClick: { (tag) in
                            if tag == 0 {
                                self.tableViewDidSelect(tableView: self.controller!.tableView, indexPath: indexPath)
                            }else{
                                UIAlertController.showAlertControl(self.controller!, style: .alert, title: "确定删除该条评论?", message: nil, cancel: "取消", doneTitle: "确定", cancelAction: {
                                    
                                }, doneAction: {
                                     let model = CommentModel.init(fromDictionary: self.commentListArray[indexPath.section - 2] as! [String : Any])
                                    self.deleteComment(commentId: model.id.string, model: model, indexPath: indexPath)
                                })
                            }
                        }, cancelAction: {
                        }))
                    }else{
                        KWindow.addSubview(GloableAlertView.init(titles: ["查看评论","举报评论"], cancelTitle: "取消", buttonClick: { (tag) in
                            if tag == 0 {
                                self.tableViewDidSelect(tableView: self.controller!.tableView, indexPath: indexPath)
                            }else{
                                UIAlertController.showAlertControl(self.controller!, style: .alert, title: "确定举报该条评论?", message: nil, cancel: "取消", doneTitle: "确定", cancelAction: {
                                    
                                }, doneAction: {
                                    let model = CommentModel.init(fromDictionary: self.commentListArray[indexPath.section - 2] as! [String : Any])
                                    self.reportCommentNet(commentId:  model.id.string, model: model, indexPath: indexPath)
                                })
                            }
                        }, cancelAction: {
                        }))
                    }
                }
            }
        }
    }
    
    func tableViewPostDetailCommentUserTableViewCellSetData(_ indexPath:IndexPath, cell:PostDetailCommentUserTableViewCell){
        
        if self.commentListArray.count > 0 {
            cell.cellSetData(model: CommentModel.init(fromDictionary: self.commentListArray[indexPath.section - 2] as! [String : Any]), indexPath: indexPath)
        }
        
        cell.postDetailCommentUserTableViewCellClouse = { indexPath, type in
            if type == .like {
                let model = CommentModel.init(fromDictionary: self.commentListArray[indexPath.section - 2] as! [String : Any])
                self.likeCommentNet(commentId: model.id.string, model:model, indexPath: indexPath)
            }else if type == .user{
                let dic:NSDictionary = CommentModel.init(fromDictionary: self.commentListArray[indexPath.section - 2] as! [String : Any]).user.toDictionary() as NSDictionary
                let otherMineVC = OtherMineViewController()
                otherMineVC.postData = dic
                NavigationPushView(self.controller!, toConroller: otherMineVC)
            }else{
                let loginVC = LoginViewController()
                loginVC.loginDoneClouse = {
                    cell.likeButtonClick()
                }
                NavigationPushView(self.controller!, toConroller: loginVC)
            }
        }
    }
    
    func tableViewHotDetailTableViewCellSetData(_ indexPath:IndexPath, cell:HotDetailTableViewCell) {
        if self.tipDetailModel != nil {
            cell.cellSetData(detail: "全部回复", number: self.tipDetailModel.commentTotal.string)
        }
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        if indexPath.section != 0 && indexPath.section != 1 {
            let commentVC = CommentViewController()
            commentVC.commentData = CommentModel.init(fromDictionary: self.commentListArray[indexPath.section - 2] as! [String : Any])
            commentVC.commentViewControllerApproveClouse = { model in
                self.commentListArray.replaceObject(at: indexPath.section - 2, with: model)
               self.controller?.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            NavigationPushView(self.controller!, toConroller: commentVC)
        }else if indexPath.section == 0 && indexPath.row == 0 {
            let dic:NSDictionary = self.tipDetailModel.user.toDictionary() as NSDictionary
            let otherMineVC = OtherMineViewController()
            otherMineVC.postData = dic
            NavigationPushView(self.controller!, toConroller: otherMineVC)
        }
    }
    
    func scrollerTableViewToPoint(){
        self.tableViewScrollToPoint(nil, IndexPath.init(row: 0, section: 2))
    }
    
    func getTipDetail(id:String){
        let parameters = ["tipId":id]
        BaseNetWorke.getSharedInstance().postUrlWithString(TipgetTipDetailUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.tipDetailModel = TipModel.init(fromDictionary: resultDic.value as! [String : Any])
                (self.controller! as! PostDetailViewController).navigationItem.title = self.tipDetailModel.tribe.tribeName
                self.reloadTableViewData()
                (self.controller as! PostDetailViewController).postData = self.tipDetailModel.toDictionary() as NSDictionary
                (self.controller as! PostDetailViewController).setUpViewNavigationItem()
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func getComments(id:String){
        page = page + 1
        let parameters = ["page":page.string, "limit":LIMITNUMBER, "tipId": id]
        BaseNetWorke.getSharedInstance().postUrlWithString(CommentcommentListUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if self.page != 1 {
                    self.commentListArray.addObjects(from: NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array) as! [Any])
                }else{
                    self.commentListArray.removeAllObjects()
                    self.commentListArray = NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array)
                }
                self.reloadTableViewData()
                if (self.controller as! PostDetailViewController).gotoType != nil {
                    if (self.controller as! PostDetailViewController).gotoType == .comment {
                        self.scrollerTableViewToPoint()
                    }
                }
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func collectNet(){
        let parameters = ["tipId":self.tipDetailModel.id!.string]
        BaseNetWorke.getSharedInstance().postUrlWithString(TipcollectTipUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "操作成功", autoHidder: true)
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func likeNet(_ status:ToolsStatus){
        let parameters = ["tipId":self.tipDetailModel.id!.string]
        BaseNetWorke.getSharedInstance().postUrlWithString(TipapproveTipUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if (self.controller! as! PostDetailViewController).changeAllCommentAndLikeNumberClouse != nil {
                    (self.controller! as! PostDetailViewController).changeAllCommentAndLikeNumberClouse(.like, status)
                }
                _ = Tools.shareInstance.showMessage(KWindow, msg: "操作成功", autoHidder: true)
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func likeCommentNet(commentId:String,model:CommentModel, indexPath:IndexPath){
        let parameters = ["commentId":commentId]
        BaseNetWorke.getSharedInstance().postUrlWithString(CommentcommentApprovetUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if model.isFollow == 1 {
                    model.isFollow = 0
                    model.approveNum = model.approveNum - 1
                }else{
                    model.isFollow = 1
                    model.approveNum = model.approveNum + 1
                }
                self.commentListArray.replaceObject(at: indexPath.section - 2, with: model.toDictionary())
                _ = Tools.shareInstance.showMessage(KWindow, msg: "操作成功", autoHidder: true)
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func deleteComment(commentId:String,model:CommentModel, indexPath:IndexPath){
        let parameters = ["commentId":commentId]
        BaseNetWorke.getSharedInstance().postUrlWithString(CommentcommentDelUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                model.content = "评论以删除"
                model.status = "1" //自己删除
                self.commentListArray.replaceObject(at: indexPath.section - 2, with: model.toDictionary())
                self.reloadTableViewData()
                _ = Tools.shareInstance.showMessage(KWindow, msg: "操作成功", autoHidder: true)
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func reportCommentNet(commentId:String, model:CommentModel, indexPath:IndexPath){
        let parameters = ["param":commentId,"type":"1"]
        BaseNetWorke.getSharedInstance().postUrlWithString(ReportAddReportUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "举报成功", autoHidder: true)
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func deleteArticle(tipId:String,model:TipModel){
        let parameters = ["tipId":tipId]
        BaseNetWorke.getSharedInstance().postUrlWithString(TipArticleDeleteUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                model.content = "文章以删除"
                model.status = "1" //自己删除
                if (self.controller! as! PostDetailViewController).deleteArticleClouse != nil {
                    (self.controller! as! PostDetailViewController).deleteArticleClouse()
                }
                self.controller?.navigationController?.popViewController()
                _ = Tools.shareInstance.showMessage(KWindow, msg: "操作成功", autoHidder: true)
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func reportAritcleNet(tipId:String, model:TipModel){
        let parameters = ["param":tipId,"type":"0"]
        BaseNetWorke.getSharedInstance().postUrlWithString(ReportAddReportUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "举报成功", autoHidder: true)
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    
    func followNet(status:Bool){
        let parameters = ["userId":self.tipDetailModel.user.id!.string]
        BaseNetWorke.getSharedInstance().postUrlWithString(PersonfollowUserUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if (self.controller as! PostDetailViewController).changeFansFollowButtonStatusClouse != nil {
                    (self.controller as! PostDetailViewController).changeFansFollowButtonStatusClouse(status)
                }
                _ = Tools.shareInstance.showMessage(KWindow, msg: status == true ? "关注成功" : "取消关注成功", autoHidder: true)
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func getContentHeight() ->CGFloat{
        let titleSize = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_18_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: self.tipDetailModel.title, yyLabel: YYLabel.init())
        
        let contentSize = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_15_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: self.tipDetailModel.content, yyLabel: YYLabel.init())
        if self.tipDetailModel != nil {
            imageHeight = self.imageContentHeight(image: self.tipDetailModel.image, contentWidth: SCREENWIDTH - 30)
        }
        return titleSize.textBoundingSize.height + contentSize.textBoundingSize.height + 132 + imageHeight - (contentSize.textBoundingSize.height == 0 ? 20 : 0)
    }
    
}


extension PostDetailViewModel: UITableViewDelegate {
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
        }else if section == 1{
            return 1
        }
        return 0.001
    }
    
    // 165 / 375
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return 60
            }
            if self.tipDetailModel != nil {
                return self.getContentHeight()
            }
            return 60
            
        case 1:
            return 32
        default:
            if indexPath.row == 0 {
                return 56
            }
            return tableView.fd_heightForCell(withIdentifier: PostDetailCommentTableViewCell.description(), cacheByKey: (self.commentListArray[indexPath.section - 2] as! NSCopying), configuration: { (cell) in
                self.tableViewPostDetailCommentTableViewCellSetData(indexPath, cell: cell  as! PostDetailCommentTableViewCell)
            })
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return 60
            }
            return 150
        case 1:
            return 32
        default:
            return 150
        }
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
}

extension PostDetailViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return commentListArray.count + 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailUserInfoTableViewCell.description(), for: indexPath)
                self.tableViewPostDetailUserInfoTableViewCellSetData(indexPath, cell: cell as! PostDetailUserInfoTableViewCell)
                cell.selectionStyle = .none
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailContentTableViewCell.description(), for: indexPath)
            self.tableViewPostDetailContentTableViewCellSetData(indexPath, cell: cell as! PostDetailContentTableViewCell)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: HotDetailTableViewCell.description(), for: indexPath)
            self.tableViewHotDetailTableViewCellSetData(indexPath, cell: cell as! HotDetailTableViewCell)
            cell.selectionStyle = .none
            return cell
        default:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailCommentUserTableViewCell.description(), for: indexPath)
                self.tableViewPostDetailCommentUserTableViewCellSetData(indexPath, cell: cell as! PostDetailCommentUserTableViewCell)
                cell.selectionStyle = .none
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailCommentTableViewCell.description(), for: indexPath)
            self.tableViewPostDetailCommentTableViewCellSetData(indexPath, cell: cell as! PostDetailCommentTableViewCell)
            (cell as! PostDetailCommentTableViewCell).hiddenLineLabel(ret: self.commentListArray.count - 1 == indexPath.section - 2 ? true : false)
            cell.selectionStyle = .none
            return cell
        }
    }
}
