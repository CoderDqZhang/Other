//
//  PostViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/24.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import YYImage
import YYWebImage

class PostViewModel: BaseViewModel,UIImagePickerControllerDelegate {
    
    var selectPhotos:NSMutableArray = NSMutableArray.init()
    var selectAssets:NSMutableArray = NSMutableArray.init()
    var isSelectOriginalPhoto:Bool!
    var contentText = NSMutableAttributedString.init()
    
    var postModel = CacheManager.getSharedInstance().getPostModel() ?? PostModel.init(fromDictionary: ["content":"","title":""])
    
    override init() {
        super.init()
    }
    
    func tableViewPostCommentImagesTableViewCellSetData(_ indexPath:IndexPath, cell:PostCommentImagesTableViewCell){
        cell.cellSetData(images: selectPhotos)
        cell.postCommentImageAddButtonClouse = { btn in
            (self.controller as! PostViewController).setUpAlerViewController()
        }
        cell.postCommentImageImageButtonClouse = { tag in
            (self.controller as! PostViewController).setUpPrewImagePickerBrowser(index: tag)
        }
    }
    
    func tableViewPostCommentTextTableViewCellSetData(_ indexPath:IndexPath, cell:PostCommentTextTableViewCell) {
        if self.postModel.content != nil {
            cell.textView.text = self.postModel.content
        }
        
        cell.postCommentTextTableViewCellTextClouse = { (str) in
            self.postModel.content = str
        }
    }
    
    func tableViewGloabelTextFieldTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelTextFieldTableViewCell) {
        cell.cellSetData(placeholder: "请填写标题")
        if self.postModel.title != nil {
            cell.textFiled.text = self.postModel.title
        }
        cell.textFiled.reactive.continuousTextValues.observeValues { (str) in
            self.postModel.title = str
        }
        cell.hiddenLineLabel()
    }
    
    func tableViewGloabelTextFieldAndTitleTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelTextFieldAndTitleTableViewCell) {
        cell.cellSetData(title: "选择部落", placeholder: "请选择一个部落发布")
        if self.postModel.tribe != nil {
            cell.textFiled.text = self.postModel.tribe.tribeName
        }
        cell.textFiled.isEnabled = false
        cell.hiddenLineLabel()
        if self.postModel.tribe != nil {
            cell.textFiled.text = self.postModel.tribe.tribeName
        }
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        if indexPath.section == 0 {
            let categoryChoosVC = CategoryChoosViewController()
            categoryChoosVC.categoryChoosViewControllerClouse = { dic in
                self.postModel.tribe = CategoryModel.init(fromDictionary: dic as! [String : Any])
                //保存到本地
                CacheManager.getSharedInstance().saveNormaltModel(category: self.postModel.tribe)
                self.reloadTableViewData()
            }
            NavigationPushView(self.controller!, toConroller: categoryChoosVC)
        }
    }
    
    func postTirbeNet(){
        if self.selectPhotos.count > 0 {
            AliPayManager.getSharedInstance().uploadFile(images: self.selectPhotos, type: .post) { imgs,strs  in
                let parameters = ["content":self.postModel.content == nil ? "" : self.postModel.content!, "title":self.postModel.title!, "tribeId":self.postModel.tribe.id.string,"image":strs] as [String : Any]
                BaseNetWorke.getSharedInstance().postUrlWithString(TippublishTipUrl, parameters: parameters as AnyObject).observe { (resultDic) in
                    if !resultDic.isCompleted {
                        let model = TipModel.init(fromDictionary: resultDic.value as! [String : Any])
                        if (self.controller as! PostViewController).postViewControllerDataClouse != nil {
                            (self.controller as! PostViewController).postViewControllerDataClouse(model.toDictionary() as NSDictionary)
                        }
                        _ = Tools.shareInstance.showMessage(KWindow, msg: "发帖成功", autoHidder: true)
                        self.controller?.dismiss(animated: true, completion: {
                            CacheManager.getSharedInstance().removePostModel()
                        })
                    }else{
                        self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
                    }
                }
            }
            
        }else{
            let parameters = ["content":self.postModel.content == nil ? "" : self.postModel.content!, "title":self.postModel.title!, "tribeId":self.postModel.tribe.id.string,"image":""] as [String : Any]
            BaseNetWorke.getSharedInstance().postUrlWithString(TippublishTipUrl, parameters: parameters as AnyObject).observe { (resultDic) in
                if !resultDic.isCompleted {
                    let model = TipModel.init(fromDictionary: resultDic.value as! [String : Any])
                    if (self.controller as! PostViewController).postViewControllerDataClouse != nil {
                        (self.controller as! PostViewController).postViewControllerDataClouse(model.toDictionary() as NSDictionary)
                    }
                    _ = Tools.shareInstance.showMessage(KWindow, msg: "发帖成功", autoHidder: true)
                    self.controller?.dismiss(animated: true, completion: {
                        CacheManager.getSharedInstance().removePostModel()
                    })
                }else{
                    self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
                }
            }
        }
    }
    
    
    func reloadTableView(){
//        self.contentText.append(NSAttributedString.init(string: self.postModel.content, attributes: nil))
//        for img in self.selectPhotos {
//            let imageView = YYAnimatedImageView.init(image: img)
//            imageView.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH - 30, height: (SCREENWIDTH - 30) * img.size.height / img.size.width )
//            let attachText = NSMutableAttributedString.yy_attachmentString(withContent: imageView, contentMode: .center, width: 30, ascent: 1, descent: 1)
//            self.contentText.append(attachText)
//        }
//        self.reloadTableViewData()
        (self.controller as! PostViewController).tableView.reloadRows(at: [IndexPath.init(row: 0, section: 3)], with: .automatic)
    }    
}


extension PostViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 4
    }
    
    // 375 / 247
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 74
        case 1:
            return 44
        case 2:
            return SCREENWIDTH * CommentTextViewCcale
        default:
            return PostImageSelectViewHeight + 24
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 74
        case 1:
            return 44
        case 2:
            return SCREENWIDTH * CommentTextViewCcale
            
        default:
            return PostImageSelectViewHeight + 24
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension PostViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: GloabelTextFieldAndTitleTableViewCell.description(), for: indexPath)
            self.tableViewGloabelTextFieldAndTitleTableViewCellSetData(indexPath, cell: cell as! GloabelTextFieldAndTitleTableViewCell)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: GloabelTextFieldTableViewCell.description(), for: indexPath)
            self.tableViewGloabelTextFieldTableViewCellSetData(indexPath, cell: cell as! GloabelTextFieldTableViewCell)
            cell.selectionStyle = .none
            return cell
        case 2:
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
