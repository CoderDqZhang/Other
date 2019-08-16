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
        self.loadScorEvent()
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
    
    func loadScorEvent(){
        let date = Date.init().string(withFormat: "yyyyMMdd")
        let parameters = ["date":date] as [String : Any]
        var temp_dic =  CacheManager.getSharedInstance().getFootBallInfoModel()
        if temp_dic == nil || temp_dic?.object(forKey: date) != nil {
            BaseNetWorke.getSharedInstance().postUrlWithString(FootBallInfoUrl, parameters: parameters as AnyObject).observe { (resultDic) in
                if !resultDic.isCompleted {
        
                    self.saveEventDic(dic: (resultDic.value as! NSDictionary))
                    
                    if temp_dic == nil {
                        temp_dic = NSMutableDictionary.init(dictionary:  [date:resultDic.value as! NSDictionary])
                    }else{
                        temp_dic?.setValue(resultDic.value , forKey: date)
                    }
                    CacheManager.getSharedInstance().saveFootBallInfoModel(point: temp_dic!)
                    NotificationCenter.default.post(name: NSNotification.Name.init(RELOADFOOTBALLEVENTDATA), object: nil)
                }
            }
            
        }
    }
    
    func saveEventDic(dic:NSDictionary){
        let models = NSMutableArray.init(array: (dic.object(forKey: "events") as! NSDictionary).allValues)
        self.saveFootData(type: .event, models: models)
        
        let level_models = NSMutableArray.init(array: (dic.object(forKey: "events") as! NSDictionary).allValues)
        self.saveFootData(type: .level, models: level_models)
        
        let north_models = NSMutableArray.init(array: (dic.object(forKey: "northOdd") as! NSDictionary).allValues)
        self.saveFootData(type: .northsigle, models: north_models)
        
        let indexex_models = NSMutableArray.init(array: (dic.object(forKey: "indexes") as! NSDictionary).allValues)
        self.saveFootData(type: .index, models: indexex_models)
        
        let lottery_models = NSMutableArray.init(array: (dic.object(forKey: "footballLottery") as! NSDictionary).allValues)
        self.saveFootData(type: .lottery, models: lottery_models)
        
        
    }
    
    func saveFootData(type:FootBallSaveType, models:NSMutableArray) {
        if models.count > 0 {
            for index in 0...models.count - 1 {
                let temp_dic = NSMutableDictionary.init(dictionary: models[index] as! NSDictionary)
                temp_dic.setValue(true, forKey: "is_select")
                models.replaceObject(at: index, with: temp_dic)
            }
            let dic = NSMutableDictionary.init()
            let titles = NSArray.init(array: ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","S","Y","Z"])
            for name in titles {
                let temp_array = models.filter { (dic) -> Bool in
                    var title = ""
                    switch type {
                    case .event:
                        title = self.getFirstLetterFromString(aString: ((dic as! NSDictionary).object(forKey: "short_name_zh") as! String))
                    case .level:
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
                //去重
                if temp_array.count > 0 {
                    let array = self.reduplictionData(data: temp_array as NSArray, type: type)
                    dic.setValue(array, forKey: name as! String)
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
    }
    //去重
    func reduplictionData(data:NSArray,type:FootBallSaveType) ->NSMutableArray{
        let array = NSMutableArray.init()
        for index in 0...data.count - 1 {
            var isRet = false
            switch type {
            case .event:
                let title = ((data[index] as! NSDictionary).object(forKey: "short_name_zh") as! String)
                if index + 1 < data.count - 1  {
                    for index1 in (index + 1)...data.count - 1 {
                        if title == ((data[index1] as! NSDictionary).object(forKey: "short_name_zh") as! String) {
                            isRet = true
                            break
                        }
                    }
                }
            case .level:
                let title = ((data[index] as! NSDictionary).object(forKey: "short_name_zh") as! String)
                if index + 1 < data.count - 1  {
                    for index1 in (index + 1)...data.count - 1 {
                        if title == ((data[index1] as! NSDictionary).object(forKey: "short_name_zh") as! String) {
                            isRet = true
                            break
                        }
                    }
                }
            default:
                let title = ((data[index] as! NSDictionary).object(forKey: "comp") as! String)
                if index + 1 < data.count - 1  {
                    for index1 in (index + 1)...data.count - 1 {
                        if title == ((data[index1] as! NSDictionary).object(forKey: "comp") as! String) {
                            isRet = true
                            break
                        }
                    }
                }
            }
            if !isRet {
                array.add(data[index])
            }
        }
        return array
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

