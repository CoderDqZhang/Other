//
//  RealNameViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class RealNameViewController: BaseViewController {

    var realNameViewMode = RealNameViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func setUpViewNavigationItem() {
        self.setNavigationItemBack()
        self.navigationItem.title = "实名认证"
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: realNameViewMode, controller: self)
        self.setUpTableView(style: .grouped, cells: [GloabelTextFieldTableViewCell.self,GloabelConfirmTableViewCell.self], controller: self)
        self.view.backgroundColor = App_Theme_F6F6F6_Color
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
