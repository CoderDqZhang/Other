//
//  GloableView.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/9.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import Foundation

class GloableLineLabel: UIView {
    
    class func createLineLabel(frame:CGRect) -> UILabel{
        let lable = UILabel.init(frame: frame)
        lable.backgroundColor = App_Theme_F6F6F6_Color
        return lable
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
