//
//  StoreViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/27.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class StoreViewController: BaseViewController {

    let storeViewModel = StoreViewModel.init()
    
    var types = [StoreDetailTyp.all,StoreDetailTyp.income,StoreDetailTyp.pay]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    func initSView(type:Int) {
        self.bindViewModel(viewModel: storeViewModel, controller: self)
        storeViewModel.type = types[type]
        self.setUpTableView(style: .grouped, cells: [CoinsDetailTableViewCell.self], controller: self)
        
        self.setUpRefreshData {
            self.storeViewModel.page = 0
            self.storeViewModel.getStoreNet()
        }
        
        self.setUpLoadMoreDataClouse = {
            self.setUpLoadMoreData {
                self.storeViewModel.getStoreNet()
            }
        }
        
        self.storeViewModel.getStoreNet()
    }

}
