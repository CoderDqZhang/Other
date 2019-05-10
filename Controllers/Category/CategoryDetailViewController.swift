//
//  CategoryDetailViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class CategoryDetailViewController: BaseViewController {

    var categoryData:NSDictionary!
    var categoryType:CategoryType!
    
    var gloableNavigationBar:GLoabelNavigaitonBar!
    var categoryViewModel = CategoryDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        if #available(iOS 11.0, *) {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: -NAV_HEIGHT/2, width: SCREENWIDTH, height: 64 + NAV_HEIGHT), title: "皇家马德里", rightButton: nil, click: { (type) in
                if type == .backBtn {
                    self.navigationController?.popViewController()
                }
            })
        } else {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 64), title: "皇家马德里", rightButton: nil, click: { (type) in
                if type == .backBtn {
                    self.navigationController?.popViewController()
                }
            })
            // Fallback on earlier versions
        }
        self.view.addSubview(gloableNavigationBar)
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: categoryViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [CategoryContentTableViewCell.self,CommentTableViewCell.self,CategoryHeaderTableViewCell.self,UserInfoTableViewCell.self], controller: self)
        self.updateTableViewConstraints()
        
        self.setUpLoadMoreData {
            
        }
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
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
