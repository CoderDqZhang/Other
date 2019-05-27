//
//  PostViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class PostDetailViewModel: BaseViewModel {

    var postType:PostType!
    var tipDetailModel:TipDetailModel!
    var commentListArray = NSMutableArray.init()
    var page:Int = 0
    override init() {
        super.init()
    }
    
    func tableViewPostDetailUserInfoTableViewCellSetData(_ indexPath:IndexPath, cell:PostDetailUserInfoTableViewCell) {
        if tipDetailModel != nil {
            cell.cellSetData(model: self.tipDetailModel)
        }
        cell.postDetailUserInfoClouse = {
            print("关注")
        }
    }
    
    func tableViewPostDetailContentTableViewCellSetData(_ indexPath:IndexPath, cell:PostDetailContentTableViewCell) {
        if tipDetailModel != nil {
            cell.cellSetData(model: self.tipDetailModel)
        }
        cell.postDetailContentTableViewCellClouse = { type in
            switch type {
            case .like:
                self.likeNet()
            default:
                 self.collectNet()
            }
        }
    }
    
    func tableViewPostDetailCommentTableViewCellSetData(_ indexPath:IndexPath, cell:PostDetailCommentTableViewCell) {
        if self.commentListArray.count > 0 {
            cell.cellSetData(model: CommentModel.init(fromDictionary: self.commentListArray[indexPath.section - 2] as! [String : Any]), isCommentDetail: false)
        }
    }
    
    func tableViewPostDetailCommentUserTableViewCellSetData(_ indexPath:IndexPath, cell:PostDetailCommentUserTableViewCell){
        
        if self.commentListArray.count > 0 {
            cell.cellSetData(model: CommentModel.init(fromDictionary: self.commentListArray[indexPath.section - 2] as! [String : Any]))
        }
        
        cell.postDetailCommentUserTableViewCellClouse = {
            
        }
    }
    
    func tableViewHotDetailTableViewCellSetData(_ indexPath:IndexPath, cell:HotDetailTableViewCell) {
        cell.cellSetData(detail: "全部回复", number: "66")
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
//        let commentVC = CommentViewController()
//        commentVC.commentData = ["commet":commets[indexPath.section - 2],"images":images[indexPath.section - 2]]
//        commentVC.commentList = self.testModel[indexPath.section - 2]
//        NavigationPushView(self.controller!, toConroller: commentVC)
    }
    
    func getTipDetail(id:String){
        let parameters = ["tipId":id]
        BaseNetWorke.sharedInstance.postUrlWithString(TipgetTipDetailUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.tipDetailModel = TipDetailModel.init(fromDictionary: resultDic.value as! [String : Any])
                self.reloadTableViewData()
            }
        }
    }
    
    func getComments(id:String){
        let parameters = ["page":page.string, "limit":"10", "tipId":"6"]
        BaseNetWorke.sharedInstance.postUrlWithString(CommentcommentListUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if self.page != 1 {
                    self.commentListArray.addObjects(from: NSMutableArray.init(array: resultDic.value as! Array) as! [Any])
                }else{
                    self.commentListArray = NSMutableArray.init(array: resultDic.value as! Array)
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
    
    func collectNet(){
        let parameters = ["tipId":self.tipDetailModel.tip.id!.string]
        BaseNetWorke.sharedInstance.postUrlWithString(TipcollectTipUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "收藏成功", autoHidder: true)
            }
        }
    }
    
    func likeNet(){
        let parameters = ["tipId":self.tipDetailModel.tip.id!.string]
        BaseNetWorke.sharedInstance.postUrlWithString(TipapproveTipUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "点赞成功", autoHidder: true)
            }
        }
    }
    
    func followNet(){
        let parameters = ["tipId":self.tipDetailModel.user.id!.string]
        BaseNetWorke.sharedInstance.postUrlWithString(PersonfollowUserUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "关注成功", autoHidder: true)
            }
        }
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
            return tableView.fd_heightForCell(withIdentifier: PostDetailContentTableViewCell.description(), cacheBy: indexPath, configuration: { (cell) in
                self.tableViewPostDetailContentTableViewCellSetData(indexPath, cell: cell as! PostDetailContentTableViewCell)
            })
            
        case 1:
            return 32
        default:
            if indexPath.row == 0 {
                return 56
            }
            return tableView.fd_heightForCell(withIdentifier: PostDetailCommentTableViewCell.description(), cacheBy: indexPath, configuration: { (cell) in
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
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension PostDetailViewModel : DZNEmptyDataSetDelegate {
    
}

extension PostDetailViewModel : DZNEmptyDataSetSource {
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
