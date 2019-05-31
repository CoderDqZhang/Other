//
//  BindWithdrawViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/30.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class BindWithdrawViewController: BaseViewController {

    let bindwithDraw = BindDrawViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "绑定账户"
        self.setNavigationItemBack()
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: bindwithDraw, controller: self)
        self.setUpTableView(style: .grouped, cells: [GloabelTextFieldAndTitleTableViewCell.self,GloabelTextFieldButtonTableViewCell.self,GloabelConfirmTableViewCell.self,AccountTypeTableViewCell.self], controller: self)
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
