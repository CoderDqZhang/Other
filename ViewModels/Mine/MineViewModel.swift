//
//  MineViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/16.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet


class MineViewModel: BaseViewModel {
    
    let titles = [["实名认证","专家号申请","消息","设置"],["邀请好友"]]
    var desc:[[String]]!
    
    var userInfo:UserInfoModel!
    var accountInfo:AccountInfoModel!
    override init() {
        super.init()
    }
    
    func tableViewMineInfoTableViewCellSetData(_ indexPath:IndexPath, cell:MineInfoTableViewCell) {
        cell.cellSetData(model: userInfo, acount: self.accountInfo)
        
        cell.mineInfoTableViewCellClouse = { type in
            if CacheManager.getSharedInstance().isLogin() {
                switch type {
                case .fans:
                    NavigationPushView(self.controller!, toConroller: FansViewController())
                case .follow:
                    NavigationPushView(self.controller!, toConroller: FollowsViewController())
                case .topUp:
                    if self.userInfo.isMember == "1" {
                        let touUpVC = TopUpViewController()
                        touUpVC.accountInfo = self.accountInfo
                        NavigationPushView(self.controller!, toConroller: touUpVC)
                    }else{
                        _ = Tools.shareInstance.showMessage(self.getControllerView(), msg: "请先实名认证", autoHidder: true)
                    }
                case.daily:
                    NavigationPushView(self.controller!, toConroller: DailyViewController())
                default:
                    NavigationPushView(self.controller!, toConroller: StoreSegementViewController())
                }
            }else{
                NavigationPushView(self.controller!, toConroller: LoginViewController())
            }
        }
    }
    
    func tableViewMineToolsTableViewCellSetData(_ indexPath:IndexPath, cell:MineToolsTableViewCell) {
        cell.mineToolsTableViewCellClouse = { type in
            if CacheManager.getSharedInstance().isLogin() {
                switch type {
                case .post:
                    NavigationPushView(self.controller!, toConroller: PostSegementViewController())
                case .collect:
                    NavigationPushView(self.controller!, toConroller: MycollectViewController())
                default:
                    break
                }
            }else{
                NavigationPushView(self.controller!, toConroller: LoginViewController())
            }
        }
    }
    
    func tableViewAdTableViewCellSetData(_ indexPath:IndexPath, cell:AdTableViewCell) {
        
    }
    
