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
    
    func getControllerView() -> UIView{
        return self.controller!.view
    }
    
    func reloadTableViewData(){
        self.controller?.tableView.reloadData()
    }
    
    func hiddenMJLoadMoreData(resultData:Any){
        if self.controller?.tableView != nil {
            if resultData is NSDictionary {
                let pageModel = PageModel.init(fromDictionary: resultData as! [String : Any])
                if pageModel.current != nil && pageModel.current == pageModel.pages {
                    if self.controller?.tableView.mj_footer != nil {
                        self.controller?.tableView.mj_footer.endRefreshingWithNoMoreData()
                    }
                }else{
                    self.controller?.stopRefresh()
                }
            }else{
                self.controller?.stopRefresh()
            }
        }
    }
    
    //滑动到指定距离
    func tableViewScrollToPoint(_ point:CGPoint?, _ indexPath:IndexPath?){
        if indexPath != nil {
            self.controller?.tableView.scrollToRow(at: indexPath!, at: UITableView.ScrollPosition.top, animated: true)
        }
        
        if point != nil {
            self.controller?.tableView.setContentOffset(point!, animated: true)
        }
    }
}
