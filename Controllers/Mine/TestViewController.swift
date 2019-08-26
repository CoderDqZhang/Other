//
//  TestViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/26.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class TestViewController: BaseViewController {

    var otherPostViewModel = OtherPostViewModel.init()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    
    func initSView(dic:NSDictionary) {
        self.bindViewModel(viewModel: otherPostViewModel, controller: self)
        self.otherPostViewModel.userInfo = UserInfoModel.init(fromDictionary: dic as! [String : Any])
        self.setUpTableView(style: .grouped, cells: [CategoryContentTableViewCell.self,CommentTableViewCell.self,UserInfoTableViewCell.self], controller: self)
        
        self.otherPostViewModel.getMyPostNet()
        
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
