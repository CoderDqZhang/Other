//
//  PostViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class PostViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    override func setUpViewNavigationItem(){
        self.viewControllerSetNavigationItemBack()
        self.navigationController?.title = "发表帖子"
    }
    
    override func setUpView(){
        self.setUpTableView(style: UITableView.Style.plain, cells: [CategoryTableViewCell.self,CategoryContentTableViewCell.self,HotDetailTableViewCell.self,CommentTableViewCell.self], controller: self)
        self.bindViewModel(viewModel: NewsViewModel(), controller: self)
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
