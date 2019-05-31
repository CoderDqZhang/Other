//
//  ChangePasswordViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class ChangePasswordViewController: BaseViewController {

    var changePasswordViewModel = ChangePasswordViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.setNavigationItemBack()
        self.navigationItem.title = "修改密码"
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: changePasswordViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [GloabelTextFieldAndTitleTableViewCell.self,GloabelConfirmTableViewCell.self], controller: self)
        self.view.backgroundColor = App_Theme_F6F6F6_Color
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
