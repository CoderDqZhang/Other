//
//  CategoryChossViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/24.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class CategoryChossViewModel: BaseViewModel {

    var categoryArray = NSMutableArray.init()
    var normalCategory = CacheManager.getSharedInstance().getCategoryModels() ?? NSMutableArray.init()
    
    let tarInfoTitle = ["最近常用部落","","全部部落"]
    override init() {
        super.init()
        self.getCategoryNet()
    }
    
    func tableViewTagerUserTableViewCellSetData(_ indexPath:IndexPath, cell:TagerUserTableViewCell) {

        if normalCategory.count > 0 {
            if indexPath.section == 1{
                cell.cellSetCatogyModel(model: CategoryModel.init(fromDictionary: self.normalCategory[indexPath.row] as! [String : Any]))
            }else if indexPath.section == 3 {
                cell.cellSetCatogyModel(model: CategoryModel.init(fromDictionary: self.categoryArray[indexPath.row] as! [String : Any]))
            }
        }else{
            cell.cellSetCatogyModel(model: CategoryModel.init(fromDictionary: self.categoryArray[indexPath.row] as! [String : Any]))
        }
        
    }
    
    func tableViewTargerUserInfoTableViewCellSetData(_ indexPath:IndexPath, cell:TargerUserInfoTableViewCell) {
        cell.cellSetData(str: tarInfoTitle[indexPath.section])
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        if indexPath.section == 1 {
            (self.controller as! CategoryChoosViewController).resultDicNavigationController(self.normalCategory[indexPath.row] as! NSDictionary)
        }else{
            (self.controller as! CategoryChoosViewController).resultDicNavigationController(self.categoryArray[indexPath.row] as! NSDictionary)
        }
    }
    
    func getCategoryNet(){
        BaseNetWorke.sharedInstance.postUrlWithString(TribetribeListUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.categoryArray = NSMutableArray.init(array: resultDic.value as! Array)
                (self.controller as! CategoryChoosViewController).searchController.originArray = self.categoryArray
                self.reloadTableViewData()
            }
        }
    }
}


extension CategoryChossViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 || section == 2{
            return 2
        }else if section == 1 {
            return 5
        }
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if normalCategory.count > 0 {
            if indexPath.section == 0 || indexPath.section == 2 {
                return 30
            }
            return 60
        }else{
            return 60
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension CategoryChossViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if normalCategory.count > 0 {
            return 4
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if normalCategory.count > 0 {
            if section == 0 || section == 2{
                return 1
            }else if section == 1 {
                return self.normalCategory.count
            }
            return self.categoryArray.count
        }else{
            return self.categoryArray.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if normalCategory.count > 0 {
            if indexPath.section == 0 || indexPath.section == 2  {
                let cell = tableView.dequeueReusableCell(withIdentifier: TargerUserInfoTableViewCell.description(), for: indexPath)
                self.tableViewTargerUserInfoTableViewCellSetData(indexPath, cell: cell as! TargerUserInfoTableViewCell)
                cell.backgroundColor = App_Theme_FFFFFF_Color
                cell.selectionStyle = .none
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: TagerUserTableViewCell.description(), for: indexPath)
            self.tableViewTagerUserTableViewCellSetData(indexPath, cell: cell as! TagerUserTableViewCell)
            cell.backgroundColor = App_Theme_FFFFFF_Color
            cell.selectionStyle = .none
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: TagerUserTableViewCell.description(), for: indexPath)
            self.tableViewTagerUserTableViewCellSetData(indexPath, cell: cell as! TagerUserTableViewCell)
            cell.backgroundColor = App_Theme_FFFFFF_Color
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension CategoryChossViewModel : DZNEmptyDataSetDelegate {
    
}

extension CategoryChossViewModel : DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributed = "暂时还没有数据哦！"
        let attributedString = NSMutableAttributedString.init(string: attributed)
        attributedString.addAttributes([NSAttributedString.Key.font:App_Theme_PinFan_M_16_Font!,NSAttributedString.Key.foregroundColor:App_Theme_CCCCCC_Color as Any], range: NSRange.init(location: 0, length: 9))
        
        return attributedString
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "pic_toy")
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -64
    }
}
