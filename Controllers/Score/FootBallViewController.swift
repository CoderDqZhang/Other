//
//  FootBallViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import JXSegmentedView

enum FootBallType:Int {
    case all = 0
    case ing = 1
    case competions = 2
    case result = 3
}

class FootBallViewController: BaseViewController {

    let footBallViewModel = FootBallViewModel.init()
    
    var viewType:ScoreDetailVC!
    var viewDesc:ScoreDetailTypeVC!
    var dateTime:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func initSView(type:Int, titles:String?) {
        self.bindViewModel(viewModel: footBallViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [ScoreInfoTableViewCell.self,ScoreListTableViewCell.self], controller: self)
        if titles != nil {
            dateTime = titles
        }
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.bindLogic()
            self.setUpRefreshData {
                self.refreshData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func bindLogic() {
        self.footBallViewModel.viewType = self.viewType
        self.footBallViewModel.viewDesc = self.viewDesc
        if self.viewDesc != .attention{
            self.getNetWorkData()
        }else{
            self.footBallViewModel.filterArray()
        }
        if self.viewDesc == .timely || self.viewDesc == .underway{
            self.footBallViewModel.socketData()
        }
        
        if self.viewDesc != .amidithion {
            NotificationCenter.default.addObserver(self.footBallViewModel, selector: #selector(self.footBallViewModel.filterArray), name: NSNotification.Name.init(RELOADCOLLECTFOOTBALLMODEL), object: nil)
        }
    }
    
    func getNetWorkData(){
        var date:String!
        if self.viewDesc == .underway || self.viewDesc == .timely {
            date = Date.init().string(withFormat: "yyyyMMdd")
        }else{
            date = DateTools.getSharedInstance().getDateTime(str: self.dateTime)
        }
        self.footBallViewModel.getFootInfoBallNet(type:self.viewDesc.rawValue.string, date: date)
    }
    
    func refreshData(){
        if self.viewDesc != .attention {
            self.getNetWorkData()
        }else{
            self.footBallViewModel.filterArray()
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
