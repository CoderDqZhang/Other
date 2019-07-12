//
//  MyCommentViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/20.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class MyCommentViewModel: BaseViewModel {

    var myCommentArray:NSMutableArray!
    
    var page = 0
    override init() {
        super.init()
        self.getMyCommentNet()
    }
    
    
    func tableViewMyCommentTableViewCellSetData(_ indexPath:IndexPath, cell:MyCommentTableViewCell) {
        if myCommentArray != nil {
            let model = CommentModel.init(fromDictionary: myCommentArray![indexPath.section] as! [String : Any])
            if model.tipDetail.status == "0" {
                cell.cellSetData(model: model)
            }else{
                cell.deleteCellData(model: model)
            }
        }
    }
    
    func tableViewMCommentTableViewCellSetData(_ indexPath:IndexPath, cell:CommentTableViewCell){
        if myCommentArray != nil {
            cell.cellSetData(model: CommentModel.init(fromDictionary: myCommentArray![indexPath.section] as! [String : Any]).tipDetail)
        }
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        let dicData:NSDictionary = CommentModel.init(fromDictionary: myCommentArray![indexPath.section] as! [String : Any]).tipDetail.toDictionary() as NSDictionary
        if dicData.object(forKey: "status") as! String == "0" {
            (self.controller as! MyCommentViewController).postDetailDataClouse(NSMutableDictionary.init(dictionary: dicData),.Hot, indexPath)
        }else{
            _ = Tools.shareInstance.showMessage(KWindow, msg: "该贴已删除", autoHidder: true)
        }
    }
    
    func getMyCommentNet(){
        page = page + 1
        let parameters = ["page":page.string, "limit":LIMITNUMBER,] as [String : Any]
        BaseNetWorke.getSharedInstance().postUrlWithString(CommentcommentListUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if self.page != 1 {
                    self.myCommentArray.addObjects(from: NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array) as! [Any])
                }else{
                    self.myCommentArray = NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array)
                }
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
                self.reloadTableViewData()
            }else{
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    
}


extension MyCommentViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return tableView.fd_heightForCell(withIdentifier: MyCommentTableViewCell.description(), cacheByKey: self.myCommentArray![indexPath.section] as! NSCopying, configuration: { (cell) in
                self.tableViewMyCommentTableViewCellSetData(indexPath, cell: cell as! MyCommentTableViewCell)
            })
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
        (self.controller as! MyCommentViewController).listViewDidScrollCallback?(scrollView)
    }
}

extension MyCommentViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return myCommentArray == nil ? 0 : myCommentArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyCommentTableViewCell.description(), for: indexPath)
            self.tableViewMyCommentTableViewCellSetData(indexPath, cell: cell as! MyCommentTableViewCell)
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.description(), for: indexPath)
        self.tableViewMCommentTableViewCellSetData(indexPath, cell: cell as! CommentTableViewCell)
        cell.selectionStyle = .none
        return cell
    }
}

extension MyCommentViewModel : DZNEmptyDataSetDelegate {
    
}

extension MyCommentViewModel : DZNEmptyDataSetSource {
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
