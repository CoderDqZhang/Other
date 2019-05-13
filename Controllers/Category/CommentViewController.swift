//
//  CommentViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class CommentViewController: BaseViewController {

    var commentData:NSDictionary!
    var commentList:[SecondeModel]!
    
    var commentDetailViewModel = CommentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: commentDetailViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [PostDetailCommentUserTableViewCell.self,PostDetailCommentTableViewCell.self], controller: self)
    }
    
    override func bindViewModelLogic() {
        commentDetailViewModel.commentData = commentData
        commentDetailViewModel.commentList = commentList
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
