//
//  UITabarBadgeExtentions.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import Foundation

extension UITabBar {
    func showBadgeOnItemIndex(index:Int){
        let bageView = UIView.init()
        bageView.tag = index + 888
        bageView.cornerRadius = 5
        bageView.backgroundColor = App_Theme_FF584F_Color
        
        let frameX = (3.0 * CGFloat(index) - 2.0 ) * SCREENWIDTH / CGFloat(self.items!.count * 3)
        
        bageView.frame = CGRect.init(x: frameX + 30, y: 5, width: 8, height: 8)
        self.addSubview(bageView)
    }
    
    func hideBadgeOnItemIndex(index:Int){
        self.removeBadgeOnItemIndex(index: index)
    }
    
    func removeBadgeOnItemIndex(index:Int) {
        for subView in self.subviews {
            if subView.tag == index + 888 {
                subView.removeFromSuperview()
            }
        }
    }
}
