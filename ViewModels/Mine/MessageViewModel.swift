//
//  MessageViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/27.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class MessageViewModel: BaseViewModel {

    override init() {
        super.init()
    }
    
    func pushPostDetailViewController(_ data:NSMutableDictionary, _ type:PostType, _ indexPath:IndexPath) {
        let postDetail = PostDetailViewController()
        postDetail.postData = data
        postDetail.postType = type
        NavigationPushView(self.controller!, toConroller: postDetail)
    }
}
