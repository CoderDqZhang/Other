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
    
    func pushCategoryDetailViewController(_ data:NSDictionary, _ type:CategoryType){
        
    }
    
    func pushPostDetailViewController(_ data:NSMutableDictionary, _ type:PostType, _ indexPath:IndexPath) {
        
    }
}
