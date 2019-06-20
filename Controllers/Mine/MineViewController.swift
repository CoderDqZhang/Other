//
//  MineViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit


class MineViewController: BaseViewController {

    let mineViewModel = MineViewModel.init()
    
    var gloableNavigationBar:GLoabelNavigaitonBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        if #available(iOS 11.0, *) {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: -NAV_HEIGHT/2, width: SCREENWIDTH, height: 64 + NAV_HEIGHT), title: "个人中心", rightButton: nil, click: { (type) in
                
            })
        } else {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 64), title: "个人中心", rightButton: nil, click: { (type) in
                
            })
            // Fallback on earlier versions
        }
        gloableNavigationBar.hiddenBackButton()

        self.view.addSubview(gloableNavigationBar)
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: mineViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [MineInfoTableViewCell.self, MineToolsTableViewCell.self, AdTableViewCell.self,TitleLableAndDetailLabelDescRight.self], controller: self)
        self.updateTableViewConstraints()
    }
    
    func updateTableViewConstraints() {
        self.tableView.snp.updateConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.snp.top).offset(-NAV_HEIGHT/2)
            } else {
                make.top.equalTo(self.view.snp.top).offset(0)
                // Fallback on earlier versions
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        if CacheManager.getSharedInstance().isLogin() {
            self.mineViewModel.getUserInfoNet(userId: CacheManager.getSharedInstance().getUserInfo()!.id.string)
            self.mineViewModel.getAccountInfoNet(userId: CacheManager.getSharedInstance().getUserInfo()!.id.string)
        }else{
            self.mineViewModel.userInfo = nil
            self.mineViewModel.accountInfo = nil
        }
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
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

