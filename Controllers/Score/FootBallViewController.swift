//
//  FootBallViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import JXSegmentedView

class FootBallViewController: BaseViewController {

    let footBallViewModel = FootBallViewModel.init()
    
    var viewType:ScoreDetailVC!
    var viewDesc:ScoreDetailTypeVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func initSView(type:Int) {
        self.bindViewModel(viewModel: footBallViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [ScoreInfoTableViewCell.self,ScoreListTableViewCell.self], controller: self)
        
    }
    
    override func bindViewModelLogic() {
        self.footBallViewModel.viewType = self.viewType
        self.footBallViewModel.viewDesc = self.viewDesc
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

extension FootBallViewController : JXSegmentedListContainerViewListDelegate {
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
