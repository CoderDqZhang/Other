//
//  CommentPostViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/14.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
//with = 375 height = 247
let CommentTextViewCcale:CGFloat = 247 / 375

class CommentPostViewModel: BaseViewModel,UIImagePickerControllerDelegate {
    
    var selectPhotos:NSMutableArray = NSMutableArray.init()
    var selectAssets:NSMutableArray = NSMutableArray.init()
    var isSelectOriginalPhoto:Bool!
    
    var commentContent:String = ""
    var postData:NSDictionary!
    
    override init() {
        super.init()
    }
    
    func tableViewPostCommentImagesTableViewCellSetData(_ indexPath:IndexPath, cell:PostCommentImagesTableViewCell){
        cell.cellSetData(images: selectPhotos)
        cell.postCommentImageAddButtonClouse = { btn in
            (self.controller as! CommentPostViewController).setUpAlerViewController()
        }
        cell.postCommentImageImageButtonClouse = { tag in
            (self.controller as! CommentPostViewController).setUpPrewImagePickerBrowser(index: tag)
        }
        
    }
    
    func tableViewPostCommentTextTableViewCellSetData(_ indexPath:IndexPath, cell:PostCommentTextTableViewCell) {
        cell.postCommentTextTableViewCellTextClouse = { str in
            self.commentContent = str
        }
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
    
    
    func postTCommentNet(){
        if self.commentContent == "" && self.selectPhotos.count == 0 {
            _ = Tools.shareInstance.showMessage(KWindow, msg: "请输入内容", autoHidder: true)
            return
        }
        if self.selectPhotos.count > 0 {
            AliPayManager.getSharedInstance().uploadFile(images: self.selectPhotos, type: .post) { imgs,strs  in
                let parameters = ["content":self.commentContent, "tipId":(self.postData.object(forKey: "id") as! Int).string,"img":strs] as [String : Any]
                BaseNetWorke.getSharedInstance().postUrlWithString(CommentcommentUrl, parameters: parameters as AnyObject).observe { (resultDic) in
                    if !resultDic.isCompleted {
                        let model = CommentModel.init(fromDictionary: resultDic.value as! [String : Any])
                        if (self.controller as! CommentPostViewController).commentPostViewControllerDataClouse != nil {
                            (self.controller as! CommentPostViewController).commentPostViewControllerDataClouse(model.toDictionary() as NSDictionary)
                        }
                        _ = Tools.shareInstance.showMessage(KWindow, msg: "评论成功", autoHidder: true)
                        self.controller?.dismiss(animated: true, completion: {

                        })
                    }else{
                        self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
                    }
                }
            }
            
        }else{
            let parameters = ["content":self.commentContent, "tipId":(self.postData.object(forKey: "id") as! Int).string,"image":""] as [String : Any]
            BaseNetWorke.getSharedInstance().postUrlWithString(CommentcommentUrl, parameters: parameters as AnyObject).observe { (resultDic) in
                if !resultDic.isCompleted {
                    let model = CommentModel.init(fromDictionary: resultDic.value as! [String : Any])
                    if (self.controller as! CommentPostViewController).commentPostViewControllerDataClouse != nil {
                        (self.controller as! CommentPostViewController).commentPostViewControllerDataClouse(model.toDictionary() as NSDictionary)
                    }
                    _ = Tools.shareInstance.showMessage(KWindow, msg: "评论成功", autoHidder: true)
                    self.controller?.dismiss(animated: true, completion: {
                        if self.controller?.reloadDataClouse != nil {
                            self.controller?.reloadDataClouse()
                        }
                    })
                }else{
                    self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
                }
            }
        }
        
        
        
        
    }
    
    func reloadTableView(){
        (self.controller as! CommentPostViewController).tableView.reloadRows(at: [IndexPath.init(row: 0, section: 1)], with: .automatic)
    }
    
}


extension CommentPostViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    // 375 / 247
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return SCREENWIDTH * CommentTextViewCcale
        
        default:
            return PostImageSelectViewHeight + 24
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return SCREENWIDTH * CommentTextViewCcale
            
        default:
            return PostImageSelectViewHeight + 24
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension CommentPostViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostCommentTextTableViewCell.description(), for: indexPath)
            self.tableViewPostCommentTextTableViewCellSetData(indexPath, cell: cell as! PostCommentTextTableViewCell)
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostCommentImagesTableViewCell.description(), for: indexPath)
            self.tableViewPostCommentImagesTableViewCellSetData(indexPath, cell: cell as! PostCommentImagesTableViewCell)
            cell.selectionStyle = .none
            return cell
        }
    }
}
