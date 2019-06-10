//
//  SettingViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit


class SettingViewModel: BaseViewModel {
    
    let titles = [["基本资料","修改密码"],["关于豹典","用户反馈"],["退出登录"]]
    override init() {
        super.init()
    }
    
    func tableViewTitleLableAndDetailLabelDescRightSetData(_ indexPath:IndexPath, cell:TitleLableAndDetailLabelDescRight) {
        cell.cellSetData(title: titles[indexPath.section][indexPath.row], desc: "", image: nil, isDescHidden: true)
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
            }else{
                NavigationPushView(self.controller!, toConroller: ChangePasswordViewController())
            }
        case 1:
            if indexPath.row == 0 {
                NavigationPushView(self.controller!, toConroller: AboutViewController())
            }else{
                NavigationPushView(self.controller!, toConroller: FeedBackViewController())
            }
        default:
            self.logoutNet()
            break
        }
    }
    
    func logoutNet(){
        BaseNetWorke.sharedInstance.postUrlWithString(UserlogoutUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                CacheManager.getSharedInstance().logout()
                if (self.controller as! SettingViewController).logoutClouse != nil {
                    (self.controller as! SettingViewController).logoutClouse()
                    self.controller?.navigationController?.popViewController()
                }
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
        
        return cell
    }
}
