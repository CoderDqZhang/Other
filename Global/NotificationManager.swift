//
//  NotificationManager.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/11.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit


//{
//    "param": "{id:1,name:\"123\"}",
//    "url": "www.baidu.com",
//    "type": 1,
//    "forword": 0
//}
//type类型  1：帖子详情  2：比分 3：推介 4：活动   5：系统通知  6：出墙
//forword 跳转类型   0站内 1：站外
//param  参数   json类型
//url   站外 要跳转的地址

enum PushControllerType:String {
    case ArticleDetail = "1"
    case Scroce = "2"
    case Commond = "3"
    case Action = "4"
    case System = "5"
    case OutFall = "6"
}

enum PushServerType:String {
    case PushInServer = "0"
    case PushWebServer = "1"
}

class NotificationManager: NSObject {

    private static let _sharedInstance = NotificationManager()
    
    class func getSharedInstance() -> NotificationManager {
        return _sharedInstance
    }
    
    private override init() {} // 私有化init方法
    
    func setUpNotification(launchOptions:[UIApplication.LaunchOptionsKey: Any]?){
        let entity = JPUSHRegisterEntity()
        entity.types = 1 << 0 | 1 << 1 | 1 << 2
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        
        JPUSHService.setup(withOption: launchOptions, appKey: JPushKey, channel: "App Store", apsForProduction: false, advertisingIdentifier: nil)
    }
    
    //系统获取Token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    //获取token 失败
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) { //可选
        print("did Fail To Register For Remote Notifications With Error: \(error)")
    }
    
    
    //点推送进来执行这个方法IOS 10 + 点击此方法来跳转界面
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        JPUSHService.handleRemoteNotification(userInfo)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATIOINSPUSHCONTROLLER), object: nil, userInfo: userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
        
    }
    
    
    //后台进前台
    func applicationDidEnterBackground(_ application: UIApplication) {
        //销毁通知红点
        SHARE_APPLICATION.applicationIconBadgeNumber = 0
        JPUSHService.setBadge(0)
        SHARE_APPLICATION.cancelAllLocalNotifications()
    }
    
    
    func addAlias(alias:String){
        JPUSHService.setAlias("\(JPUSHALIAS)\(alias)", completion: { (iResCode, alias, seq) in
            if iResCode == 0 {
                print("增加别名成功")
            }
        }, seq: 1)
    }
    
    func deleteAlias(){
        JPUSHService.deleteAlias({ (iResCode, alias, seq) in
            if iResCode == 0 {
                print("删除别名成功")
            }
        }, seq: 1)
    }
}

extension NotificationManager : JPUSHRegisterDelegate {
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        
        
//        NotificationService.re
        // 系统要求执行这个方法
        completionHandler()
    }
    //iOS 12Support
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {
        if (notification != nil) {
            //从通知界面直接进入应用
        }else{
            //从通知设置页面进入应用
        }
    }
}

class LocalNotification: NSObject {
    private static let _sharedInstance = LocalNotification()
    
    class func getSharedInstance() -> LocalNotification {
        return _sharedInstance
    }
    
    private override init() {} // 私有化init方法
    
    
    func localNotification(){
        let content = JPushNotificationContent.init()
        content.title = "TEST Notifications"
        content.subtitle = "2019"
        content.body = "This is a test code"
        content.badge = 1
        content.categoryIdentifier = "Custom category name"
        
        let triggert = JPushNotificationTrigger.init()
        triggert.timeInterval = 5
        
        
        // 5s 后提醒 iOS 10 以上支持
//        JPushNotificationTrigger *trigger1 = [[JPushNotificationTrigger alloc] init];
//        trigger1.timeInterval = 5;
//        //每小时重复 1 次 iOS 10 以上支持
//        JPushNotificationTrigger *trigger2 = [[JPushNotificationTrigger alloc] init];
//        trigger2.timeInterval = 3600;
//        trigger2.repeat = YES;
//        
//        //每周一早上 8：00 提醒，iOS 10 以上支持
//        NSDateComponents *components = [[NSDateComponents alloc] init];
//        components.weekday = 2;
//        components.hour = 8;
//        JPushNotificationTrigger *trigger3 = [[JPushNotificationTrigger alloc] init];
//        trigger3.dateComponents = components;
//        trigger3.repeat = YES;
//        
//        //#import <CoreLocation/CoreLocation.h>
//        //一到某地点提醒，iOS 8 以上支持
//        CLLocationCoordinate2D cen = CLLocationCoordinate2DMake(37.335400, -122.009201);
//        CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:cen
//        radius:2000.0
//        identifier:@"jiguang"];
//        JPushNotificationTrigger *trigger4 = [[JPushNotificationTrigger alloc] init];
//        trigger4.region = region;
//        
//        //5s 后提醒，iOS 10 以下支持
//        JPushNotificationTrigger *trigger5 = [[JPushNotificationTrigger alloc] init];
//        trigger5.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
//        
//        JPushNotificationRequest *request = [[JPushNotificationRequest alloc] init];
//        request.requestIdentifier = @"sampleRequest";
//        request.content = content;
//        request.trigger = trigger1;//trigger2;//trigger3;//trigger4;//trigger5;
//        request.completionHandler = ^(id result) {
//            NSLog(@"结果返回：%@", result);
//        };
//        [JPUSHService addNotification:request];
    }
}
