//
//  OtherGuessViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/29.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class OtherGuessViewController: BaseViewController {

    let otherGuessViewModel = OtherGuessingViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func initSView(dic:NSDictionary) {
        self.bindViewModel(viewModel: otherGuessViewModel, controller: self)
        self.otherGuessViewModel.userInfo = UserInfoModel.init(fromDictionary: dic as! [String : Any])
        self.setUpTableView(style: .grouped, cells: [CategoryContentTableViewCell.self,CommentTableViewCell.self,UserInfoTableViewCell.self], controller: self)
        
        self.setUpRefreshData {
            
        }
        
        self.setUpLoadMoreData {
            
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
