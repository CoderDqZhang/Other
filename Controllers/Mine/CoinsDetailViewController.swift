//
//  CoinsDetailViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/27.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import JXSegmentedView

class CoinsDetailViewController: BaseViewController {

    var coinsViewModel = CoinsViewModel.init()
    var types = [CoinsDetailViewControllerType.all,CoinsDetailViewControllerType.waitpay,CoinsDetailViewControllerType.pay,CoinsDetailViewControllerType.income]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    
    func initSView(type:Int) {
        self.bindViewModel(viewModel: coinsViewModel, controller: self)
        coinsViewModel.type = types[type]
        self.setUpTableView(style: .plain, cells: [CoinsDetailTableViewCell.self], controller: self)
        
        self.setUpRefreshData {
            self.coinsViewModel.page = 0
            self.coinsViewModel.getCoinsDetail()
        }
        
        self.setUpLoadMoreData {
            self.coinsViewModel.getCoinsDetail()
        }
        self.coinsViewModel.getCoinsDetail()
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

extension CoinsDetailViewController : JXSegmentedListContainerViewListDelegate {
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
