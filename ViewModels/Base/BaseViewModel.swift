//
//  BaseViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import MJRefresh

class BaseViewModel: NSObject {

    var controller:BaseViewController?
    var resultData:NSMutableArray!
    
    override init() {
        super.init()
    }
    
    func reloadTableViewData(){
        self.controller?.tableView.reloadData()
    }
    
    func hiddenMJLoadMoreData(resultData:Any){
        if (resultData as! Array<Any>).capacity < LIMITNUMBER.int! {
            self.controller?.tableView.mj_footer.endRefreshingWithNoMoreData()
            if self.controller?.tableView.mj_header != nil {
                self.controller?.tableView.mj_header.endRefreshing()
            }
        }else{
            self.controller?.stopRefresh()
        }
    }
}
