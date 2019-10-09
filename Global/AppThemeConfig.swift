//
//  AppThemeConfig.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

class AppleThemeTool {
    class func setUpToolBarColor() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:App_Theme_999999_Color ?? ""], for: UIControl.State())
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:App_Theme_FF7800_Color ?? ""], for: .selected)
        UITabBar.appearance().tintColor = App_Theme_FFCB00_Color
        UITabBar.appearance().backgroundColor = App_Theme_FFFFFF_Color
        
        UITabBar.appearance().shadowImage = UIImage.init(color: App_Theme_F6F6F6_Color!, size: CGSize.init(width: SCREENWIDTH, height: 1))
        UITabBar.appearance().backgroundImage = UIImage()

        UINavigationBar.appearance().tintColor = UIColor.white
        let gradient = CAGradientLayer()
        gradient.colors = [App_Theme_FFCD0D_Color!.cgColor,App_Theme_FFDC16_Color!.cgColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.0, y: 1)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        if #available(iOS 11.0, *) {
            gradient.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 64 + NAV_HEIGHT)
        } else {
            // Fallback on earlier versions
            gradient.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 64)
        }
        UINavigationBar.appearance().setBackgroundImage(AppleThemeTool.image(fromLayer: gradient), for: .default)
//        UINavigationBar.appearance().barTintColor = App_Theme_FFCB00_Color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font:App_Theme_PinFan_R_17_Font!,NSAttributedString.Key.foregroundColor:App_Theme_06070D_Color ?? ""]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font:App_Theme_PinFan_R_15_Font!,NSAttributedString.Key.foregroundColor:App_Theme_06070D_Color ?? ""], for: UIControl.State())
        UIApplication.shared.statusBarStyle = .default
        UINavigationBar.appearance().shadowImage = UIImage.init()
        UINavigationBar.appearance().isTranslucent = false

    }
    
    class func image(fromLayer layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }

    class func setUpKeyBoardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.registerTextFieldViewClass(YYTextView.self, didBeginEditingNotificationName: NSNotification.Name.YYTextViewTextDidBeginEditing.rawValue, didEndEditingNotificationName:NSNotification.Name.YYTextViewTextDidEndEditing.rawValue)
        IQKeyboardManager.shared.enableAutoToolbar = false
        //控制键盘上toolBar的字体颜色是否由用户自己控制
        IQKeyboardManager.shared.shouldToolbarUsesTextFieldTintColor = true
        //当有多个输入框的时，如何识别不同的输入框进行跳转
        IQKeyboardManager.shared.toolbarManageBehaviour = IQAutoToolbarManageBehaviour.bySubviews
        //是否显示键盘上的toolBar
        // Automatic add IQToolbar functionality. Default is YES.   自动添加IQToolbar的功能。默认为YES
        IQKeyboardManager.shared.enableAutoToolbar = true
        //是否将textField的placeholder显示
        /**
         If YES, then it add the textField's placeholder text on IQToolbar. Default is YES.
         */
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        IQKeyboardManager.shared.placeholderFont = App_Theme_PinFan_R_15_Font
        //输入框距离键盘顶部的距离
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 0.0
    }
}

