//
//  BasKetBallViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import JXSegmentedView

class BasKetBallViewController: BaseViewController {

    let basketBallViewModel = BasketBallViewModel.init()

    var viewType:ScoreDetailVC!
    var viewDesc:ScoreDetailTypeVC!
    
    var dateTime:String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func initSView(type:Int, titles:String?) {
        self.bindViewModel(viewModel: basketBallViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [BasketBallTableViewCell.self,AdTableViewCell.self], controller: self)
        if titles != nil {
            dateTime = titles
        }
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.bindLogic()
            DispatchQueue.main.async {
                self.setUpRefreshData {
                    self.refreshData()
                }
            }
        }
    }
    
    func bindLogic() {
        self.basketBallViewModel.viewType = self.viewType
        self.basketBallViewModel.viewDesc = self.viewDesc
        if self.viewDesc != .attention{
            self.getNetWorkData()
        }else{
            self.basketBallViewModel.filterArray()
        }
        if self.viewDesc == .timely || self.viewDesc == .underway || self.viewDesc == .attention{
            self.basketBallViewModel.socketData()
        }
        if self.viewDesc != .amidithion {
            NotificationCenter.default.addObserver(self.basketBallViewModel, selector: #selector(self.basketBallViewModel.filterArray), name: NSNotification.Name.init(RELOADCOLLECTRBASKETBALLMODEL), object: nil)
            //进入后台后重新进入刷新数据
            NotificationCenter.default.addObserver(self, selector: #selector(self.refreshData), name: NSNotification.Name.init(RELOADBASKETBALLENTERACTIVE), object: nil)
        }
    }
    
    @objc func getNetWorkData(){
        var date:String!
        if self.viewDesc == .underway || self.viewDesc == .timely{
            date = Date.init().string(withFormat: "yyyyMMdd")
        }else{
            date = DateTools.getSharedInstance().getDateTime(str: self.dateTime)
        }
        //            self.footBallViewModel.getFoot1BallNet(date: date)
        self.basketBallViewModel.getBasketInfoBallNet(type:self.viewDesc.rawValue.string, date: date)
    }
    
    @objc func refreshData(){
        if self.viewDesc != .attention {
            self.getNetWorkData()
        }else{
            self.basketBallViewModel.filterArray()
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

extension BasKetBallViewController : JXSegmentedListContainerViewListDelegate {
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
