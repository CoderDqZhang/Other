//
//  FootBallViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class FootBallViewModel: BaseViewModel {

    var viewType:ScoreDetailVC!
    var viewDesc:ScoreDetailTypeVC!
    
    var footballDic:NSDictionary!
    
    var footBallArray = NSMutableArray.init()
    var allFootBallArray =  NSMutableArray.init()
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(self.filterArray), name: NSNotification.Name.init(RELOADFILTERFOOTBALLMODEL), object: nil)
    }
    
    func tableViewScoreInfoTableViewCellSetData(_ indexPath:IndexPath, cell:ScoreInfoTableViewCell) {
        if self.footBallArray.count > 0 {
            cell.cellSetData(model:  self.footBallArray[indexPath.section] as! FootBallModel)
        }
    }
    
    func tableViewScoreListTableViewCellSetData(_ indexPath:IndexPath, cell:ScoreListTableViewCell) {
        if self.footBallArray.count > 0 {
            cell.cellSetData(model:  self.footBallArray[indexPath.section] as! FootBallModel)
            cell.scoreListTableViewCellClouse = { type,model in
                self.saveCollectModel(type, model)
            }
        }
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
    
    func saveCollectModel(_ type:ScoreListCollectType, _ model:FootBallModel){
        
        DispatchQueue.global(qos: .default).sync {
            var selectArray:NSMutableArray!
            if CacheManager.getSharedInstance().getFootBallMatchCollectModel() != nil{
                selectArray = CacheManager.getSharedInstance().getFootBallMatchCollectModel()!
            }else{
                selectArray = NSMutableArray.init()
            }
            if type == .select {
                model.isSelect = true
                selectArray.add(model)
            }else{
                let temp_array = selectArray.filter({ (dic) -> Bool in
                    return (dic as! FootBallModel).id != model.id
                })
                selectArray = NSMutableArray.init(array: temp_array)
            }
            CacheManager.getSharedInstance().saveFootBallMatchCollectModel(point: selectArray)
            NotificationCenter.default.post(name: NSNotification.Name.init(RELOADCOLLECTFOOTBALLMODEL), object: nil)
        }
    }
    
    override func tapViewNoneData() {
        if self.viewDesc != .attention {
            (self.controller as! FootBallViewController).getNetWorkData()
        }else{
            self.filterArray()
        }
    }
    
    func socketData(){
        SocketManager.getSharedInstance().single?.observe { (dic) in
            if (dic.value as! NSDictionary).object(forKey: "type") as! Int == 1 {
                let matchs = (dic.value as! NSDictionary).object(forKey: "data")
                if (dic.value as! NSDictionary).object(forKey: "data") is NSArray {
                    for match in matchs as! NSArray {
                        let footBall = self.footBallArray.filter({ (model) -> Bool in
                            return (model as! FootBallModel).id == (match as! Array)[0]
                        })
                        self.socketUpdateData(match: match as! NSArray, model: footBall[0] as! FootBallModel)
                    }
                    self.reloadTableViewData()
                }
            }
        }
    }
    
    func getFootBallNet(type:String, date:String){
        let parameters = ["type":type, "date":date] as [String : Any]
        BaseNetWorke.getSharedInstance().postUrlWithString(FootBallMatchUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if resultDic.value is NSArray {
                    self.allFootBallArray.removeAllObjects()
                    self.footBallBindText(resultDic.value as! NSArray)
                }
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
    
    func getFootInfoBallNet(type:String, date:String){
        let parameters = ["date":date] as [String : Any]
        var temp_dic =  CacheManager.getSharedInstance().getFootBallInfoModel()
        if temp_dic == nil || temp_dic?.object(forKey: date) == nil {
            BaseNetWorke.getSharedInstance().postUrlWithString(FootBallInfoUrl, parameters: parameters as AnyObject).observe { (resultDic) in
                if !resultDic.isCompleted {
                    if temp_dic == nil {
                        temp_dic = NSMutableDictionary.init(dictionary:  [date:resultDic.value as! NSDictionary])
                    }else{
                        temp_dic?.setValue(resultDic.value , forKey: date)
                    }
                    CacheManager.getSharedInstance().saveFootBallInfoModel(point: temp_dic!)
                    self.footballDic = NSDictionary.init(dictionary:(temp_dic?.object(forKey: date) as! NSDictionary))
                    self.getFootBallNet(type: type, date: date)
                }
            }
        }else{
            footballDic = (temp_dic?.object(forKey: date) as! NSDictionary)
            self.getFootBallNet(type: type, date: date)
        }
        
    }
    
    func footBallBindText(_ dic:NSArray){
         DispatchQueue.global(qos: .default).sync {
            UserDefaults.standard.set(dic.count, forKey: ALLFOOTBALLMACTH)
            for match in dic{
                let temp_array = (match as! NSArray)
                //去除阶段为0 错误
                let north_sigle:NSDictionary = (footballDic.object(forKey: "northOdd") as! NSDictionary).object(forKey: "\(temp_array[0])") != nil ? (footballDic.object(forKey: "northOdd") as! NSDictionary).object(forKey: "\(temp_array[0])") as! NSDictionary : [:]
                let lottery:NSDictionary = (footballDic.object(forKey: "footballLottery") as! NSDictionary).object(forKey: "\(temp_array[0])") != nil ? (footballDic.object(forKey: "footballLottery") as! NSDictionary).object(forKey: "\(temp_array[0])") as! NSDictionary : [:]
                let model = FootBallModel.init(fromDictionary: [
                    "id": temp_array[0] as! Int,
                    "event_info": (footballDic.object(forKey: "events") as! NSDictionary).object(forKey: "\(temp_array[1])") == nil ? [:] : (footballDic.object(forKey: "events") as! NSDictionary).object(forKey: "\(temp_array[1])")!,
                    "status": temp_array[2] as! Int,
                    "start_time": temp_array[3] as! Int,
                    "time": temp_array[4] as! Int,
                    "is_select" : false,
                    "teamA": [
                        "score": (temp_array[5] as! NSArray)[2] as! Int,
                        "corner_ball": (temp_array[5] as! NSArray)[6] as! Int,
                        "add_time_score": (temp_array[5] as! NSArray)[8] as! Int,
                        "half_score": (temp_array[5] as! NSArray)[3] as! Int,
                        "point_score": (temp_array[5] as! NSArray)[6] as! Int,
                        "half_red": (temp_array[5] as! NSArray)[4] as! Int,
                        "sort": (temp_array[5] as! NSArray)[1] as! String,
                        "team_name":(temp_array[5] as! NSArray)[9] as! String,
                        "half_yellow": (temp_array[5] as! NSArray)[5] as! Int,
                        "teams_info": [],
                        "id":(temp_array[5] as! NSArray)[0] as! Int
                    ],
                    "teamB": [
                        "score": (temp_array[6] as! NSArray)[2] as! Int,
                        "corner_ball": (temp_array[6] as! NSArray)[6] as! Int,
                        "add_time_score": (temp_array[6] as! NSArray)[8] as! Int,
                        "half_score": (temp_array[6] as! NSArray)[3] as! Int,
                        "point_score": (temp_array[6] as! NSArray)[6] as! Int,
                        "half_red": (temp_array[6] as! NSArray)[4] as! Int,
                        "sort": (temp_array[6] as! NSArray)[1] as! String,
                        "team_name":(temp_array[6] as! NSArray)[9] as! String,
                        "half_yellow": (temp_array[6] as! NSArray)[5] as! Int,
                        "teams_info": [],
                        "id":(temp_array[5] as! NSArray)[0] as! Int
                    ],
                    "remark": [
                        "remark_detail": (temp_array[7] as! NSArray)[0] as! String,
                        "is_center": (temp_array[7] as! NSArray)[1] as! Int,
                        "number_row": (temp_array[7] as! NSArray)[2] as! Int,
                    ],
                    "season": [
                        "id": (temp_array[8] as! NSArray)[0] as! Int,
                        "year": (temp_array[8] as! NSArray)[1] as! String
                    ],
                    "north_sigle":north_sigle,
                    "lottery":lottery,
                    "stage": [
                        "stage_info": [],
                        "number_row": 0,
                        "number_column": 0
                    ]
                    ])
                allFootBallArray.add(model)
            }
            self.filterArray()
        }
    }
    
    @objc func filterArray(){
        DispatchQueue.global(qos: .default).sync {
            self.footBallArray.removeAllObjects()
            if CacheManager.getSharedInstance().getFootBallEventSelectModel() != nil {
                for str in CacheManager.getSharedInstance().getFootBallEventSelectModel()!.allKeys{
                    let array = CacheManager.getSharedInstance().getFootBallEventSelectModel()!.object(forKey: str) as! NSArray
                    for temp in array {
                        let array = allFootBallArray.filter { (dic) -> Bool in
                            return (dic as! FootBallModel).eventInfo!.id == ((temp as! NSDictionary).object(forKey: "id") as! Int)
                        }
                        self.footBallArray.addObjects(from: array)
                    }
                    
                }
            }else{
                self.footBallArray = self.allFootBallArray.mutableCopy() as! NSMutableArray
            }
            
            if CacheManager.getSharedInstance().getFootBallMatchCollectModel() != nil {
                let select_array = CacheManager.getSharedInstance().getFootBallMatchCollectModel()!
                let ids = NSMutableArray.init()
                for model in select_array {
                    ids.add((model as! FootBallModel).id!)
                }
                if self.viewDesc == .attention {
                    self.footBallArray = select_array.mutableCopy() as! NSMutableArray
                    self.hiddenMJLoadMoreData(resultData: self.footBallArray)
                }else{
                    for temp_array in self.footBallArray {
                        let ret = ids.contains((temp_array as! FootBallModel).id!)
                        (temp_array as! FootBallModel).isSelect = ret
                    }
                }
            }
            
            self.footBallArray = NSMutableArray.init(array: self.footBallArray.sorted { (dic, dic1) -> Bool in
                return (dic as! FootBallModel).startTime < (dic1 as! FootBallModel).startTime
                } as NSArray)
            self.reloadTableViewData()
        }
        
    }
    
    func socketUpdateData(match:NSArray, model:FootBallModel){
        model.status = (match[2] as! Int)
        model.teamA.score = ((match[5] as! NSArray)[2] as! Int)
        model.teamA.cornerBall = ((match[5] as! NSArray)[6] as! Int)
        model.teamA.addTimeScore = ((match[5] as! NSArray)[8] as! Int)
        model.teamA.halfScore = ((match[5] as! NSArray)[3] as! Int)
        model.teamA.halfRed = ((match[5] as! NSArray)[4] as! Int)
        model.teamA.halfYellow = ((match[5] as! NSArray)[5] as! Int)
        model.teamB.score = ((match[6] as! NSArray)[2] as! Int)
        model.teamB.cornerBall = ((match[6] as! NSArray)[6] as! Int)
        model.teamB.addTimeScore = ((match[6] as! NSArray)[8] as! Int)
        model.teamB.halfScore = ((match[6] as! NSArray)[3] as! Int)
        model.teamB.halfRed = ((match[6] as! NSArray)[4] as! Int)
        model.teamB.halfYellow = ((match[6] as! NSArray)[5] as! Int)
    }
}

extension FootBallViewModel: UITableViewDelegate {
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
        if indexPath.row == 0 {
            return 64
        }
        return 20
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 64
        }
        return 20
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
}

extension FootBallViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return footBallArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dic = self.footBallArray[section]
        var model:FootBallModel!
        if dic is NSDictionary {
            model = FootBallModel.init(fromDictionary: dic as! [String : Any])
        }
        if model == nil {
            return 1
        }
        return model.remark.remarkDetail == "" ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ScoreListTableViewCell.description(), for: indexPath)
            self.tableViewScoreListTableViewCellSetData(indexPath, cell: cell as! ScoreListTableViewCell)
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: ScoreInfoTableViewCell.description(), for: indexPath)
        self.tableViewScoreInfoTableViewCellSetData(indexPath, cell: cell as! ScoreInfoTableViewCell)
        cell.selectionStyle = .none
        return cell
    }
}


