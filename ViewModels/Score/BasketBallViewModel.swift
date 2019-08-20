//
//  BasketBallViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class BasketBallViewModel: BaseViewModel {

    var viewType:ScoreDetailVC!
    var viewDesc:ScoreDetailTypeVC!
    
    var basketballDic:NSDictionary!
    var basketBallArray = NSMutableArray.init()
    var allBasketBallArray =  NSMutableArray.init()
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(self.filterArray), name: NSNotification.Name.init(RELOADFILTERBASKETBALLMODEL), object: nil)
    }
    
    func tableViewBasketBallTableViewCellSetData(_ indexPath:IndexPath, cell:BasketBallTableViewCell) {
        if self.basketBallArray.count > 0 {
            let dic = self.basketBallArray[indexPath.section]
            if dic is NSDictionary {
                cell.cellSetData(model: BasketBallModel.init(fromDictionary: self.basketBallArray[indexPath.section] as! [String : Any]))
            }else{
                cell.cellSetData(model:  self.basketBallArray[indexPath.section] as! BasketBallModel)
            }
        }
    }
    
    override func tapViewNoneData() {
        (self.controller as! BasKetBallViewController).getNetWorkData()
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
    
    func socketData(){
        SocketManager.getSharedInstance().single?.observe { (dic) in
            if (dic.value as! NSDictionary).object(forKey: "type") as! Int == 2 {
                let matchs = (dic.value as! NSDictionary).object(forKey: "data")
                if (dic.value as! NSDictionary).object(forKey: "data") is NSArray {
                    for match in matchs as! NSArray {
                        let basketBall = self.basketBallArray.filter({ (model) -> Bool in
                            return (model as! BasketBallModel).id == (match as! Array)[0]
                        })
                        self.socketUpdateData(match: match as! NSArray, model: basketBall[0] as! BasketBallModel)
                    }
                    self.reloadTableViewData()
                }
            }
        }
    }
    
    func getbasketBallNet(type:String, date:String){
        let parameters = ["type":type, "date":date] as [String : Any]
        BaseNetWorke.getSharedInstance().postUrlWithString(BasketBallMatchUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if resultDic.value is NSArray {
                    self.basketBallBindText(resultDic.value as! NSArray)
                }
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func getBasketInfoBallNet(type:String, date:String){
        let parameters = ["date":date] as [String : Any]
        var temp_dic =  CacheManager.getSharedInstance().getBasketBallInfoModel()
        if temp_dic == nil || temp_dic?.object(forKey: date) == nil {
            BaseNetWorke.getSharedInstance().postUrlWithString(BasketBallInfoUrl, parameters: parameters as AnyObject).observe { (resultDic) in
                if !resultDic.isCompleted {
                    if temp_dic == nil {
                        temp_dic = NSMutableDictionary.init(dictionary:  [date:resultDic.value as! NSDictionary])
                    }else{
                        temp_dic?.setValue(resultDic.value , forKey: date)
                    }
                    CacheManager.getSharedInstance().saveBasketBallInfoModel(point: temp_dic!)
                    self.basketballDic = NSDictionary.init(dictionary:(temp_dic?.object(forKey: date) as! NSDictionary))
                    self.getbasketBallNet(type: type, date: date)
                }
            }
        }else{
            basketballDic = (temp_dic?.object(forKey: date) as! NSDictionary)
            self.getbasketBallNet(type: type, date: date)
        }
    }
    
    func basketBallBindText(_ dic:NSArray){
        UserDefaults.standard.set(dic.count, forKey: ALLBASKETBALLMACTH)
        for match in dic{
            let temp_array = (match as! NSArray)
            //去除阶段为0 错误
            let event = (basketballDic.object(forKey: "events") as! NSDictionary).object(forKey: "\(temp_array[2])") == nil ? [:] : (basketballDic.object(forKey: "events") as! NSDictionary).object(forKey: "\(temp_array[2])")!
            let model = BasketBallModel.init(fromDictionary: [
                "id": temp_array[0] as! Int,
                "section": temp_array[1] as! Int,
                "basketball_event": event,
                "status": temp_array[3] as! Int,
                "time": temp_array[4] as! Int,
                "all_second": temp_array[5] as! Int,
                "basketball_teamA": [
                    "basketball_team_info": [:],
                    "sort": (temp_array[6] as! NSArray)[1] as! String,
                    "first": (temp_array[6] as! NSArray)[2] as! Int,
                    "second": (temp_array[6] as! NSArray)[3] as! Int,
                    "third": (temp_array[6] as! NSArray)[4] as! Int,
                    "four": (temp_array[6] as! NSArray)[5] as! Int,
                    "overtime": (temp_array[6] as! NSArray)[6] as! Int,
                    "team_name":(temp_array[6] as! NSArray)[7] as! String
                ],
                "basketball_teamB": [
                    "basketball_team_info": [:],
                    "sort": (temp_array[7] as! NSArray)[1] as! String,
                    "first": (temp_array[7] as! NSArray)[2] as! Int,
                    "second": (temp_array[7] as! NSArray)[3] as! Int,
                    "third": (temp_array[7] as! NSArray)[4] as! Int,
                    "four": (temp_array[7] as! NSArray)[5] as! Int,
                    "overtime": (temp_array[7] as! NSArray)[6] as! Int,
                    "team_name":(temp_array[7] as! NSArray)[7] as! String
                ],
                "basketball_remark": [
                    "remark_detail": (temp_array[8] as! NSArray)[0] as! String
                ]
                ])
            allBasketBallArray.add(model)
        }
        self.filterArray()
    }
    
    @objc func filterArray(){
        self.basketBallArray.removeAllObjects()
        if CacheManager.getSharedInstance().getBasketBallEventSelectModel() != nil {
            for str in CacheManager.getSharedInstance().getBasketBallEventSelectModel()!.allKeys{
                let array = CacheManager.getSharedInstance().getBasketBallEventSelectModel()!.object(forKey: str) as! NSArray
                for temp in array {
                    let array = allBasketBallArray.filter { (dic) -> Bool in
                        return (dic as! BasketBallModel).basketballEvent!.id == ((temp as! NSDictionary).object(forKey: "id") as! Int)
                    }
                    self.basketBallArray.addObjects(from: array)
                }
                
            }
        }else{
            self.basketBallArray = self.allBasketBallArray.mutableCopy() as! NSMutableArray
        }
        
        self.basketBallArray = NSMutableArray.init(array: self.basketBallArray.sorted { (dic, dic1) -> Bool in
            return (dic as! BasketBallModel).time < (dic1 as! BasketBallModel).time
            } as NSArray)
        self.reloadTableViewData()
    }
    
    func socketUpdateData(match:NSArray, model:BasketBallModel){
        model.status = (match[2] as! Int)
        model.allSecond = (match[5] as! Int)
        model.basketBallTeamA.first = ((match[6] as! NSArray)[1] as! Int)
        model.basketBallTeamA.second = ((match[6] as! NSArray)[2] as! Int)
        model.basketBallTeamA.third = ((match[6] as! NSArray)[3] as! Int)
        model.basketBallTeamA.four = ((match[6] as! NSArray)[4] as! Int)
        model.basketBallTeamA.overtime = ((match[6] as! NSArray)[5] as! Int)
        model.basketballTeamB.first = ((match[7] as! NSArray)[1] as! Int)
        model.basketballTeamB.second = ((match[7] as! NSArray)[2] as! Int)
        model.basketballTeamB.third = ((match[7] as! NSArray)[3] as! Int)
        model.basketballTeamB.four = ((match[7] as! NSArray)[4] as! Int)
        model.basketballTeamB.overtime = ((match[7] as! NSArray)[5] as! Int)
    }
    
}

extension BasketBallViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (viewDesc == ScoreDetailTypeVC.competition || viewDesc == ScoreDetailTypeVC.amidithion) && section == 0 {
            return 0.00001
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
}

extension BasketBallViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.basketBallArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketBallTableViewCell.description(), for: indexPath)
        self.tableViewBasketBallTableViewCellSetData(indexPath, cell: cell as! BasketBallTableViewCell)
        cell.selectionStyle = .none
        return cell
    }
}

