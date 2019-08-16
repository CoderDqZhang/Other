//
//  SquareViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import JXSegmentedView

class SquareViewController: BaseViewController {

    let squarViewModel = SquareViewModel.init()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initSView(type:Int) {
        self.bindViewModel(viewModel: squarViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [SquareTableViewCell.self], controller: self)
        
        self.setUpRefreshData {
//            self.getNetWorkData()
        }
        
        self.setUpRefreshData {
//            self.getNetWorkData()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

extension SquareViewController : JXSegmentedListContainerViewListDelegate {
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
