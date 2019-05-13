//
//  NewsViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class NewsViewModel: BaseViewModel {

    let contentStrs = ["你认为今年的中超冠军会是谁？","你认为今年的中超冠军会是谁？","你认为今年的中超冠军会是谁？你认为今年的中超冠军会是谁？你认为今年的中超冠军会是谁？你认为今年的中超冠军会是谁？","你认为今年的中超冠军会是谁？","你认为今年的中超冠军会是谁？","你认为今年的中超冠军会是谁？"]
    let images = [[],["https://placehold.jp/150x150.png","https://placehold.jp/150x150.png","https://placehold.jp/150x150.png"],[],["https://placehold.jp/150x150.png","https://placehold.jp/150x150.png"],["https://placehold.jp/150x150.png"]]
    
    let categoryType = [CategoryType.BasketBall,CategoryType.FootBall,CategoryType.FootBallEurope,CategoryType.BasketBallEurope]
    override init() {
        super.init()
    }
    
    func tableViewHotDetailTableViewCellSetData(_ indexPath:IndexPath, cell:HotDetailTableViewCell) {
        cell.cellSetData(detail: "热门讨论", number: "")
    }
    
    func tableViewCategoryTableViewCellSetData(_ indexPath:IndexPath, cell:CategoryTableViewCell) {
        cell.categoryTableViewCellClouseClick = { tag in
            let dic = NSDictionary.init(dictionary: ["contentStrs":self.contentStrs[tag],"images":self.images[tag]])
            (self.controller! as! NewsViewController).categoryDetailClouse(dic,self.categoryType[tag])
        }
    }
    
    func tableViewCategoryContentTableViewCellSetData(_ indexPath:IndexPath, cell:CategoryContentTableViewCell) {
        cell.cellSetData(content: contentStrs[indexPath.section - 2], images: images[indexPath.section - 2])
    }
    
    func tableViewUserInfoTableViewCellSetData(_ indexPath:IndexPath, cell:UserInfoTableViewCell){
        
    }
    
    func tableViewMCommentTableViewCellSetData(_ indexPath:IndexPath, cell:CommentTableViewCell){
        
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        if indexPath.row != 0 {
            let dicData = NSDictionary.init(dictionary: ["contentStrs":contentStrs[indexPath.section - 2],"images":images[indexPath.section - 2]], copyItems: true)
            (self.controller! as! NewsViewController).postDetailDataClouse(dicData,.OutFall)
        }
    }
}


extension NewsViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 1
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return CategoryViewHeight + 25
        case 1:
            return 32
        default:
            if indexPath.row == 0 {
                return 52
            }else if indexPath.row == 1 {
                return tableView.fd_heightForCell(withIdentifier: CategoryContentTableViewCell.description(), cacheBy: indexPath, configuration: { (cell) in
                    self.tableViewCategoryContentTableViewCellSetData(indexPath, cell: cell as! CategoryContentTableViewCell)
                })
               
            }
            return 32
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return CategoryViewHeight + 25
        case 1:
            return 32
        default:
            if indexPath.row == 0 {
                return 52
            }else if indexPath.row == 1{
                return 52
            }
            return 32
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension NewsViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return images.count + 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.description(), for: indexPath)
            self.tableViewCategoryTableViewCellSetData(indexPath, cell: cell as! CategoryTableViewCell)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: HotDetailTableViewCell.description(), for: indexPath)
            self.tableViewHotDetailTableViewCellSetData(indexPath, cell: cell as! HotDetailTableViewCell)
            cell.selectionStyle = .none
            return cell
        default:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoTableViewCell.description(), for: indexPath)
                self.tableViewUserInfoTableViewCellSetData(indexPath, cell: cell as! UserInfoTableViewCell)
                cell.selectionStyle = .none
                return cell
            }else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: CategoryContentTableViewCell.description(), for: indexPath)
                self.tableViewCategoryContentTableViewCellSetData(indexPath, cell: cell as! CategoryContentTableViewCell)
                cell.selectionStyle = .none
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.description(), for: indexPath)
            self.tableViewMCommentTableViewCellSetData(indexPath, cell: cell as! CommentTableViewCell)
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension NewsViewModel : DZNEmptyDataSetDelegate {
    
}

extension NewsViewModel : DZNEmptyDataSetSource {
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
