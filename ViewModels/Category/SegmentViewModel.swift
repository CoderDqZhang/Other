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
        
    }
    
    func pushPostDetailViewController(_ data:NSDictionary, _ type:ArticleTypeModel, _ indexPath:IndexPath) {
        let controllerVC = ArticleDetailViewController.init()
        controllerVC.articleData = data
        NavigationPushView(self.controller!, toConroller: controllerVC)
    }
    
    func getArticleType(){
        BaseNetWorke.getSharedInstance().postUrlWithString(ArticleTypeUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                let models = NSMutableArray.init(array: resultDic.value as! Array)
                var titles:[String] = []
                for model in models {
                    titles.append((model as! NSDictionary).object(forKey: "value") as! String)
                }
                
                (self.controller! as! SegmentViewController).squareViewController.titles = titles
                (self.controller! as! SegmentViewController).squareViewController.articleTypeArray = models
                (self.controller! as! SegmentViewController).squareViewController.initSView(type: 0)
                
            }
        }
    }
}
