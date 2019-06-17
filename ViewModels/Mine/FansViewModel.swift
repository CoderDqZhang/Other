//
//  FansViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class FansViewModel: BaseViewModel {
    
    var page = 0
    var fansArray = NSMutableArray.init()
    override init() {
        super.init()
        self.getFansNet()
    }
    
    func tableViewGloabelFansTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelFansTableViewCell) {
        cell.cellSetData(model: FansFlowwerModel.init(fromDictionary: fansArray[indexPath.row] as! [String : Any]))
        if indexPath.row == 9 {
            cell.lineLableHidden()
        }
    }
    
    func getFansNet(){
        page = page + 1
        let parameters = ["page":page.string, "limit":LIMITNUMBER] as [String : Any]
        BaseNetWorke.getSharedInstance().postUrlWithString(PersonmyFansUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if self.page != 1 {
                    self.fansArray.addObjects(from: NSMutableArray.init(array: resultDic.value as! Array) as! [Any])
                }else{
                    self.fansArray = NSMutableArray.init(array: resultDic.value as! Array)
                }
                self.reloadTableViewData()
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        let dic:NSDictionary = FansFlowwerModel.init(fromDictionary: self.fansArray[indexPath.row] as! [String : Any]).toDictionary() as NSDictionary
        let otherMineVC = OtherMineViewController()
        otherMineVC.postData = dic
        NavigationPushView(self.controller!, toConroller: otherMineVC)
    }
}


extension FansViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
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

extension FansViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fansArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GloabelFansTableViewCell.description(), for: indexPath)
        self.tableViewGloabelFansTableViewCellSetData(indexPath, cell: cell as! GloabelFansTableViewCell)
        cell.selectionStyle = .none
        return cell
    }
}

extension FansViewModel : DZNEmptyDataSetDelegate {
    
}

extension FansViewModel : DZNEmptyDataSetSource {
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
