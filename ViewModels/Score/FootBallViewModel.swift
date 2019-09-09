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
    
    var isCollectSelect:Bool! = false
    var isRefreshData:Bool! = false
    
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
                self.isCollectSelect = true
                self.saveCollectModel(type, model)
                self.isCollectSelect = false
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
            if dic.value is NSDictionary {
                if (dic.value as! NSDictionary).object(forKey: "type") != nil && (dic.value as! NSDictionary).object(forKey: "type") as! Int == 2 {
                    let matchs = (dic.value as! NSDictionary).object(forKey: "data")
                    if (dic.value as! NSDictionary).object(forKey: "data") is NSArray {
                        for match in matchs as! NSArray {
                            if self.footBallArray.count > 0 {
                                let footBall = self.footBallArray.filter({ (model) -> Bool in
                                    return (model as! FootBallModel).id! == ((match as! NSArray)[0] as! Int)
                                })
                               
                                if footBall.count > 0 {
                                    self.socketUpdateData(match: match as! NSArray, model: footBall[0] as! FootBallModel)
                                }
                            }
                        }
                        self.reloadTableViewData()
                    }
                }
            }
        }
    }
    
    func getFootBallNet(type:String, date:String){
        let parameters = ["type":type, "date":date] as [String : Any]
        BaseNetWorke.getSharedInstance().getUrlWithString(FootBallMatchUrl, parameters: parameters as AnyObject).observe { (resultDic) in
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
//        if temp_dic == nil || temp_dic?.object(forKey: date) == nil {
            BaseNetWorke.getSharedInstance().getUrlWithString(FootBallInfoUrl, parameters: parameters as AnyObject).observe { (resultDic) in
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
//        }else{
//            footballDic = (temp_dic?.object(forKey: date) as! NSDictionary)
//            self.getFootBallNet(type: type, date: date)
//        }
        
    }
    
    func footBallBindText(_ dic:NSArray){
        self.allFootBallArray.removeAllObjects()
         DispatchQueue.global(qos: .default).sync {
            for index in 0...dic.count - 1{
                let temp_array = (dic[index] as! NSArray)
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
            let selectEvent:NSMutableArray = NSMutableArray.init()
            var select_array:NSMutableArray = NSMutableArray.init()
            let ids = NSMutableArray.init()
            if CacheManager.getSharedInstance().getFootBallMatchCollectModel() != nil {
                select_array = CacheManager.getSharedInstance().getFootBallMatchCollectModel()!
                for model in select_array {
                    ids.add((model as! FootBallModel).id!)
                }
            }
            
            if self.viewDesc == .attention {
                self.footBallArray = select_array.mutableCopy() as! NSMutableArray
                self.hiddenMJLoadMoreData(resultData: self.footBallArray)
            }else{
                if CacheManager.getSharedInstance().getFootBallEventSelectModel() != nil {
                    for str in CacheManager.getSharedInstance().getFootBallEventSelectModel()!.allKeys{
                        let array = CacheManager.getSharedInstance().getFootBallEventSelectModel()!.object(forKey: str) as! NSArray
                        for temp in array {
                            selectEvent.add((temp as! NSDictionary).object(forKey: "id")!)
                        }
                    }
                }
                
                for item in self.allFootBallArray {
                    let isContains = selectEvent.contains((item as! FootBallModel).eventInfo.id as Any)
                    if isContains || selectEvent.count == 0 {
                        
                        let ret = ids.contains((item as! FootBallModel).id!)
                        (item as! FootBallModel).isSelect = ret
                        //替换收藏模型数据
                        if select_array.count > 0 {
                            for index in 0...select_array.count - 1{
                                if (select_array[index] as! FootBallModel).id == (item as! FootBallModel).id! {
                                    select_array.replaceObject(at: index, with: item)
                                }
                            }
                        }
                        //控制在进行中是不加入已完场赛事
                        if self.viewDesc == .underway && (item as! FootBallModel).status == 8 {
                            continue
                        }
                        self.footBallArray.add(item)
                    }
                }
                CacheManager.getSharedInstance().saveFootBallMatchCollectModel(point: select_array)
            }
            DispatchQueue.main.async {
                self.isRefreshData = false
                self.reloadTableViewData()
            }
        }
        
    }
    
    func socketUpdateData(match:NSArray, model:FootBallModel){
        if !self.isCollectSelect && !self.isRefreshData{
            if model.status == 8 {
                return
            }
            model.status = (match[1] as! Int)
            model.teamA.score = ((match[2] as! NSArray)[2] as! Int)
            model.teamA.cornerBall = ((match[2] as! NSArray)[6] as! Int)
            model.teamA.halfScore = ((match[2] as! NSArray)[3] as! Int)
            model.teamA.halfRed = ((match[2] as! NSArray)[4] as! Int)
            model.teamA.halfYellow = ((match[2] as! NSArray)[5] as! Int)
            model.teamB.score = ((match[3] as! NSArray)[2] as! Int)
            model.teamB.cornerBall = ((match[3] as! NSArray)[6] as! Int)
            model.teamB.halfScore = ((match[3] as! NSArray)[3] as! Int)
            model.teamB.halfRed = ((match[3] as! NSArray)[4] as! Int)
            model.teamB.halfYellow = ((match[3] as! NSArray)[5] as! Int)
            if (match[1] as! Int) == 8 {
                self.isRefreshData = true
                (self.controller! as! FootBallViewController).refreshData()
            }
        }
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
        return 4
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


