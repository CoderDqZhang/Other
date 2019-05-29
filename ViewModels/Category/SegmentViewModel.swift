//
//  SegmentViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

enum PostType {
    case Hot //最新
    case OutFall //出墙
}

enum CategoryType {
    case BasketBall //篮球
    case FootBall //足球
    case BasketBallEurope //篮球
    case FootBallEurope //足球
}
//点击ftableViewCell数据返回
typealias CategoryDetailDataClouse =  (_ obj:NSDictionary, _ type:CategoryType) ->Void

class SegmentViewModel: BaseViewModel {

    override init() {
        super.init()
    }
    
    func pushPostVC(){
        let postVC = PostViewController()
        let postNavigationController = UINavigationController.init(rootViewController: postVC)
        NavigaiontPresentView(self.controller!, toController: postNavigationController)
    }
    
    func pushCategoryDetailViewController(_ data:NSDictionary, _ type:CategoryType){
        let categoryDetail = CategoryDetailViewController()
        categoryDetail.categoryData = data
        categoryDetail.categoryType = type
        NavigationPushView(self.controller!, toConroller: categoryDetail)
    }
    
    func pushPostDetailViewController(_ data:NSDictionary, _ type:PostType) {
        let postDetail = PostDetailViewController()
        postDetail.postData = data
        postDetail.postType = type
        NavigationPushView(self.controller!, toConroller: postDetail)
    }
}
