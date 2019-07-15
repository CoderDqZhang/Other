//
//  RecommendViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/20.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class RecommendViewController: BaseViewController {

    let recommendViewModel = RecommendViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func initSView(dic:NSDictionary) {
        self.bindViewModel(viewModel: recommendViewModel, controller: self)
        self.recommendViewModel.userInfo = UserInfoModel.init(fromDictionary: dic as! [String : Any])
        self.setUpTableView(style: .grouped, cells: [CategoryContentTableViewCell.self,CommentTableViewCell.self,UserInfoTableViewCell.self], controller: self)
        
        self.setUpRefreshData {
            
        }
        
        self.setUpLoadMoreDataClouse = {
            self.setUpLoadMoreData {
            
            }
        }
    }
    
    
//    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
//        
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



