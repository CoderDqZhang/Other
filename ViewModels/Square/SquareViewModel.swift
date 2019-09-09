//
//  SquareViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/15.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class SquareViewModel: BaseViewModel {

    var page:Int = 0
    var articleListArray = NSMutableArray.init()
    
    var articleType:ArticleTypeModel!
    
    override init() {
        super.init()
    }
    
    func tableViewSquareTableViewCellSetData(_ indexPath:IndexPath, cell:SquareTableViewCell){
        if articleListArray.count > 0{
            cell.cellSetData(model: ArticleInfoModel.init(fromDictionary: articleListArray[indexPath.row] as! [String : Any]))
        }
    }
    
    override func tapViewNoneData() {
        self.page = 0
        self.getNetWorkData()
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        if (self.controller as! SquareViewController).squareViewControllerClouse != nil {
            (self.controller as! SquareViewController).squareViewControllerClouse( articleListArray[indexPath.row] as! NSDictionary,indexPath)
        }
    }
    
   
    
    func getNetWorkData(){
        page = page + 1
        let parameters = ["page":page.string, "limit":LIMITNUMBER, "type":self.articleType.id!] as [String : Any]
        BaseNetWorke.getSharedInstance().getUrlWithString(ArticleListUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if self.page != 1 {
                    self.articleListArray.addObjects(from: NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array) as! [Any])
                }else{
                    self.articleListArray = NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array)
                }
                self.reloadTableViewData()
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
}


extension SquareViewModel: UITableViewDelegate {
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
        return 105
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
}

extension SquareViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SquareTableViewCell.description(), for: indexPath)
        self.tableViewSquareTableViewCellSetData(indexPath, cell: cell as! SquareTableViewCell)
        cell.selectionStyle = .none
        return cell
    }
}


