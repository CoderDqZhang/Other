//
//  OutFallViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import JXSegmentedView

class OutFallViewController: BaseViewController {

    let outFallViewModel = OutFallViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpView(){
        
    }
    
    func initSView(type:Int) {
        self.bindViewModel(viewModel: outFallViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [CommentTableViewCell.self,OutFallCategoryContentTableViewCell.self,OutFallCategoryUserInfoTableViewCell.self], controller: self)
        
        
        self.setUpRefreshData {
            self.outFallViewModel.page = 0
            self.outFallViewModel.getTribeListNet()
        }
        
        self.setUpLoadMoreDataClouse = {
            self.setUpLoadMoreData {
                self.outFallViewModel.getTribeListNet()
            }
        }
        
    }
}

extension OutFallViewController : JXSegmentedListContainerViewListDelegate {
    override func listView() -> UIView {
        return view
    }
    
    override func listDidAppear() {
        print("listDidAppear")
    }
    
    override func listDidDisappear() {
        print("listDidDisappear")
    }
}
