//
//  MycollectViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/20.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class MycollectViewController: BaseViewController {

    var myCollectViewModel = MyCollectViewModel.init()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func setUpView() {
        self.bindViewModel(viewModel: myCollectViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [CategoryContentTableViewCell.self,CommentTableViewCell.self,UserInfoTableViewCell.self], controller: self)
        
        self.setUpRefreshData {
            self.myCollectViewModel.page = 0
            self.myCollectViewModel.getMyCollectNet()
        }
        
        self.setUpLoadMoreData {
            self.myCollectViewModel.getMyCollectNet()
        }
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
