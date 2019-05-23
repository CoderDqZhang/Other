//
//  BaseViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class BaseViewModel: NSObject {

    var controller:BaseViewController?
    var resultData:NSMutableArray!
    
    override init() {
        super.init()
    }
    
    func reloadTableViewData(){
        self.controller?.tableView.reloadData()
    }
}
