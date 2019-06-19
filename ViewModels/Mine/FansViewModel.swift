//
//  FansViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class FansViewModel: BaseViewModel {
    
    var page = 0
    var fansArray = NSMutableArray.init()
    var userId:String?
    override init() {
        super.init()
    }
    
    func tableViewGloabelFansTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelFansTableViewCell) {
        cell.cellSetData(model: FansFlowwerModel.init(fromDictionary: fansArray[indexPath.row] as! [String : Any]), indexPath: indexPath)
        if indexPath.row == 9 {
            cell.lineLableHidden()
        }
        cell.gloabelFansTableViewCellClouse = { type, indexPath in
            self.followNet(type: type, indexPath: indexPath)
        }
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        let dic:NSDictionary = FansFlowwerModel.init(fromDictionary: self.fansArray[indexPath.row] as! [String : Any]).toDictionary() as NSDictionary
        let otherMineVC = OtherMineViewController()
        otherMineVC.postData = dic
        otherMineVC.otherMineViewControlerReloadFansButtonClouse = { status in
            self.page = 0
            self.getFansNet(userId: self.userId)
        }
        NavigationPushView(self.controller!, toConroller: otherMineVC)
    }
    
    func getFansNet(userId:String?){
        page = page + 1
        var parameters:[String : Any]?
        if userId == nil {
            parameters = ["page":page.string, "limit":LIMITNUMBER] as [String : Any]
        }else{
            parameters = ["page":page.string, "limit":LIMITNUMBER,"userId":userId!] as [String : Any]

        }
        BaseNetWorke.getSharedInstance().postUrlWithString(PersonmyFansUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if self.page != 1 {
                    self.fansArray.addObjects(from: NSMutableArray.init(array: resultDic.value as! Array) as! [Any])
                }else{
                    self.fansArray = NSMutableArray.init(array: resultDic.value as! Array)
                }
                self.reloadTableViewData()
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func followNet(type:GloabelButtonType, indexPath:IndexPath){
        let model = FansFlowwerModel.init(fromDictionary: fansArray[indexPath.row] as! [String : Any])
        let parameters = ["userId":model.id!.string]
        BaseNetWorke.getSharedInstance().postUrlWithString(PersonfollowUserUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "操作成功", autoHidder: true)
                if type == .select {
                    self.reloadTalbeViewData(indexPath: indexPath)
                }
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func reloadTalbeViewData(indexPath:IndexPath){
//        self.fansArray.removeObject(at: indexPath.row)
//        self.controller?.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}


extension FansViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension FansViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fansArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GloabelFansTableViewCell.description(), for: indexPath)
        self.tableViewGloabelFansTableViewCellSetData(indexPath, cell: cell as! GloabelFansTableViewCell)
        cell.selectionStyle = .none
        return cell
    }
}

extension FansViewModel : DZNEmptyDataSetDelegate {
    
}

extension FansViewModel : DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributed = "暂时还没有数据哦！"
        let attributedString = NSMutableAttributedString.init(string: attributed)
        attributedString.addAttributes([NSAttributedString.Key.font:App_Theme_PinFan_M_16_Font!,NSAttributedString.Key.foregroundColor:App_Theme_CCCCCC_Color!], range: NSRange.init(location: 0, length: 9))
        
        return attributedString
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "pic_toy")
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -64
    }
}
