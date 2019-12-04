//
//  ShieldViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/11/18.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class ShieldViewController: BaseViewController {

    let shieldViewModel = ShieldViewModel.init()
    var userId:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.setNavigationItemBack()
        self.navigationItem.title = "用户屏蔽"
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: shieldViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [ShieldTableViewCell.self], controller: self)
        self.tableView.backgroundColor = App_Theme_F6F6F6_Color
        
        self.setUpRefreshData {
            self.shieldViewModel.page = 0
            self.shieldViewModel.getShieldNet()
        }
        self.setUpLoadMoreDataClouse = {
            self.setUpLoadMoreData {
                self.shieldViewModel.getShieldNet()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
