//
//  BasketBallViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit


class BasketBallViewModel: BaseViewModel {

    var viewType:ScoreDetailVC!
    var viewDesc:ScoreDetailTypeVC!
    
    var basketBallArray = NSMutableArray.init()
    override init() {
        super.init()
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
        (self.controller as! FootBallViewController).getNetWorkData()
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
        BaseNetWorke.getSharedInstance().postUrlWithString(FootBallInfoUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.basketBallArray = NSMutableArray.init(array: resultDic.value as! Array)
                self.reloadTableViewData()
            }
        }
    }
    
    func getbasket1Net(type:String, date:String){
//        let parameters = ["type":type, "date":date] as [String : Any]
//        BaseNetWorke.getSharedInstance().postUrlWithString(FootBallInfoTestUrl, parameters: parameters as AnyObject).observe { (resultDic) in
//            if !resultDic.isCompleted {
//                self.basketBallBindText(resultDic.value as! NSDictionary)
//            }
//        }
    }
    
    func basketBallBindText(_ dic:NSDictionary){
        for match in (dic.object(forKey: "matches") as! NSArray){
            let temp_array = (match as! NSArray)
            let model = FootBallModel.init(fromDictionary: [
                "id": temp_array[0] as! Int,
                "section": temp_array[1] as! Int,
                "basketball_event": (dic.object(forKey: "events") as! NSDictionary).object(forKey: "\(temp_array[2])")!,
                "status": temp_array[3] as! Int,
                "time": temp_array[4] as! Int,
                "all_second": temp_array[5] as! Int,
                "basketBallteamA": [
                    "basketball_team_info": (dic.object(forKey: "teams") as! NSDictionary).object(forKey: "\((temp_array[6] as! NSArray)[0])"),
                    "sort": (temp_array[6] as! NSArray)[1] as! String,
                    "first": (temp_array[6] as! NSArray)[2] as! Int,
                    "second": (temp_array[6] as! NSArray)[3] as! Int,
                    "third": (temp_array[6] as! NSArray)[4] as! Int,
                    "four": (temp_array[6] as! NSArray)[5] as! Int,
                    "overtime": (temp_array[6] as! NSArray)[6] as! Int
                ],
                "basketball_teamB": [
                    "basketball_team_info": (dic.object(forKey: "teams") as! NSDictionary).object(forKey: "\((temp_array[7] as! NSArray)[0])"),
                    "sort": (temp_array[7] as! NSArray)[1] as! String,
                    "first": (temp_array[7] as! NSArray)[2] as! Int,
                    "second": (temp_array[7] as! NSArray)[3] as! Int,
                    "third": (temp_array[7] as! NSArray)[4] as! Int,
                    "four": (temp_array[7] as! NSArray)[5] as! Int,
                    "overtime": (temp_array[7] as! NSArray)[6] as! Int
                ],
                "basketball_remark": [
                    "remark_detail": (temp_array[8] as! NSArray)[0] as! String
                ]
            ])
            basketBallArray.add(model)
        }
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
        return 10
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

