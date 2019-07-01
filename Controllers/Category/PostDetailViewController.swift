//
//  PostDetailViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

enum ToatalNumber {
    case comment
    case like
}

enum ToolsStatus {
    case add
    case delete
}

enum PostDetaiGoToType {
    case comment
    case detail
}

typealias ChangeFansFollowButtonStatusClouse = (_ status:Bool) ->Void

typealias ChangeAllCommentAndLikeNumberClouse = (_ type:ToatalNumber, _ status:ToolsStatus) ->Void

class PostDetailViewController: BaseViewController {

    var postType:PostType!
    var gotoType:PostDetaiGoToType!
    
    var postData:NSDictionary!
    var postDetailViewModel = PostDetailViewModel.init()
    
    var gloableCommentView:CustomViewCommentTextField!
    
    var changeFansFollowButtonStatusClouse:ChangeFansFollowButtonStatusClouse!
    var changeAllCommentAndLikeNumberClouse:ChangeAllCommentAndLikeNumberClouse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: postDetailViewModel, controller: self)
        self.postDetailViewModel.postType = self.postType
        self.setUpTableView(style: .grouped, cells: [PostDetailUserInfoTableViewCell.self,PostDetailCommentTableViewCell.self,PostDetailCommentUserTableViewCell.self,PostDetailContentTableViewCell.self,HotDetailTableViewCell.self], controller: self)

        self.updateTableViewConstraints()

        self.setUpRefreshData {
            self.refreshData()
        }

        self.setUpLoadMoreData {
            self.postDetailViewModel.getComments(id: (self.postData.object(forKey: "id") as! Int).string)
        }
        
        if #available(iOS 11.0, *) {
            gloableCommentView = CustomViewCommentTextField.init(frame: CGRect.init(x: 0, y:SCREENHEIGHT - 44 - TABBAR_HEIGHT, width: SCREENWIDTH, height: 44 + TABBAR_HEIGHT), placeholderString: "留下你的精彩评论...",isEdit:false, click: {
                let commentVC = CommentPostViewController()
                let commentPost = UINavigationController.init(rootViewController: commentVC)
                commentVC.postData = self.postData
                commentVC.reloadDataClouse = {

                    self.refreshData()
                }
                if self.changeAllCommentAndLikeNumberClouse != nil {
                    self.changeAllCommentAndLikeNumberClouse(.comment, .add)
                }
                NavigaiontPresentView(self, toController: commentPost)
            }, senderClick: { str in
                
            })
            
        } else {
            gloableCommentView = CustomViewCommentTextField.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 44, width: SCREENWIDTH, height: 44), placeholderString: "留下你的精彩评论...",isEdit:false, click: {
                let commentVC = CommentPostViewController()
                let commentPost = UINavigationController.init(rootViewController: commentVC)
                commentVC.postData = self.postData
                commentVC.reloadDataClouse = {
                    self.refreshData()
                }
                if self.changeAllCommentAndLikeNumberClouse != nil {
                    self.changeAllCommentAndLikeNumberClouse(.comment, .add)
                }
                NavigaiontPresentView(self, toController: commentPost)
            }, senderClick: { str in
                
            })
            
            // Fallback on earlier versions
        }
        self.view.addSubview(gloableCommentView)

        gloableCommentView.textView.isEditable = false
        gloableCommentView.backgroundColor = .white
        gloableCommentView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.height.equalTo(44 + TABBAR_HEIGHT)
            } else {
                make.height.equalTo(44)
                // Fallback on earlier versions
            }
            make.bottom.equalToSuperview()
        }
    }
    
    func refreshData(){
        self.postDetailViewModel.page = 0
        self.postDetailViewModel.tipDetailModel.commentTotal = self.postDetailViewModel.tipDetailModel.commentTotal + 1
        self.postDetailViewModel.getComments(id: (self.postData.object(forKey: "id") as! Int).string)
    }
    
    func updateTableViewConstraints() {
        self.tableView.snp.updateConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(-44)
        }
    }
    
    override func bindViewModelLogic() {
        self.postDetailViewModel.getTipDetail(id: (self.postData.object(forKey: "id") as! Int).string)
        self.postDetailViewModel.getComments(id: (self.postData.object(forKey: "id") as! Int).string)
        
    }
    
    override func setUpViewNavigationItem() {
        self.setNavigationItemBack()
//        self.navigationItem.title = ((self.postData.object(forKey: "tribe") as! NSDictionary).object(forKey: "tribeName") as! String)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "post_detail_share")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.rightBarItemClick(_:)))
    }
    
    @objc func rightBarItemClick(_ sender:UIBarButtonItem) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
