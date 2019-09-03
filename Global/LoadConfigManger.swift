//
//  LoadConfigManger.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

enum FootBallSaveType {
    case index
    case northsigle
    case lottery
    case event
    case level
}

enum BasketBallSaveType {
    case index
    case event
    case level
}

class LoadConfigManger: NSObject {
    
    private static let _sharedInstance = LoadConfigManger()
    
    class func getSharedInstance() -> LoadConfigManger {
        return _sharedInstance
    }
    
    private override init() {} // 私有化init方法
    
    func setUp(){
        self.loadConfigUrl()
        self.loadUnreadUrl()
        self.loadPointdUrl()
        //获取球队信息
        self.loadFootBallScorEvent()
        self.loadBasketBallScorEvent()
    }
    
    func loadConfigUrl(){
        BaseNetWorke.getSharedInstance().getUrlWithString(CommentgetTimetUrl, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                let model = ConfigModel.init(fromDictionary: resultDic.value as! [String : Any])
                CacheManager.getSharedInstance().saveConfigModel(category: model)
            }
        }
    }
    
    func loadUnreadUrl(){
        if CacheManager.getSharedInstance().isLogin() {
            let parameters = ["type":"0"]
            BaseNetWorke.getSharedInstance().postUrlWithString(NotifyUnreadUrl, parameters: parameters as AnyObject).observe { (resultDic) in
                if !resultDic.isCompleted {
                    let model = UnreadMessageModel.init(fromDictionary: resultDic.value as! [String : Any])
                    CacheManager.getSharedInstance().saveUnreadModel(category: model)
                    (KWindow.rootViewController as! MainTabBarController).upateUnreadMessage()
                }
            }
        }
    }
    
    func loadPointdUrl(){
        if CacheManager.getSharedInstance().isLogin() {
            BaseNetWorke.getSharedInstance().getUrlWithString(CommentgetPointUrl, parameters: nil).observe { (resultDic) in
                if !resultDic.isCompleted {
                    let model = NSMutableArray.init(array: resultDic.value as! Array)
                    CacheManager.getSharedInstance().savePointModel(point: model)
                }
            }
        }
    }
    
    func setUpADView(controller:BaseViewController, model:AdModel){
        let adView = AdView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT), url: model.image) {
            let controllerVC = AdViewController.init()
            controllerVC.loadRequest(url: model.url) 
            NavigationPushView(controller, toConroller: controllerVC)
        }
        KWindow.addSubview(adView)
    }
    
    func loadFootBallScorEvent(){
        let date = Date.init().string(withFormat: "yyyyMMdd")
        let parameters = ["date":date] as [String : Any]
        var temp_dic =  CacheManager.getSharedInstance().getFootBallInfoModel()
//        if temp_dic == nil || temp_dic?.object(forKey: date) == nil || CacheManager.getSharedInstance().getFootBallEventSelectModel() == nil {
            BaseNetWorke.getSharedInstance().getUrlWithString(FootBallInfoUrl, parameters: parameters as AnyObject).observe { (resultDic) in
                if !resultDic.isCompleted {
        
                    self.saveFootBallEventDic(dic: (resultDic.value as! NSDictionary))
                    
                    if temp_dic == nil {
                        temp_dic = NSMutableDictionary.init(dictionary:  [date:resultDic.value as! NSDictionary])
                    }else{
                        temp_dic?.setValue(resultDic.value , forKey: date)
                    }
                    CacheManager.getSharedInstance().saveFootBallInfoModel(point: temp_dic!)
                    NotificationCenter.default.post(name: NSNotification.Name.init(RELOADFOOTBALLEVENTDATA), object: nil)
                }
            }
//        }
    }
    
    func loadBasketBallScorEvent(){
        let date = Date.init().string(withFormat: "yyyyMMdd")
        let parameters = ["date":date] as [String : Any]
        var temp_dic =  CacheManager.getSharedInstance().getBasketBallInfoModel()
//        if temp_dic == nil || temp_dic?.object(forKey: date) == nil || CacheManager.getSharedInstance().getBasketBallEventSelectModel() == nil {
            BaseNetWorke.getSharedInstance().getUrlWithString(BasketBallInfoUrl, parameters: parameters as AnyObject).observe { (resultDic) in
                if !resultDic.isCompleted {
                    self.saveBasketBallEventDic(dic: (resultDic.value as! NSDictionary))
                    if temp_dic == nil {
                        temp_dic = NSMutableDictionary.init(dictionary:  [date:resultDic.value as! NSDictionary])
                    }else{
                        temp_dic?.setValue(resultDic.value , forKey: date)
                    }
                    CacheManager.getSharedInstance().saveBasketBallInfoModel(point: temp_dic!)
                    NotificationCenter.default.post(name: NSNotification.Name.init(RELOADBASKETBALLEVENTDATA), object: nil)
                }
            }
            
//        }
    }
    
    func saveFootBallEventDic(dic:NSDictionary){
        let models = self.reFootBallDuplictionData(originArray: NSMutableArray.init(array: (dic.object(forKey: "events") as! NSDictionary).allValues),type: .event)
        self.saveFootData(type: .event, models: models)
        
        let level_models = self.reFootBallDuplictionData(originArray: NSMutableArray.init(array: (dic.object(forKey: "events") as! NSDictionary).allValues),type: .level)
        self.saveFootData(type: .level, models: level_models)
        
        let north_models = self.reFootBallDuplictionData(originArray: NSMutableArray.init(array: (dic.object(forKey: "northOdd") as! NSDictionary).allValues),type: .northsigle)
        self.saveFootData(type: .northsigle, models: north_models)
        
        let indexex_models = self.reFootBallDuplictionData(originArray: NSMutableArray.init(array: (dic.object(forKey: "indexes") as! NSDictionary).allValues),type: .index)
        self.saveFootData(type: .index, models: indexex_models)
        
        let lottery_models = self.reFootBallDuplictionData(originArray: NSMutableArray.init(array: (dic.object(forKey: "footballLottery") as! NSDictionary).allValues),type: .lottery)
        self.saveFootData(type: .lottery, models: lottery_models)
        
        
    }
    
    func saveBasketBallEventDic(dic:NSDictionary){
        let models = self.reBasketBallDuplictionData(originArray: NSMutableArray.init(array: (dic.object(forKey: "events") as! NSDictionary).allValues), type: .event)
        self.saveBasketData(type: .event, models: models)
        
        let level_models = self.reBasketBallDuplictionData(originArray: NSMutableArray.init(array: (dic.object(forKey: "events") as! NSDictionary).allValues), type: .level)
        self.saveBasketData(type: .level, models: level_models)
        
        let indexex_models = self.reBasketBallDuplictionData(originArray: NSMutableArray.init(array: (dic.object(forKey: "indexes") as! NSDictionary).allValues), type: .index)
        self.saveBasketData(type: .index, models: indexex_models)
    }
    
    func reFootBallDuplictionData(originArray:NSMutableArray,type:FootBallSaveType) -> NSMutableArray{
        let temp_array = NSMutableArray.init()
        let result_array = NSMutableArray.init()
        switch type {
        case .event, .level:
            for item in originArray {
                let con = temp_array.contains((item as! NSDictionary).object(forKey: "id")!)
                if !con {
                    temp_array.add((item as! NSDictionary).object(forKey: "id")!)
                    result_array.add(item)
                }
            }
        default:
            for item in originArray {
                let com = temp_array.contains((item as! NSDictionary).object(forKey: "eventsName")!)
                if !com {
                    temp_array.add((item as! NSDictionary).object(forKey: "eventsName")!)
                    result_array.add(item)
                }
            }
        }
        return result_array
    }
    
    func reBasketBallDuplictionData(originArray:NSMutableArray,type:BasketBallSaveType) -> NSMutableArray{
        let temp_array = NSMutableArray.init()
        let result_array = NSMutableArray.init()
        switch type {
        case .event, .level:
            for item in originArray {
                let con = temp_array.contains((item as! NSDictionary).object(forKey: "id")!)
                if !con {
                    temp_array.add((item as! NSDictionary).object(forKey: "id")!)
                    result_array.add(item)
                }
            }
        default:
            for item in originArray {
                let com = temp_array.contains((item as! NSDictionary).object(forKey: "eventsName")!)
                if !com {
                    temp_array.add((item as! NSDictionary).object(forKey: "eventsName")!)
                    result_array.add(item)
                }
            }
        }
        return result_array
    }
    
    func saveBasketData(type:BasketBallSaveType, models:NSMutableArray) {
        let dic = NSMutableDictionary.init()
        if models.count > 0 {
            for index in 0...models.count - 1 {
                let temp_dic = NSMutableDictionary.init(dictionary: models[index] as! NSDictionary)
                temp_dic.setValue(true, forKey: "is_select")
                models.replaceObject(at: index, with: temp_dic)
            }
            let titles = NSArray.init(array: ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"])
            for name in titles {
                let array = models.filter { (dic) -> Bool in
                    var title = ""
                    switch type {
                    case .event,.level:
                        title = self.getFirstLetterFromString(aString: ((dic as! NSDictionary).object(forKey: "name_zh") as! String))
                    default:
                        title = self.getFirstLetterFromString(aString: ((dic as! NSDictionary).object(forKey: "eventsName") as! String))
                    }
                    //一级筛选
                    if type == .level {
                        return  title == name as! String && ((dic as! NSDictionary).object(forKey: "id") as! Int == 1 || (dic as! NSDictionary).object(forKey: "id") as! Int == 3)
                    }
                    return  title == name as! String
                }
                if array.count > 0 {
                    dic.setValue(array, forKey: name as! String)
                }
            }
        }
        switch type {
        case .event:
            CacheManager.getSharedInstance().saveBasketBallEventModel(point: dic)
            if CacheManager.getSharedInstance().getBasketBallEventSelectModel() == nil {
                CacheManager.getSharedInstance().saveBasketBallEventSelectModel(point: dic)
            }
        case .index:
            CacheManager.getSharedInstance().saveBasketBallIndexModel(point: dic)
        default:
            CacheManager.getSharedInstance().saveBasketBallEventLevelModel(point: dic)
        }
    }
    
    func saveFootData(type:FootBallSaveType, models:NSMutableArray) {
        let dic = NSMutableDictionary.init()
        if models.count > 0 {
            for index in 0...models.count - 1 {
                let temp_dic = NSMutableDictionary.init(dictionary: models[index] as! NSDictionary)
                temp_dic.setValue(true, forKey: "is_select")
                models.replaceObject(at: index, with: temp_dic)
            }
            let titles = NSArray.init(array: ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"])
            for name in titles {
                let array = models.filter { (dic) -> Bool in
                    var title = ""
                    switch type {
                    case .event, .level:
                        title = self.getFirstLetterFromString(aString: ((dic as! NSDictionary).object(forKey: "short_name_zh") as! String))
                    default:
                        title = self.getFirstLetterFromString(aString: ((dic as! NSDictionary).object(forKey: "eventsName") as! String))
                    }
                    //一级筛选
                    if type == .level {
                        return  title == name as! String && (dic as! NSDictionary).object(forKey: "level") as! Int == 1
                    }
                    return  title == name as! String
                }
                if array.count > 0 {
                    dic.setValue(array, forKey: name as! String)
                }
            }
        }
        
        switch type {
        case .event:
            CacheManager.getSharedInstance().saveFootBallEventModel(point: dic)
            if CacheManager.getSharedInstance().getFootBallEventSelectModel() == nil {
                CacheManager.getSharedInstance().saveFootBallEventSelectModel(point: dic)
            }
        case .index:
            CacheManager.getSharedInstance().saveFootBallIndexModel(point: dic)
        case .northsigle:
            CacheManager.getSharedInstance().saveFootBallNorthSigleModel(point: dic)
        case .lottery:
            CacheManager.getSharedInstance().saveFootBallLotteryModel(point: dic)
        default:
            CacheManager.getSharedInstance().saveFootBallEventLevelModel(point: dic)
        }
    }
    
    // MARK: - 获取联系人姓名首字母(传入汉字字符串, 返回大写拼音首字母)
    func getFirstLetterFromString(aString: String) -> (String) {
        
        // 注意,这里一定要转换成可变字符串
        let mutableString = NSMutableString.init(string: aString)
        // 将中文转换成带声调的拼音
        CFStringTransform(mutableString as CFMutableString, nil, kCFStringTransformToLatin, false)
        // 去掉声调(用此方法大大提高遍历的速度)
        let pinyinString = mutableString.folding(options: String.CompareOptions.diacriticInsensitive, locale: NSLocale.current)
        // 将拼音首字母装换成大写
        let strPinYin = polyphoneStringHandle(nameString: aString, pinyinString: pinyinString).uppercased()
        // 截取大写首字母
        let firstString = strPinYin.substring(to: strPinYin.index(strPinYin.startIndex, offsetBy:1))
        // 判断姓名首位是否为大写字母
        let regexA = "^[A-Z]$"
        let predA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
        return predA.evaluate(with: firstString) ? firstString : "#"
    }
    
    
    /// 多音字处理
    func polyphoneStringHandle(nameString:String, pinyinString:String) -> String {
        if nameString.hasPrefix("长") {return "chang"}
        if nameString.hasPrefix("沈") {return "shen"}
        if nameString.hasPrefix("厦") {return "xia"}
        if nameString.hasPrefix("地") {return "di"}
        if nameString.hasPrefix("重") {return "chong"}
        
        return pinyinString;
    }
}

