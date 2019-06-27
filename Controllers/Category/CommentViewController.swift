//
//  CommentViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class CommentViewController: BaseViewController {

    var commentData:CommentModel!
    
    var commentDetailViewModel = CommentViewModel.init()
    
    var gloableCommentView:CustomViewCommentTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: commentDetailViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [PostDetailCommentUserTableViewCell.self,PostDetailCommentTableViewCell.self], controller: self)
        
        
        self.setUpRefreshData {
            self.commentDetailViewModel.page = 0
            self.commentDetailViewModel.getReplitList()
        }
        
        self.setUpLoadMoreData {
            self.commentDetailViewModel.getReplitList()
        }
        
        if #available(iOS 11.0, *) {
            gloableCommentView = CustomViewCommentTextField.init(frame: CGRect.init(x: 0, y:SCREENHEIGHT - 64 - 44 - 49 - 2, width: SCREENWIDTH, height: 44 + TABBAR_HEIGHT), placeholderString: "留下你的精彩评论...",isEdit:true, click: {
                
            }, senderClick: { str in
                self.commentDetailViewModel.content = str
            })
        } else {
            gloableCommentView = CustomViewCommentTextField.init(frame: CGRect.init(x: 0, y: self.tableView.frame.maxY, width: SCREENWIDTH, height: 44), placeholderString: "留下你的精彩评论...",isEdit:true,  click: {
                
            }, senderClick: { str in
                self.commentDetailViewModel.content = str
            })
            // Fallback on earlier versions
        }
        gloableCommentView.customViewCommentTextFieldSenderClick = { str in
            if !CacheManager.getSharedInstance().isLogin() {
                NavigationPushView(self, toConroller: LoginViewController())
                return
            }
            self.commentDetailViewModel.setUpReplit(content: str)
        }
        gloableCommentView.backgroundColor = .white
        self.view.addSubview(gloableCommentView)
        
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
    
    override func bindViewModelLogic() {
        commentDetailViewModel.commentData = commentData
        commentDetailViewModel.getReplitList()
    }
    
    override func setUpViewNavigationItem() {
        self.setNavigationItemBack()
        self.navigationItem.title = "查看回复"
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
