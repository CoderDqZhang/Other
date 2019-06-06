//
//  NotificationViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class NotificationViewModel: BaseViewModel {

    var type:NotificationType!
    
    var detailArray = NSMutableArray.init()
    var page:Int = 0
    override init() {
        super.init()
    }
    
    
    func tableViewNotificationTableViewCellSetData(_ indexPath:IndexPath, cell:NotificationTableViewCell) {
        cell.cellSetData(model: NotificaitonModel.init(fromDictionary: self.detailArray[indexPath.section] as! [String : Any]))
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
    
    func notificationNet(){
        page = page + 1
        let parameters = ["page":page.string, "limit":LIMITNUMBER, "type":self.type.rawValue] as [String : Any]
        BaseNetWorke.sharedInstance.postUrlWithString(NotificationDetailUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
                if self.page != 1 {
                    self.detailArray.addObjects(from: NSMutableArray.init(array: resultDic.value as! Array) as! [Any])
                }else{
                    self.detailArray = NSMutableArray.init(array: resultDic.value as! Array)
                }
                self.reloadTableViewData()
                self.controller?.stopRefresh()
            }
        }
    }
}


extension NotificationViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension NotificationViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return detailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.description(), for: indexPath)
        self.tableViewNotificationTableViewCellSetData(indexPath, cell: cell as! NotificationTableViewCell)
        return cell
    }
}


extension NotificationViewModel : DZNEmptyDataSetDelegate {
    
}

extension NotificationViewModel : DZNEmptyDataSetSource {
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
