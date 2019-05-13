//
//  PostDetailViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class PostDetailViewController: BaseViewController {

    var postType:PostType!
    var postData:NSDictionary!
    var postDetailViewModel = PostDetailViewModel()
    
    var gloableCommentView:CustomViewCommentTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavigationItemBack()
        // Do any additional setup after loading the view.
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: postDetailViewModel, controller: self)
        self.postDetailViewModel.postType = self.postType
        self.postDetailViewModel.postData = self.postData
        self.setUpTableView(style: .grouped, cells: [PostDetailUserInfoTableViewCell.self,PostDetailCommentTableViewCell.self,PostDetailCommentUserTableViewCell.self,PostDetailContentTableViewCell.self,HotDetailTableViewCell.self], controller: self)

        self.updateTableViewConstraints()

        self.setUpRefreshData {

        }

        self.setUpLoadMoreData {

        }
        
        if #available(iOS 11.0, *) {
            gloableCommentView = CustomViewCommentTextField.init(frame: CGRect.init(x: 0, y:SCREENHEIGHT - 64 - 44 - 49, width: SCREENWIDTH, height: 44 + TABBAR_HEIGHT), placeholderString: "留下你的精彩评论...", click: {
                let commentPost = UINavigationController.init(rootViewController: CommentPostViewController())
                NavigaiontPresentView(self, toController: commentPost)
            })
        } else {
            gloableCommentView = CustomViewCommentTextField.init(frame: CGRect.init(x: 0, y: self.tableView.frame.maxY, width: SCREENWIDTH, height: 44), placeholderString: "留下你的精彩评论...", click: {
                let commentPost = UINavigationController.init(rootViewController: CommentPostViewController())
                NavigaiontPresentView(self, toController: commentPost)
            })
            // Fallback on earlier versions
        }
        gloableCommentView.textField.isEnabled = false
        gloableCommentView.backgroundColor = .white
        self.view.addSubview(gloableCommentView)
    }
    
    func updateTableViewConstraints() {
        self.tableView.snp.updateConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(-44)
        }
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "post_detail_share"), style: .plain, target: self, action: #selector(self.rightBarItemClick(_:)))
    }
    
    @objc func rightBarItemClick(_ sender:UIBarButtonItem) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewControllerSetNavigationItemBack() {
        self.navigationItem.title = "皇家马德里"
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
