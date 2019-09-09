//
//  NotificationViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import JXSegmentedView

typealias NotificationViewControllerReloadClouse = (_ index:Int) ->Void

class NotificationViewController: BaseViewController {

    let notificationViewModel = NotificationViewModel.init()
    var types = [NotificationType.system,NotificationType.comment,NotificationType.commentMe,NotificationType.approve]
    var unreadModel:UnreadMessageModel!
    
    var notificationViewControllerReloadClouse:NotificationViewControllerReloadClouse!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func initSView(type:Int) {
        self.bindViewModel(viewModel: notificationViewModel, controller: self)
        notificationViewModel.type = types[type]
        self.setUpTableView(style: .grouped, cells: [NotificationTableViewCell.self], controller: self)
        
        self.setUpRefreshData {
            self.notificationViewModel.page = 0
            self.notificationViewModel.notificationNet()
        }
        
        self.setUpLoadMoreDataClouse = {
            self.setUpLoadMoreData {
                self.notificationViewModel.notificationNet()
            }
        }
        
        self.notificationViewModel.notificationNet()
    }
    
    override func bindViewModelLogic() {
        self.notificationViewModel.unreadModel = self.unreadModel
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

extension NotificationViewController : JXSegmentedListContainerViewListDelegate {
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



