//
//  AppDelegate.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/7.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import Bugly
//#if DEBUG
//import CocoaDebug
//#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        AppleThemeTool.setUpToolBarColor()
        AppleThemeTool.setUpKeyBoardManager()
        
        Bugly.start(withAppId: BuglyAppId)
        
        //加载配置
        LoadConfigManger.getSharedInstance().setUp()
        //阿里云库
        AliPayManager.getSharedInstance().ossSetUp()
        //友盟推送显示
        UMengManager.getSharedInstance().setUpUMengManger(application, didFinishLaunchingWithOptions: launchOptions)
        //通知详情
        NotificationManager.getSharedInstance().setUpNotification(launchOptions: launchOptions)
        //WebSocket连接
        SocketManager.getSharedInstance().connect()
        //FirstAppStart
        FirstAppStartManager.init().setUpStartApp()

        
        
//        #if DEBUG
//        CocoaDebug.enable()
//        #endif
        
        return true
    }
    
    //Step 3. (AppDelegate.swift)
//    public func print<T>(file: String = #file, function: String = #function, line: Int = #line, _ message: T, color: UIColor = .white) {
//        #if DEBUG
//        swiftLog(file, function, line, message, color, false)
//        #endif
//    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        BackGroundManager.getSharedInstance().background()
        NotificationManager.getSharedInstance().applicationDidEnterBackground(application)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        BackGroundManager.getSharedInstance().active()
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        BackGroundManager.getSharedInstance().reloadTime()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let result = UMSocialManager.default()?.handleOpen(url, sourceApplication: sourceApplication, annotation: annotation)
        //其他SDK调用
        if !result! {
            
        }
        return result!
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let result = UMSocialManager.default()?.handleOpen(url, options: options)
        //其他SDK调用
        if !result! {
            
        }
        return result!
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        let result = UMSocialManager.default()?.handleOpen(url)
        //其他SDK调用
        if !result! {
            
        }
        return result!
    }
    
    //点推送进来执行这个方法iOS 10
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        NotificationManager.getSharedInstance().application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        NotificationManager.getSharedInstance().application(application, didReceiveRemoteNotification: userInfo)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NotificationManager.getSharedInstance().application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    
    
}

