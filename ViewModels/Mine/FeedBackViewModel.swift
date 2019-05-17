//
//  FeedBackViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class FeedBackViewModel: BaseViewModel {
    
    let titles = ["反馈内容","用户昵称","联系方式"]
    let placeholders = ["请输入反馈内容","请输入用户昵称","请输入联系方式"]
    override init() {
        super.init()
    }
    
    func tableViewGloabelTextFieldTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelTextFieldTableViewCell) {
        cell.cellSetData(placeholder: placeholders[indexPath.section])
    }
    
    func tableViewGloabelTextViewTableViewCellSetData(_ indexPath:IndexPath, cell:GloabelTextViewTableViewCell) {
        cell.cellSetData(placeholder: placeholders[indexPath.section])
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
}


extension FeedBackViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = YYLabel.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 20))
        label.text = titles[section]
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 190
        }
        return 47
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension FeedBackViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GloabelTextViewTableViewCell.description(), for: indexPath)
            self.tableViewGloabelTextViewTableViewCellSetData(indexPath, cell: cell as! GloabelTextViewTableViewCell)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: GloabelTextFieldTableViewCell.description(), for: indexPath)
        self.tableViewGloabelTextFieldTableViewCellSetData(indexPath, cell: cell as! GloabelTextFieldTableViewCell)
        return cell
    }
}
