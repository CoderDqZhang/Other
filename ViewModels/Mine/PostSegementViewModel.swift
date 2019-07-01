//
//  PostSegementViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class PostSegementViewModel: BaseViewModel {

    override init() {
        super.init()
    }
    
    func pushPostDetailViewController(_ data:NSDictionary, _ type:PostType, _ gotoType:PostDetaiGoToType?) {
        let postDetail = PostDetailViewController()
        postDetail.postData = data
        postDetail.postType = type
        postDetail.gotoType = gotoType
        NavigationPushView(self.controller!, toConroller: postDetail)
    }
}
