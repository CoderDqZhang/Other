//
//  FindPasViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class FindPasViewController: BaseViewController {

    var findViewModel = FindViewModel.init()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "找回密码"
        self.setNavigationItemBack()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "下一步", style: .plain, target: self, action: #selector(self.rightBarItemClick))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: findViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [GloabelTextFieldButtonTableViewCell.self,GloabelTextFieldTableViewCell.self], controller: self)
    }

    @objc func rightBarItemClick(){
        NavigationPushView(self, toConroller: ResetPasViewController())
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
