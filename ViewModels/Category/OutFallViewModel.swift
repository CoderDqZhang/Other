//
//  OutFallViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import ReactiveSwift

class OutFallViewModel: BaseViewModel {

    let contentStrs = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo.","Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo.","Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo.","Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo.","Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo.","Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo."]
    let translateStrs = ["巴塞罗那今晚必定夺冠，巴塞罗那今晚必定夺冠巴塞罗那今晚必定夺冠，巴塞罗那今晚必定夺冠，巴塞罗那今晚必定夺冠巴塞罗那今晚必定夺冠。","巴塞罗那今晚必定夺冠，巴塞罗那今晚必定夺冠巴塞罗那今晚必定夺冠，巴塞罗那今晚必定夺冠，巴塞罗那今晚必定夺冠巴塞罗那今晚必定夺冠。","巴塞罗那今晚必定夺冠，巴塞罗那今晚必定夺冠巴塞罗那今晚必定夺冠，巴塞罗那今晚必定夺冠，巴塞罗那今晚必定夺冠巴塞罗那今晚必定夺冠。","巴塞罗那今晚必定夺冠，巴塞罗那今晚必定夺冠巴塞罗那今晚必定夺冠，巴塞罗那今晚必定夺冠，巴塞罗那今晚必定夺冠巴塞罗那今晚必定夺冠。","巴塞罗那今晚必定夺冠，巴塞罗那今晚必定夺冠巴塞罗那今晚必定夺冠，巴塞罗那今晚必定夺冠，巴塞罗那今晚必定夺冠巴塞罗那今晚必定夺冠。","巴塞罗那今晚必定夺冠，巴塞罗那今晚必定夺冠巴塞罗那今晚必定夺冠，巴塞罗那今晚必定夺冠，巴塞罗那今晚必定夺冠巴塞罗那今晚必定夺冠。"]
    let images = [[],["https://placehold.jp/150x150.png","https://placehold.jp/150x150.png","https://placehold.jp/150x150.png"],[],["https://placehold.jp/150x150.png","https://placehold.jp/150x150.png"],["https://placehold.jp/150x150.png"]]
    let isTransArray:NSMutableArray = [false,false,false,false,false]
    
    
    override init() {
        super.init()
    }
    
    
    func tableViewOutFallCategoryContentTableViewCellSetData(_ indexPath:IndexPath, cell:OutFallCategoryContentTableViewCell) {
        cell.cellSetData(content: contentStrs[indexPath.section], translate: translateStrs[indexPath.section], images: images[indexPath.section], isTrans: isTransArray[indexPath.section] as! Bool, indexPath: indexPath, transButtonClicks: { indexPath in
            self.isTransArray.replaceObject(at: indexPath.section, with: true)
            self.controller?.tableView.reloadRows(at: [indexPath], with: .automatic)
        })
    }
    
    func tableViewOutFallCategoryUserInfoTableViewCellSetData(_ indexPath:IndexPath, cell:OutFallCategoryUserInfoTableViewCell){
        
    }
    
    func tableViewCommentTableViewCellSetData(_ indexPath:IndexPath, cell:CommentTableViewCell){
        
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        let dicData = NSDictionary.init(dictionary: ["contentStrs":contentStrs[indexPath.section],"translateStrs":translateStrs[indexPath.section],"images":images[indexPath.section]], copyItems: true)
        (self.controller! as! OutFallViewController).postDetailDataClouse(dicData,.OutFall)
    }
    
    ///获取内容高度
    func getHeight(_ indexPath:IndexPath, isTrans:Bool) -> CGFloat{
        let stringHeight = self.contentStrs[indexPath.section].height(with: App_Theme_PinFan_M_14_Font, constrainedToWidth: SCREENWIDTH - 30)
        let transHeight = self.translateStrs[indexPath.section].height(with: App_Theme_PinFan_M_14_Font, constrainedToWidth: SCREENWIDTH - 30)
        let imageHeight = images[indexPath.section].count > 1 ? contentImageHeight : 0
        if isTrans {
            return stringHeight + transHeight + imageHeight + 50
        }
        return stringHeight + imageHeight + 50
        
    }
}


extension OutFallViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 52
        }else if indexPath.row == 1 {
            return self.getHeight(indexPath, isTrans: isTransArray[indexPath.section] as! Bool)
        }
        return 32
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 52
        }else if indexPath.row == 1{
            return 52
        }
        return 32
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension OutFallViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: OutFallCategoryUserInfoTableViewCell.description(), for: indexPath)
            self.tableViewOutFallCategoryUserInfoTableViewCellSetData(indexPath, cell: cell as! OutFallCategoryUserInfoTableViewCell)
            cell.selectionStyle = .none
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: OutFallCategoryContentTableViewCell.description(), for: indexPath)
            self.tableViewOutFallCategoryContentTableViewCellSetData(indexPath, cell: cell as! OutFallCategoryContentTableViewCell)
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.description(), for: indexPath)
        self.tableViewCommentTableViewCellSetData(indexPath, cell: cell as! CommentTableViewCell)
        cell.selectionStyle = .none
        return cell
    }
}

extension OutFallViewModel : DZNEmptyDataSetDelegate {
    
}

extension OutFallViewModel : DZNEmptyDataSetSource {
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
