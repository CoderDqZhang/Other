//
//  MyCommentViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/20.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import JXSegmentedView

class MyCommentViewController: BaseViewController {

    let myCommendViewModel = MyCommentViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func initSView(type:Int) {
        self.bindViewModel(viewModel: myCommendViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [MyCommentTableViewCell.self,CommentTableViewCell.self], controller: self)
        
        self.setUpRefreshData {
            self.myCommendViewModel.page = 0
            self.myCommendViewModel.getMyCommentNet()
        }
        
        self.setUpLoadMoreData {
            self.myCommendViewModel.getMyCommentNet()
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

extension MyCommentViewController : JXSegmentedListContainerViewListDelegate {
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
