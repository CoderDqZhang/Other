//
//  BindPhoneViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class BindPhoneViewController: BaseViewController {

    var bindPhoneViewModel = BindPhoneViewModel.init()
    var openId:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func setUpViewNavigationItem() {
        self.navigationItem.title = "绑定手机"
        self.setNavigationItemBack()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "下一步", style: .plain, target: self, action: #selector(self.rightBarItemClick))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: bindPhoneViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [GloabelTextFieldButtonTableViewCell.self,GloabelTextFieldAndTitleTableViewCell.self], controller: self)
    }
    
    @objc func rightBarItemClick(){
        self.bindPhoneViewModel.bindNetWork(openId: self.openId)
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
