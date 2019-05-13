//
//  PostViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class PostDetailViewModel: BaseViewModel {

    var postType:PostType!
    var postData:NSDictionary!
    var commets = ["鲁尼也是一代红魔传送","鲁尼也是一代红魔传送","鲁尼也是一代红魔传送"]
    let testModel = [[SecondeModel.init(name: "中超小迪", content: "鲁尼也是一代红魔传说"),SecondeModel.init(name: "中超小迪", content: "鲁尼也是一代红魔传说")],[SecondeModel.init(name: "中超小迪", content: "鲁尼也是一代红魔传说")],[]]
    override init() {
        super.init()
    }
    
    func tableViewPostDetailUserInfoTableViewCellSetData(_ indexPath:IndexPath, cell:PostDetailUserInfoTableViewCell) {
        cell.postDetailUserInfoClouse = {
            print("关注")
        }
    }
    
    func tableViewPostDetailContentTableViewCellSetData(_ indexPath:IndexPath, cell:PostDetailContentTableViewCell) {
        cell.cellSetData(title: "齐达内二进宫的预期成绩会是欧冠冠军吗？", content: postData.object(forKey: "contentStrs") as! String, images: postData.object(forKey: "images") as! [String])
        cell.postDetailContentTableViewCellClouse = { type in
            switch type {
            case .like:
                 print("点赞")
            default:
                 print("收藏")
            }
        }
    }
    
    func tableViewPostDetailCommentTableViewCellSetData(_ indexPath:IndexPath, cell:PostDetailCommentTableViewCell) {
        cell.cellSetData(images: [], secondeContents: testModel[indexPath.row], content: self.commets[indexPath.row])
    }
    
    func tableViewPostDetailCommentUserTableViewCellSetData(_ indexPath:IndexPath, cell:PostDetailCommentUserTableViewCell){
        cell.postDetailCommentUserTableViewCellClouse = {
            
        }
    }
    
    func tableViewHotDetailTableViewCellSetData(_ indexPath:IndexPath, cell:HotDetailTableViewCell) {
        cell.cellSetData(detail: "全部回复", number: "66")
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
}


extension PostDetailViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 5
        }
        return 0.001
    }
    
    // 165 / 375
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return 60
            }
            return tableView.fd_heightForCell(withIdentifier: PostDetailContentTableViewCell.description(), cacheBy: indexPath, configuration: { (cell) in
                self.tableViewPostDetailContentTableViewCellSetData(indexPath, cell: cell as! PostDetailContentTableViewCell)
            })
        case 1:
            return 32
        default:
            if indexPath.row == 0 {
                return 56
            }
            return tableView.fd_heightForCell(withIdentifier: PostDetailCommentTableViewCell.description(), cacheBy: indexPath, configuration: { (cell) in
                self.tableViewPostDetailCommentTableViewCellSetData(indexPath, cell: cell  as! PostDetailCommentTableViewCell)
            })
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return 60
            }
            return 150
        case 1:
            return 32
        default:
            return 150
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension PostDetailViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return commets.count + 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailUserInfoTableViewCell.description(), for: indexPath)
                self.tableViewPostDetailUserInfoTableViewCellSetData(indexPath, cell: cell as! PostDetailUserInfoTableViewCell)
                cell.selectionStyle = .none
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailContentTableViewCell.description(), for: indexPath)
            self.tableViewPostDetailContentTableViewCellSetData(indexPath, cell: cell as! PostDetailContentTableViewCell)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: HotDetailTableViewCell.description(), for: indexPath)
            self.tableViewHotDetailTableViewCellSetData(indexPath, cell: cell as! HotDetailTableViewCell)
            cell.selectionStyle = .none
            return cell
        default:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailCommentUserTableViewCell.description(), for: indexPath)
                self.tableViewPostDetailCommentUserTableViewCellSetData(indexPath, cell: cell as! PostDetailCommentUserTableViewCell)
                cell.selectionStyle = .none
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailCommentTableViewCell.description(), for: indexPath)
            self.tableViewPostDetailCommentTableViewCellSetData(indexPath, cell: cell as! PostDetailCommentTableViewCell)
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension PostDetailViewModel : DZNEmptyDataSetDelegate {
    
}

extension PostDetailViewModel : DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributed = "暂时还没有数据哦！"
        let attributedString = NSMutableAttributedString.init(string: attributed)
        attributedString.addAttributes([NSAttributedString.Key.font:App_Theme_PinFan_M_16_Font!,NSAttributedString.Key.foregroundColor:App_Theme_CCCCCC_Color ?? ""], range: NSRange.init(location: 0, length: 9))
        
        return attributedString
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "pic_toy")
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -64
    }
}
