//
//  SearchResultViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/16.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class SearchResultViewModel: BaseViewModel {
    
    var reslutArray:NSMutableArray!
    
    override init() {
        super.init()
    }
    
    func tableViewTagerUserTableViewCellSetData(_ indexPath:IndexPath, cell:TagerUserTableViewCell) {
        let dic = reslutArray[indexPath.row] as! NSDictionary
        cell.cellSetFansData(model: FansFlowwerModel.init(fromDictionary: dic as! [String : Any]))
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        if (self.controller as!  TargerUserSearchViewController).resultDicClouse != nil {
            (self.controller as!  TargerUserSearchViewController).resultDicClouse(reslutArray[indexPath.row] as! NSDictionary)
        }
    }
}


extension SearchResultViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
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

extension SearchResultViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reslutArray == nil ? 0 : reslutArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TagerUserTableViewCell.description(), for: indexPath)
        self.tableViewTagerUserTableViewCellSetData(indexPath, cell: cell as! TagerUserTableViewCell)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
}

extension SearchResultViewModel : DZNEmptyDataSetDelegate {
    
}

extension SearchResultViewModel : DZNEmptyDataSetSource {
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
