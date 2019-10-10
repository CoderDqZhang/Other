//
//  CategorySearchViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/24.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit


class CategorySearchViewModel: BaseViewModel {

    var reslutArray:NSMutableArray!
    
    override init() {
        super.init()
    }
    
    func tableViewTagerUserTableViewCellSetData(_ indexPath:IndexPath, cell:TagerUserTableViewCell) {
        let dic = reslutArray[indexPath.row] as! NSDictionary
        cell.cellSetCatogyModel(model: CategoryModel.init(fromDictionary: dic as! [String : Any]))
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        if (self.controller as!  CategoryChoosSearchViewController).resultDicClouse != nil {
            (self.controller as!  CategoryChoosSearchViewController).resultDicClouse(reslutArray[indexPath.row] as! NSDictionary)
        }
    }
    
    func updateResultData(){
        
    }
}


extension CategorySearchViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
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

extension CategorySearchViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reslutArray == nil ? 0 : reslutArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TagerUserTableViewCell.description(), for: indexPath)
        self.tableViewTagerUserTableViewCellSetData(indexPath, cell: cell as! TagerUserTableViewCell)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
}

