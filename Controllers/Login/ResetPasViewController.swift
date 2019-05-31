//
//  ResetPasViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class ResetPasViewController: BaseViewController {

    let resetViewMode = ResetPasViewModel.init()
    
    var phone:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "设置新密码"
        self.setNavigationItemBack()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "确定", style: .plain, target: self, action: #selector(self.rightBarItemClick))
//        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: resetViewMode, controller: self)
        self.setUpTableView(style: .grouped, cells: [GloabelTextFieldButtonTableViewCell.self,GloabelTextFieldAndTitleTableViewCell.self], controller: self)
    
    }
    
    override func bindViewModelLogic() {
        resetViewMode.phone = self.phone
    }
    
    @objc func rightBarItemClick(){
        self.resetViewMode.setNewPassword()
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
