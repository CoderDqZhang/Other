//
//  FootBallViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class FootBallViewModel: BaseViewModel {

    var viewType:ScoreDetailVC!
    var viewDesc:ScoreDetailTypeVC!
    
    var footBallArray = NSMutableArray.init()
    override init() {
        super.init()
    
    }
    
    func tableViewScoreInfoTableViewCellSetData(_ indexPath:IndexPath, cell:ScoreInfoTableViewCell) {
        if self.footBallArray.count > 0 {
            let dic = self.footBallArray[indexPath.section]
            if dic is NSDictionary {
                cell.cellSetData(model: FootBallModel.init(fromDictionary: self.footBallArray[indexPath.section] as! [String : Any]))
            }else{
                cell.cellSetData(model:  self.footBallArray[indexPath.section] as! FootBallModel)
            }
        }
    }
    
    func tableViewScoreListTableViewCellSetData(_ indexPath:IndexPath, cell:ScoreListTableViewCell) {
        if self.footBallArray.count > 0 {
            let dic = self.footBallArray[indexPath.section]
            if dic is NSDictionary {
                cell.cellSetData(model: FootBallModel.init(fromDictionary: self.footBallArray[indexPath.section] as! [String : Any]))
            }else{
                cell.cellSetData(model:  self.footBallArray[indexPath.section] as! FootBallModel)
            }
        }
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
    
    func getFootBallNet(type:String, date:String){
        let parameters = ["type":type, "date":date] as [String : Any]
        BaseNetWorke.getSharedInstance().postUrlWithString(FootBallInfoUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.footBallArray = NSMutableArray.init(array: resultDic.value as! Array)
                self.reloadTableViewData()
            }
        }
    }
    
    func getFoot1BallNet(type:String, date:String){
        let parameters = ["type":type, "date":date] as [String : Any]
        BaseNetWorke.getSharedInstance().postUrlWithString(FootBallInfoTestUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.footBallBindText(resultDic.value as! NSDictionary)
            }
        }
    }
    
    func footBallBindText(_ dic:NSDictionary){
        for match in (dic.object(forKey: "matches") as! NSArray){
            let temp_array = (match as! NSArray)
            //去除阶段为0 错误
            let stage = (temp_array[9] as! NSArray)[0] as! Int != 0 ? (dic.object(forKey: "stages") as! NSDictionary).object(forKey: "\((temp_array[9] as! NSArray)[0])")! : []
            let model = FootBallModel.init(fromDictionary: [
                "id": temp_array[0] as! Int,
                "event_info": (dic.object(forKey: "events") as! NSDictionary).object(forKey: "\(temp_array[1])")!,
                "status": temp_array[2] as! Int,
                "start_time": temp_array[3] as! Int,
                "time": temp_array[4] as! Int,
                "teamA": [
                    "score": (temp_array[5] as! NSArray)[2] as! Int,
                    "corner_ball": (temp_array[5] as! NSArray)[6] as! Int,
                    "add_time_score": (temp_array[5] as! NSArray)[8] as! Int,
                    "half_score": (temp_array[5] as! NSArray)[3] as! Int,
                    "point_score": (temp_array[5] as! NSArray)[6] as! Int,
                    "half_red": (temp_array[5] as! NSArray)[4] as! Int,
                    "sort": (temp_array[5] as! NSArray)[1] as! String,
                    "half_yellow": (temp_array[5] as! NSArray)[5] as! Int,
                    "teams_info": (dic.object(forKey: "teams") as! NSDictionary).object(forKey: "\((temp_array[5] as! NSArray)[0])")
                ],
                "teamB": [
                    "score": (temp_array[6] as! NSArray)[2] as! Int,
                    "corner_ball": (temp_array[6] as! NSArray)[6] as! Int,
                    "add_time_score": (temp_array[6] as! NSArray)[8] as! Int,
                    "half_score": (temp_array[6] as! NSArray)[3] as! Int,
                    "point_score": (temp_array[6] as! NSArray)[6] as! Int,
                    "half_red": (temp_array[6] as! NSArray)[4] as! Int,
                    "sort": (temp_array[6] as! NSArray)[1] as! String,
                    "half_yellow": (temp_array[6] as! NSArray)[5] as! Int,
                    "teams_info": (dic.object(forKey: "teams") as! NSDictionary).object(forKey: "\((temp_array[6] as! NSArray)[0])")
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
                "stage": [
                    "stage_info": stage,
                    "number_row": 0,
                    "number_column": 0
                ]])
            footBallArray.add(model)
        }
        self.reloadTableViewData()
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

extension FootBallViewModel : DZNEmptyDataSetDelegate {
    
}

extension FootBallViewModel : DZNEmptyDataSetSource {
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
