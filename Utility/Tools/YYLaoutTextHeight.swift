//
//  YYLaoutTextHeight.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/26.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class YYLaoutTextGloabelManager: NSObject {
    private static let _sharedInstance = YYLaoutTextGloabelManager()
    
    class func getSharedInstance() -> YYLaoutTextGloabelManager {
        return _sharedInstance
    }
    
    private override init() {} // 私有化init方法
    
    func setYYLabelTextBound(font:UIFont, size:CGSize,  str:String, yyLabel:YYLabel) ->YYTextLayout {
        let tempStr = NSMutableAttributedString.init(string: str)
        tempStr.yy_font = font
        tempStr.yy_lineSpacing = 8
        yyLabel.attributedText = tempStr
        yyLabel.textLayout = (YYTextLayout.init(containerSize: size, text: tempStr))
        yyLabel.frame.size = yyLabel.textLayout!.textBoundingSize

        yyLabel.snp.makeConstraints { (make) in
            make.height.equalTo((yyLabel.textLayout?.textBoundingSize.height)!)
        }
        return (YYTextLayout.init(containerSize: size, text: tempStr)!)
    }
}

