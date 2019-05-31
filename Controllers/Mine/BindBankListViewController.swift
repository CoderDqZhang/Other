//
//  BindBankListViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

typealias BindBankListViewControllerDeleteClouse = (_ dic:NSDictionary) ->Void
typealias BindBankListViewControllerAddClouse = (_ dic:NSDictionary) ->Void

class BindBankListViewController: BaseViewController {

    var bankListk:NSMutableArray!
    let bankListViewModel = BankListViewModel.init()
    var bindBankListViewControllerDeleteClouse:BindBankListViewControllerDeleteClouse!
    var bindBankListViewControllerAddClouse:BindBankListViewControllerAddClouse!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.setNavigationItemBack()
        self.navigationItem.title = "选择提现账户"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "新增", style: .plain, target: self, action: #selector(self.rightBarItemClick(_:)))
    }
    
    @objc func rightBarItemClick(_ sender:UIBarButtonItem){
        let bindWithVC = BindWithdrawViewController()
        bindWithVC.postDetailDataClouse = { (dic,type) in
            if self.bindBankListViewControllerAddClouse != nil {
                self.bindBankListViewControllerAddClouse(dic)
            }
            self.bankListViewModel.reloadTableViewData()
        }
        NavigationPushView(self, toConroller: bindWithVC)
    }
    
    
    override func setUpView() {
        self.bindViewModel(viewModel: bankListViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [BankTableViewCell.self], controller: self)
    }
    
    override func bindViewModelLogic() {
        self.bankListViewModel.bankListk = self.bankListk
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
