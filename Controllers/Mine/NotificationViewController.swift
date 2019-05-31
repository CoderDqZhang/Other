//
//  NotificationViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class NotificationViewController: BaseViewController {

    let notificationViewModel = NotificationViewModel.init()
    var types = [NotificationType.system,NotificationType.comment,NotificationType.commentMe,NotificationType.approve]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func initSView(type:Int) {
        self.bindViewModel(viewModel: notificationViewModel, controller: self)
        notificationViewModel.type = types[type]
        self.setUpTableView(style: .plain, cells: [NotificationTableViewCell.self], controller: self)
        
        self.setUpRefreshData {
            self.notificationViewModel.page = 0
            self.notificationViewModel.notificationNet()
        }
        
        self.setUpLoadMoreData {
            self.notificationViewModel.notificationNet()
        }
        self.notificationViewModel.notificationNet()
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
