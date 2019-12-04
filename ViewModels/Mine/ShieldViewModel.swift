//
//  ShieldViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/11/18.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class ShieldViewModel: BaseViewModel {
    var page = 0
    var shieldArray = NSMutableArray.init()
    
    override init() {
        super.init()
        self.getShieldNet()
    }
    
    func tableViewShieldTableViewCellSetData(_ indexPath:IndexPath, cell:ShieldTableViewCell) {
        cell.cellSetData(model: FansFlowwerModel.init(fromDictionary: shieldArray[indexPath.row] as! [String : Any]), indexPath: indexPath)
        if shieldArray.count > 1 {
            cell.lineLableHidden(ret: shieldArray.count - 1 == indexPath.row ? true : false)
        }
        
        cell.tableViewCellClouse = { indexPath in
            self.deleteShieldNet(indexPath: indexPath)
        }
        
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        let dic:NSDictionary = FansFlowwerModel.init(fromDictionary: self.shieldArray[indexPath.row] as! [String : Any]).toDictionary() as NSDictionary
        let otherMineVC = OtherMineViewController()
        otherMineVC.postData = dic
        NavigationPushView(self.controller!, toConroller: otherMineVC)
    }
    
    override func tapViewNoneData() {
        self.page = 0
        self.getShieldNet()
    }
    
    func deleteShieldNet(indexPath:IndexPath){
        let model = FansFlowwerModel.init(fromDictionary: shieldArray[indexPath.row] as! [String : Any])
        let parameters = ["userId":model.id!] as [String : Any]
        BaseNetWorke.getSharedInstance().postUrlWithString(PersonDeleteShielUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.shieldArray.removeObject(at: indexPath.row)
                self.controller?.tableView.deleteRows(at: [indexPath], with: .automatic)
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func getShieldNet(){
        page = page + 1
        let parameters = ["page":page.string, "limit":LIMITNUMBER] as [String : Any]
        BaseNetWorke.getSharedInstance().getUrlWithString(PersonGetShielUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if self.page != 1 {
                    self.shieldArray.addObjects(from: NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array) as! [Any])
                }else{
                    self.shieldArray = NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array)
                }
                self.reloadTableViewData()
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    override func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if self.netStatus {
            let attributed = "被屏蔽的用户将无法在您的帖子中跟帖或回复"
            let attributedString = NSMutableAttributedString.init(string: attributed)
            attributedString.addAttributes([NSAttributedString.Key.font:App_Theme_PinFan_M_16_Font!,NSAttributedString.Key.foregroundColor:App_Theme_999999_Color!], range: NSRange.init(location: 0, length: 20))
            
            return attributedString
        }else{
            let attributed = "网络开小猜了~"
            let attributedString = NSMutableAttributedString.init(string: attributed)
            attributedString.addAttributes([NSAttributedString.Key.font:App_Theme_PinFan_M_16_Font!,NSAttributedString.Key.foregroundColor:App_Theme_999999_Color!], range: NSRange.init(location: 0, length: 7))
            
            return attributedString
        }
        
    }
}


extension ShieldViewModel: UITableViewDelegate {
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

extension ShieldViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shieldArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShieldTableViewCell.description(), for: indexPath)
        self.tableViewShieldTableViewCellSetData(indexPath, cell: cell as! ShieldTableViewCell)
        (cell as! ShieldTableViewCell).lineLableHidden(ret: indexPath.row == self.shieldArray.count - 1 ? true : false)
        cell.selectionStyle = .none
        return cell
    }
}

