//
//  NewsViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import JXSegmentedView

class NewsViewController: BaseViewController {

    
    var categoryDetailClouse:CategoryDetailDataClouse!
    
    let newsViewModel = NewsViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func initSView(type:Int) {
        self.bindViewModel(viewModel: newsViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [CategoryTableViewCell.self,CategoryContentTableViewCell.self,HotDetailTableViewCell.self,CommentTableViewCell.self,UserInfoTableViewCell.self], controller: self)
        
        
        self.setUpRefreshData {
            self.newsViewModel.page = 0
            self.newsViewModel.getTribeListNet()
        }
        
        self.setUpLoadMoreData {
            self.newsViewModel.getTribeListNet()
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

extension NewsViewController : JXSegmentedListContainerViewListDelegate {
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
