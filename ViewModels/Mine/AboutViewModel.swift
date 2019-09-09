//
//  AboutViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/9/9.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class AboutViewModel: BaseViewModel {

    let titles = ["","服务协议","隐私政策",""]
    
    override init() {
        super.init()
    }
    
    func tableViewTitleLableAndDetailLabelDescRightSetData(_ indexPath:IndexPath, cell:TitleLableAndDetailLabelDescRight) {
        cell.cellSetData(title: titles[indexPath.row], desc: "", leftImage: nil, rightImage: nil, isDescHidden: true)
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        if indexPath.row == 1 {
            let controllerVC = ProtocolViewViewController()
            controllerVC.loadRequest(url: RegisterLoginUrl)
            NavigationPushView(self.controller!, toConroller: controllerVC)
        }else if indexPath.row == 2 {
            let controllerVC = ProtocolViewViewController()
            controllerVC.loadRequest(url: SecretUrl)
            NavigationPushView(self.controller!, toConroller: controllerVC)
        }
    }
}


extension AboutViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    //1
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 186
        case 1,2:
            return 55
        default:
            if #available(iOS 11.0, *) {
                return SCREENHEIGHT - 186 - 55 - 55 - 64 - NAV_HEIGHT
            } else {
                // Fallback on earlier versions
                return SCREENHEIGHT - 186 - 55 - 55 - 64
            }
        }
    }
}

extension AboutViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: AboutTableViewCell.description(), for: indexPath)
            cell.selectionStyle = .none
            cell.contentView.backgroundColor = App_Theme_F6F6F6_Color
            return cell
        case 1,2:
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleLableAndDetailLabelDescRight.description(), for: indexPath)
            self.tableViewTitleLableAndDetailLabelDescRightSetData(indexPath, cell: cell as! TitleLableAndDetailLabelDescRight)
            if indexPath.row == 2 {
                (cell as! TitleLableAndDetailLabelDescRight).lineLableHidden()
            }
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: AboutInfoTableViewCell.description(), for: indexPath)
            cell.contentView.backgroundColor = App_Theme_F6F6F6_Color
            return cell
        }
    }
}

