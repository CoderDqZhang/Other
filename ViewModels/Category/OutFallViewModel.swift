//
//  OutFallViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import ReactiveSwift
typealias OutFallViewModelTransClouse = (_ str:String) ->Void

class OutFallViewModel: BaseViewModel {

    var page:Int = 0
    var tipListArray = NSMutableArray.init()
    
    let isTransArray:NSMutableArray = []
    
    
    override init() {
        super.init()
        self.getTribeListNet()
    }
    
    
    func tableViewOutFallCategoryContentTableViewCellSetData(_ indexPath:IndexPath, cell:OutFallCategoryContentTableViewCell) {
        if self.tipListArray.count > 0 {
            cell.cellSetData(model: OutFallModel.init(fromDictionary: self.tipListArray[indexPath.section] as! [String : Any]), isTrans: self.isTransArray[indexPath.section] as! Bool, indexPath: indexPath) { (indexPath) in
                let model = OutFallModel.init(fromDictionary: self.tipListArray[indexPath.section] as! [String : Any])
                self.transEnglish(q: model.content, trans: { (str) in
                    model.cnContent = str
                    self.tipListArray.replaceObject(at: indexPath.section, with: model.toDictionary())
                    self.isTransArray.replaceObject(at: indexPath.section, with: true)
                    self.reloadTableViewData()

                })
            }
            
            cell.outFallCategoryContentImageClick = { tag,browser in
                NavigaiontPresentView(self.controller!, toController: browser)
            }
        }
    }
    
    func tableViewOutFallCategoryUserInfoTableViewCellSetData(_ indexPath:IndexPath, cell:OutFallCategoryUserInfoTableViewCell){
        cell.cellSetData(model: OutFallModel.init(fromDictionary: self.tipListArray[indexPath.section] as! [String : Any]))
    }
    
    func tableViewCommentTableViewCellSetData(_ indexPath:IndexPath, cell:CommentTableViewCell){
        
    }
    
    override func tapViewNoneData() {
        self.page = 0
        self.getTribeListNet()
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
//        let dicData = NSDictionary.init(dictionary: ["contentStrs":contentStrs[indexPath.section],"translateStrs":translateStrs[indexPath.section],"images":images[indexPath.section]], copyItems: true)
//        (self.controller! as! OutFallViewController).postDetailDataClouse(dicData,.OutFall)
    }
    
    ///获取内容高度
    func getHeight(_ indexPath:IndexPath, isTrans:Bool) -> CGFloat{
        let model = OutFallModel.init(fromDictionary: self.tipListArray[indexPath.section] as! [String : Any])
        let titleHeight = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_14_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: model.content, yyLabel: YYLabel.init()).textBoundingSize.height
        var transHeight:CGFloat = 0
        if isTrans {
            transHeight = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_14_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: model.cnContent, yyLabel: YYLabel.init()).textBoundingSize.height
        }
        let images = model.image.split(separator: ",")
        if images.count > 0 {
            return transHeight + titleHeight + contentImageHeight + ((contentImageHeight + 10) * CGFloat(images.count / 4)) + 70
        }
        return titleHeight + transHeight + 50

    }
    
    func getTribeListNet(){
        page = page + 1
        let parameters = ["page":page.string, "limit":LIMITNUMBER, "tribeId":"0", "isCollect":"0"] as [String : Any]
        BaseNetWorke.getSharedInstance().getUrlWithString(TippublishTopTipUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if self.page != 1 {
                    self.tipListArray.addObjects(from: NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array) as! [Any])
                    for _ in NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array) {
                        self.isTransArray.add(false)
                    }
                }else{
                    self.isTransArray.removeAllObjects()
                    self.tipListArray = NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array)
                    for _ in NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array) {
                        self.isTransArray.add(false)
                    }
                }
                self.reloadTableViewData()
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func transEnglish(q:String,trans:@escaping OutFallViewModelTransClouse){
        let loadingHud = Tools.shareInstance.showLoading(KWindow, msg: "翻译中")
        let parameters = ["client":"gtx", "dt":"t", "dj":"1", "ie":"UTF-8","sl":"auto","tl":"zh","q":q] as [String : Any]
        BaseNetWorke.getSharedInstance().googleTrans(url: getGoogleTransUrl(), parameters: parameters as AnyObject, success: { (resultDic) in
            let arrays = NSMutableArray.init(array: (resultDic as! NSDictionary).object(forKey: "sentences") as! Array)
            var str = ""
            for array in arrays {
                str = "\(str)\(String(describing: (array as! NSDictionary).object(forKey: "trans")!))"
            }
            loadingHud.hide(animated: true)
            trans(str)
        }) { (fail) in
            loadingHud.hide(animated: true)
        }
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
        return self.tipListArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 2
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


