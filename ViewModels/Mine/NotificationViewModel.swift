//
//  NotificationViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit


class NotificationViewModel: BaseViewModel {

    var type:NotificationType!
    var unreadModel:UnreadMessageModel!
    
    var detailArray = NSMutableArray.init()
    var page:Int = 0
    override init() {
        super.init()
    }
    
    
    func tableViewNotificationTableViewCellSetData(_ indexPath:IndexPath, cell:NotificationTableViewCell) {
        cell.cellSetData(model: NotificaitonModel.init(fromDictionary: self.detailArray[indexPath.section] as! [String : Any]), indexPath: indexPath)
        cell.notificationTableViewCellClouse = { indexPath in
            let alerController = UIAlertController.init(title: "操作", message: "", preferredStyle: .actionSheet)
            alerController.addAction(title: "标记已读", style: .default, isEnabled: true, handler: { (read) in
                self.notificationStatusNet(indexPath: indexPath)
            })
            alerController.addAction(title: "删除消息", style: .default, isEnabled: true, handler: { (read) in
                self.deleteNotificationNet(indexPath: indexPath)
            })
            alerController.addAction(title: "取消", style: .cancel, isEnabled: true, handler: { (cancel) in
                alerController.dismiss(animated: true, completion: {
                    
                })
            })
            NavigaiontPresentView(self.controller!, toController: alerController)
        }
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        if self.type != .system {
            let dicData:NSDictionary = NotificaitonModel.init(fromDictionary: self.detailArray[indexPath.section] as! [String : Any]).toDictionary() as NSDictionary
            if dicData.object(forKey: "tipStatus") as! Int == 1 {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "帖子已删除", autoHidder: true)
                return
            }
            let mutDic = NSMutableDictionary.init(dictionary: dicData)
            mutDic.setObject(dicData.object(forKey: "params")!, forKey: "id" as NSCopying)
            if (self.controller as! NotificationViewController).postDetailDataClouse != nil {
                (self.controller as! NotificationViewController).postDetailDataClouse(mutDic,.Hot,indexPath)
            }
            //点击及标记已读
            self.notificationStatusNet(indexPath: indexPath)
        }
        
    }
    
    override func tapViewNoneData() {
        self.page = 0
        self.notificationNet()
    }
    
    func notificationNet(){
        page = page + 1
        let parameters = ["page":page.string, "limit":LIMITNUMBER, "type":self.type.rawValue] as [String : Any]
        BaseNetWorke.getSharedInstance().postUrlWithString(NotificationListUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if self.page != 1 {
                    self.detailArray.addObjects(from: NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array) as! [Any])
                }else{
                    self.detailArray = NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array)
                }
                self.reloadTableViewData()
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func notificationStatusNet(indexPath:IndexPath){
        let messageModel = NotificaitonModel.init(fromDictionary: self.detailArray[indexPath.section] as! [String : Any])
        let parameters = ["notifyId":messageModel.id.string] as [String : Any]
        BaseNetWorke.getSharedInstance().postUrlWithString(NotifyAlertStatusUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.updateUnreadNumber()
                messageModel.status = "1"
                self.detailArray.replaceObject(at: indexPath.section, with: messageModel.toDictionary())
                _ = Tools.shareInstance.showMessage(self.controller!.view, msg: "标记成功", autoHidder: true)
                self.reloadTableViewData()
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func deleteNotificationNet(indexPath:IndexPath){
        let messageModel = NotificaitonModel.init(fromDictionary: self.detailArray[indexPath.section] as! [String : Any])
        let parameters = ["notifyId":messageModel.id.string] as [String : Any]
        BaseNetWorke.getSharedInstance().postUrlWithString(NotifyAlertDeleteUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.updateUnreadNumber()
                messageModel.status = "1"
                self.detailArray.replaceObject(at: indexPath.section, with: messageModel.toDictionary())
                _ = Tools.shareInstance.showMessage(KWindow, msg: "删除成功", autoHidder: true)
                self.detailArray.removeObject(at: indexPath.section)
                self.reloadTableViewData()
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func updateUnreadNumber(){
        switch self.type! {
        case NotificationType.system:
            unreadModel.violation = unreadModel.violation - 1
        case NotificationType.approve:
            unreadModel.approveMine = unreadModel.approveMine - 1
        case NotificationType.comment:
            unreadModel.commentMine = unreadModel.commentMine - 1
        default:
            unreadModel.atMine = unreadModel.atMine - 1
        }
        
        self.unreadModel.allunread = unreadModel.atMine + unreadModel.approveMine + unreadModel.commentMine + unreadModel.violation
        if (self.controller! as! NotificationViewController).notificationViewControllerReloadClouse != nil {
            (self.controller! as! NotificationViewController).notificationViewControllerReloadClouse(self.type!.rawValue)
        }
        CacheManager.getSharedInstance().saveUnreadModel(category: self.unreadModel)
    }
}


extension NotificationViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 5
        }
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension NotificationViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return detailArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.description(), for: indexPath)
        self.tableViewNotificationTableViewCellSetData(indexPath, cell: cell as! NotificationTableViewCell)
        (cell as! NotificationTableViewCell).hiddenLineLabel(ret: self.detailArray.count - 1 == indexPath.section ? true : false)
        return cell
    }
}
