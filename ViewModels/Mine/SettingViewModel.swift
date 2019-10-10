//
//  SettingViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit


class SettingViewModel: BaseViewModel {
    
    let titles = [["基本资料","修改密码"],["关于我们","清除缓存","用户反馈"],["退出登录"]]
    var bankLiskArray = NSMutableArray.init()
    override init() {
        super.init()
        self.getAccountInfoList()
    }
    
    func tableViewTitleLableAndDetailLabelDescRightSetData(_ indexPath:IndexPath, cell:TitleLableAndDetailLabelDescRight) {
        cell.cellSetData(title: titles[indexPath.section][indexPath.row], desc: "", leftImage: nil, rightImage: nil, isDescHidden: true)
        if indexPath.row == titles[indexPath.section].count - 1 {
            cell.lineLableHidden()
        }
        
        if indexPath.row == 0 && indexPath.section == 2 {
            cell.accessoryType = .none
        }
        cell.updateDescFontAndColor(App_Theme_06070D_Color!, App_Theme_PinFan_R_14_Font!)
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                NavigationPushView(self.controller!, toConroller: MineInfoViewController())
            }else if indexPath.row == 1{
                NavigationPushView(self.controller!, toConroller: ChangePasswordViewController())
            }else{
                let bindWithVC = BindBankListViewController()
                bindWithVC.bankListk = self.bankLiskArray
                
                NavigationPushView(self.controller!, toConroller: bindWithVC)
            }
        case 1:
            if indexPath.row == 0 {
                NavigationPushView(self.controller!, toConroller: AboutViewController())
            }else if indexPath.row == 1 {
                ThirdPartCacheManager.getSharedInstance().cleanCache()
            }else{
                NavigationPushView(self.controller!, toConroller: FeedBackViewController())
            }
        default:
            UIAlertController.showAlertControl(self.controller!, style: .alert, title: "是否退出？", message: nil, cancel: "取消", doneTitle: "确定", cancelAction: {
                
            }) {
               self.logoutNet()
            }
            break
        }
    }
    
    func logoutNet(){
        BaseNetWorke.getSharedInstance().postUrlWithString(UserlogoutUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                CacheManager.getSharedInstance().logout()
                if (self.controller as! SettingViewController).logoutClouse != nil {
                    (self.controller as! SettingViewController).logoutClouse()
                    NotificationManager.getSharedInstance().deleteAlias()
                    self.controller?.navigationController?.popViewController()
                }
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func getAccountInfoList(){
        BaseNetWorke.getSharedInstance().postUrlWithString(AccountFindCashAccountUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.bankLiskArray = NSMutableArray.init(array: resultDic.value as! Array)
                self.reloadTableViewData()
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
}


extension SettingViewModel: UITableViewDelegate {
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
        return 47
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension SettingViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titles[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleLableAndDetailLabelDescRight.description(), for: indexPath)
        self.tableViewTitleLableAndDetailLabelDescRightSetData(indexPath, cell: cell as! TitleLableAndDetailLabelDescRight)
        cell.selectionStyle = .none
        return cell
    }
}
