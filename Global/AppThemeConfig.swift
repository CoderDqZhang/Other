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
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:App_Theme_333333_Color ?? ""], for: UIControl.State())
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:App_Theme_FFCB00_Color ?? ""], for: .selected)
        UITabBar.appearance().tintColor = App_Theme_FFCB00_Color
        UITabBar.appearance().backgroundColor = App_Theme_FFFFFF_Color
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()

        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = App_Theme_FFCB00_Color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font:App_Theme_PinFan_R_17_Font!,NSAttributedString.Key.foregroundColor:App_Theme_06070D_Color ?? ""]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font:App_Theme_PinFan_R_15_Font!,NSAttributedString.Key.foregroundColor:App_Theme_06070D_Color ?? ""], for: UIControl.State())
        UIApplication.shared.statusBarStyle = .lightContent
//        UINavigationBar.appearance().setBackgroundImage(UIImage.init(color: UIColor.init(hexString: App_Theme_F94856_Color), size: CGSize.init(width: SCREENWIDTH, height: 64), for: .default))
        UINavigationBar.appearance().shadowImage = UIImage.init()
        UINavigationBar.appearance().isTranslucent = false

    }

    class func setUpKeyBoardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false

    }
}

