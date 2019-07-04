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
        if CacheManager.getSharedInstance().isLogin() {
            let postVC = PostViewController()
            postVC.postViewControllerDataClouse = { dic in
                (self.controller! as! SegmentViewController).newController.newsViewModel.tipListArray.insert(dic, at: 0)
                (self.controller! as! SegmentViewController).newController.newsViewModel.reloadTableViewData()
            }
            let postNavigationController = UINavigationController.init(rootViewController: postVC)
            NavigaiontPresentView(self.controller!, toController: postNavigationController)
        }else{
            NavigationPushView(self.controller!, toConroller: LoginViewController())
        }
    }
    
    func pushCategoryDetailViewController(_ data:NSDictionary, _ type:CategoryType){
        let categoryDetail = CategoryDetailViewController()
        categoryDetail.categoryData = data
        categoryDetail.categoryType = type
        NavigationPushView(self.controller!, toConroller: categoryDetail)
    }
    
    func pushPostDetailViewController(_ data:NSMutableDictionary, _ type:PostType, _ indexPath:IndexPath) {
        let postDetail = PostDetailViewController()
        postDetail.changeAllCommentAndLikeNumberClouse = { type, status in
            if type == .comment {
                if status == .add {
                    data["commentTotal"] = data["commentTotal"] as! Int + 1
                }else{
                    data["commentTotal"] = data["commentTotal"] as! Int - 1
                }
            }else{
                if status == .add {
                    data["favor"] = data["favor"] as! Int + 1
                }else{
                    data["favor"] = data["favor"] as! Int - 1
                }
            }
            (self.controller as! SegmentViewController).changeCommentAndLikeNumber(data,indexPath)
        }
        postDetail.postData = data
        postDetail.postType = type
        NavigationPushView(self.controller!, toConroller: postDetail)
    }
}
