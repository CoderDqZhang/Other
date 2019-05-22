//
//  UITextFieldExtentions.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/13.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import Foundation
extension UITextField{
    
    //MARK:-设置暂位文字的颜色
    var placeholderColor:UIColor {
        
        get{
            let color =   self.value(forKeyPath: "_placeholderLabel.textColor")
            if(color == nil){
                return UIColor.white;
            }
            return color as! UIColor;
            
        }
        
        set{
            
            self.setValue(newValue, forKeyPath: "_placeholderLabel.textColor")
        }
        
        
    }
    
    //MARK:-设置暂位文字的字体
    var placeholderFont:UIFont{
        get{
            let font =   self.value(forKeyPath: "_placeholderLabel.font")
            if(font == nil){
                return UIFont.systemFont(ofSize: 14);
            }
            return font as! UIFont;
        }
        set{
            self.setValue(newValue, forKeyPath: "_placeholderLabel.font")
        }
        
    }
}

