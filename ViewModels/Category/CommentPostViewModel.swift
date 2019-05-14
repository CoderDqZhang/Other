//
//  CommentPostViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/14.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
//with = 375 height = 247
let CommentTextViewCcale:CGFloat = 247 / 375

class CommentPostViewModel: BaseViewModel {
    
    var selectImage:[UIImage] = []
    override init() {
        super.init()
    }
    
    func tableViewPostCommentImagesTableViewCellSetData(_ indexPath:IndexPath, cell:PostCommentImagesTableViewCell){
        cell.cellSetData(images: selectImage)
        cell.postCommentImageAddButtonClouse = { btn in
            let alerController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
            alerController.addAction(title: "相册", style: .default, isEnabled: true, handler: { (ret) in
                
            })
            alerController.addAction(title: "拍照", style: .default, isEnabled: true, handler: { (ret) in
                
            })
            alerController.addAction(title: "取消", style: .cancel, isEnabled: true, handler: { (ret) in
                
            })
            NavigaiontPresentView(self.controller!, toController: alerController)
        }
    }
    
    func tableViewPostCommentTextTableViewCellSetData(_ indexPath:IndexPath, cell:PostCommentTextTableViewCell) {
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
        
    }
}


extension CommentPostViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    // 375 / 247
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return SCREENWIDTH * CommentTextViewCcale
        
        default:
            return PostImageSelectViewHeight + 24
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return SCREENWIDTH * CommentTextViewCcale
            
        default:
            return PostImageSelectViewHeight + 24
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension CommentPostViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostCommentTextTableViewCell.description(), for: indexPath)
            self.tableViewPostCommentTextTableViewCellSetData(indexPath, cell: cell as! PostCommentTextTableViewCell)
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostCommentImagesTableViewCell.description(), for: indexPath)
            self.tableViewPostCommentImagesTableViewCellSetData(indexPath, cell: cell as! PostCommentImagesTableViewCell)
            cell.selectionStyle = .none
            return cell
        }
    }
}
