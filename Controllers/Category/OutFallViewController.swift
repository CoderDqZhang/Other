//
//  OutFallViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class OutFallViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        // Do any additional setup after loading the view.
    }
    
    override func setUpView(){
        self.bindViewModel(viewModel: OutFallViewModel(), controller: self)
        self.setUpTableView(style: .grouped, cells: [CommentTableViewCell.self,OutFallCategoryContentTableViewCell.self,OutFallCategoryUserInfoTableViewCell.self], controller: self)
        
        
        self.setUpRefreshData {
            self.stopRefresh()
        }
        
        self.setUpLoadMoreData {
            self.stopLoadMoreData()
        }
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