    func tableViewTitleLableAndDetailLabelDescRightSetData(_ indexPath:IndexPath, cell:TitleLableAndDetailLabelDescRight) {
        if self.userInfo != nil {
            cell.cellSetData(title: titles[indexPath.section-3][indexPath.row], desc: desc[indexPath.section-3][indexPath.row], image: nil, isDescHidden: false)
            if indexPath.row == 1 {
                cell.updateDescFontAndColor(App_Theme_999999_Color!, App_Theme_PinFan_R_12_Font!)
            }else if indexPath.row == 0{
                cell.updateDescFontAndColor(App_Theme_FF7800_Color!, App_Theme_PinFan_R_12_Font!)
            }else if indexPath.row == 2{
                if self.userInfo == nil {
                    cell.setNumberText(str: "0")
                }else{
                    cell.setNumberText(str: CacheManager.getSharedInstance().getUnreadModel()!.allunread.string)
                }
            }
        }else{
             cell.cellSetData(title: titles[indexPath.section-3][indexPath.row], desc: "", image: nil, isDescHidden: false)
        }
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        if CacheManager.getSharedInstance().isLogin() {
            switch indexPath.section {
            case 0:
                if indexPath.row == 0 {
                    let mineInfo = MineInfoViewController()
                    mineInfo.userInfo = self.userInfo
                    NavigationPushView(self.controller!, toConroller: mineInfo)
                }
            case 3:
                if indexPath.row == 0 {
                    if self.userInfo != nil && (self.userInfo!.isMember == "1") {
                        _ = Tools.shareInstance.showMessage(self.getControllerView(), msg: "您已经实名认证了", autoHidder: true)
                        return
                    }
                    NavigationPushView(self.controller!, toConroller: RealNameViewController())
                }else if indexPath.row == 1{
                    if self.userInfo != nil  {
                        if (self.userInfo!.isMaster == "1"){
                            _ = Tools.shareInstance.showMessage(self.getControllerView(), msg: "您已经是大神用户", autoHidder: true)
                            return
                        }
                        if (self.userInfo!.isMaster == "2") {
                            _ = Tools.shareInstance.showMessage(self.getControllerView(), msg: "正在审核中", autoHidder: true)
                            return
                        }
                    }
                    NavigationPushView(self.controller!, toConroller: SingUpVIPViewController())
                }else if indexPath.row == 2{
                    NavigationPushView(self.controller!, toConroller: MessageSegementViewController())
                }else if indexPath.row == 3{
                    let settinVC = SettingViewController()
                    settinVC.logoutClouse = {
                        self.userInfo = nil
                        self.accountInfo = nil
                        self.desc = [["","","",""],[""]]
                        CacheManager.getSharedInstance().logout()
                        self.reloadTableViewData()
                    }
                    NavigationPushView(self.controller!, toConroller: settinVC)
                }
            case 4:
                NavigationPushView(self.controller!, toConroller: InviteUserViewController())
            default:
                break
            }
        }else{
            NavigationPushView(self.controller!, toConroller: LoginViewController())
        }
        
    }
    
    
    func getUserInfoNet(userId:String){
        let parameters = ["userId":userId]
        BaseNetWorke.getSharedInstance().getUrlWithString(UserInfoUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.userInfo = UserInfoModel.init(fromDictionary: resultDic.value as! [String : Any])
                CacheManager.getSharedInstance().saveUserInfo(userInfo: self.userInfo)
                self.desc = [[self.userInfo.isMember == "1" ? "已认证" : "点击实名认证", self.userInfo.isMaster == "1" ? "已认证" : self.userInfo.isMaster == "2" ? "审核中" : "点击申请","",""],["推广标语推广标语"]]
                self.reloadTableViewData()
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func getAccountInfoNet(userId:String){
        BaseNetWorke.getSharedInstance().postUrlWithString(AccountfindAccountUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.accountInfo = AccountInfoModel.init(fromDictionary: resultDic.value as! [String : Any])
                self.reloadTableViewData()
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
}


extension MineViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 || section == 3 {
            return 8
        }
        return 0.00001
    }
    //1
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            //185/375
            return SCREENWIDTH * 205 / 375
        case 1:
            //79/375
            return 79 
        case 2:
            return 70
        case 3:
            return 47
        default:
            if indexPath.row == 0 {
                return 30
            }
            return 70
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var alpa:CGFloat = 0
        if #available(iOS 11.0, *) {
            alpa = scrollView.contentOffset.y / (SCREENWIDTH * 205 / 375 - 64 - NAV_HEIGHT)
        } else {
            alpa = scrollView.contentOffset.y / (SCREENWIDTH * 205 / 375 - 64)
            // Fallback on earlier versions
        }
        (self.controller as! MineViewController).gloableNavigationBar.changeBackGroundColor(transparency: alpa > 1 ? 1 :alpa)
    }
}

extension MineViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0,1,2:
            return 1
        case 3:
            return titles[section - 3].count
        default:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MineInfoTableViewCell.description(), for: indexPath)
            self.tableViewMineInfoTableViewCellSetData(indexPath, cell: cell as! MineInfoTableViewCell)
            cell.selectionStyle = .none
            cell.contentView.backgroundColor = App_Theme_F6F6F6_Color
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MineToolsTableViewCell.description(), for: indexPath)
            self.tableViewMineToolsTableViewCellSetData(indexPath, cell: cell as! MineToolsTableViewCell)
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.description(), for: indexPath)
            self.tableViewAdTableViewCellSetData(indexPath, cell: cell as! AdTableViewCell)
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleLableAndDetailLabelDescRight.description(), for: indexPath)
            self.tableViewTitleLableAndDetailLabelDescRightSetData(indexPath, cell: cell as! TitleLableAndDetailLabelDescRight)
            cell.selectionStyle = .none
            if indexPath.row == titles[indexPath.section - 3].count - 1 {
                (cell as! TitleLableAndDetailLabelDescRight).lineLableHidden()
            }
            return cell
        
        default:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TitleLableAndDetailLabelDescRight.description(), for: indexPath)
                self.tableViewTitleLableAndDetailLabelDescRightSetData(indexPath, cell: cell as! TitleLableAndDetailLabelDescRight)
                cell.selectionStyle = .none
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.description(), for: indexPath)
            self.tableViewAdTableViewCellSetData(indexPath, cell: cell as! AdTableViewCell)
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension MineViewModel : DZNEmptyDataSetDelegate {
    
}

extension MineViewModel : DZNEmptyDataSetSource {
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
