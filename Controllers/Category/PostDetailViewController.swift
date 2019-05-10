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
        
        self.setUpRefreshData {
            
        }
        
        self.setUpLoadMoreData {
            
        }
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
