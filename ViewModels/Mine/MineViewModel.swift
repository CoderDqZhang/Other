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
    let desc = [["已认证","已认证","",""],["推广标语推广标语"]]
    override init() {
        super.init()
    }
    
    func tableViewMineInfoTableViewCellSetData(_ indexPath:IndexPath, cell:MineInfoTableViewCell) {
        cell.mineInfoTableViewCellClouse = { type in
            print(type)
        }
    }
    
    func tableViewMineToolsTableViewCellSetData(_ indexPath:IndexPath, cell:MineToolsTableViewCell) {
        cell.mineToolsTableViewCellClouse = { type in
            print(type)
        }
    }
    
    func tableViewAdTableViewCellSetData(_ indexPath:IndexPath, cell:AdTableViewCell) {
        
    }
    
    func tableViewTitleLableAndDetailLabelDescRightSetData(_ indexPath:IndexPath, cell:TitleLableAndDetailLabelDescRight) {
        cell.cellSetData(title: titles[indexPath.section-3][indexPath.row], desc: desc[indexPath.section-3][indexPath.row], isDescHidden: false)
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
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
        attributedString.addAttributes([NSAttributedString.Key.font:App_Theme_PinFan_M_16_Font!,NSAttributedString.Key.foregroundColor:App_Theme_CCCCCC_Color], range: NSRange.init(location: 0, length: 9))
        
        return attributedString
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "pic_toy")
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -64
    }
}
