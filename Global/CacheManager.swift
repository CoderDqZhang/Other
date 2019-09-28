//
//  CacheManager.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import YYCache

let kEncodedObjectPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String
let kEncodeUserCachesDirectory = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as String

class CacheManager: NSObject {
    
    private static let _sharedInstance = CacheManager()
    
    var userCache = YYDiskCache.init(path: kEncodeUserCachesDirectory)
    var otherCache = YYDiskCache.init(path: kEncodedObjectPath)
    
    class func getSharedInstance() -> CacheManager {
        
        return _sharedInstance
    }
    
    private override init() {} // 私有化init方法
    
    
    func getUserId() ->String{
        return (CacheManager.getSharedInstance().getUserInfo()?.id.string)!
    }
    
    func saveNormaltModel(category:CategoryModel){
        var array = NSMutableArray.init()
        if (CacheManager.getSharedInstance().otherCache?.containsObject(forKey: CACHEMANAGERCATEGORYMODELS))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: CACHEMANAGERCATEGORYMODELS))!
            array = NSMutableArray.init(array: item as! [Any])
        }
        for model in array {
            if category.id == CategoryModel.init(fromDictionary: model as! [String : Any]).id {
                return
            }
        }
        array.add(category.toDictionary())
        if array.count > 4 {
            array.removeObject(at: 0)
        }
        CacheManager._sharedInstance.otherCache?.setObject(array, forKey: CACHEMANAGERCATEGORYMODELS)
    }
    
    func getCategoryModels() ->NSMutableArray? {
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: CACHEMANAGERCATEGORYMODELS))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: CACHEMANAGERCATEGORYMODELS))!
            return item as? NSMutableArray
        }
        return nil
    }
    
    func savePostModel(postModel:PostModel){
        CacheManager._sharedInstance.otherCache?.setObject(postModel, forKey: CACHEMANAPSOTMODEL)
    }
    
    func getPostModel() ->PostModel? {
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: CACHEMANAPSOTMODEL))! == true {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: CACHEMANAPSOTMODEL))!
            return item as? PostModel
        }
        return nil
    }
    
    func removePostModel(){
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: CACHEMANAPSOTMODEL))! {
            CacheManager._sharedInstance.otherCache?.removeObject(forKey: CACHEMANAPSOTMODEL)
        }
    }
    
    
    func saveUserInfo(userInfo:UserInfoModel){
        CacheManager._sharedInstance.userCache?.setObject(userInfo, forKey: CACHEMANAUSERINFO)
    }
    
    func getUserInfo() ->UserInfoModel? {
        if (CacheManager._sharedInstance.userCache?.containsObject(forKey: CACHEMANAUSERINFO))! == true {
            let item = (CacheManager._sharedInstance.userCache?.object(forKey: CACHEMANAUSERINFO))!
            return item as? UserInfoModel
        }
        return nil
    }
    
    func logout(){
        if (CacheManager._sharedInstance.userCache?.containsObject(forKey: CACHEMANAUSERINFO))! {
            CacheManager._sharedInstance.userCache?.removeObject(forKey: CACHEMANAUSERINFO)
        }
        UserDefaults.init().removeObject(forKey: CACHEMANAUSERTOKEN)
        //增加退出删除别名
        NotificationManager.getSharedInstance().deleteAlias()
    }
    
    func isLogin() ->Bool {
        if UserDefaults.init().object(forKey: CACHEMANAUSERTOKEN) == nil ||  (CacheManager._sharedInstance.userCache?.containsObject(forKey: CACHEMANAUSERINFO)) == nil{
            CacheManager._sharedInstance.logout()
            return false
        }
        return true
    }
    
    
    func saveConfigModel(category:ConfigModel){
        CacheManager._sharedInstance.otherCache?.setObject(category, forKey: CACHEMANAUSERTOKEN)
    }
    
    func getConfigModel() ->ConfigModel?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: CACHEMANAUSERTOKEN))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: CACHEMANAUSERTOKEN))!
            return item as? ConfigModel
        }
        return nil
    }
    
    func saveUnreadModel(category:UnreadMessageModel){
         CacheManager._sharedInstance.otherCache?.setObject(category, forKey: CACHEMANAUNREADMESSAGEMODEL)
    }
    
    func getUnreadModel() ->UnreadMessageModel?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: CACHEMANAUNREADMESSAGEMODEL))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: CACHEMANAUNREADMESSAGEMODEL))!
            return item as? UnreadMessageModel
        }
        return nil
    }
    
    
    func saveADModel(category:AdModel){
        CacheManager._sharedInstance.otherCache?.setObject(category, forKey: ADMODEL)
    }
    
    func getADModel() ->AdModel?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: ADMODEL))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: ADMODEL))!
            return item as? AdModel
        }
        return nil
    }
    
    func saveAPPActiveModel(category:APPActiveModel){
        CacheManager._sharedInstance.otherCache?.setObject(category, forKey: APPACTIVEMODEL)
    }
    
    func getAPPActiveModel() ->APPActiveModel?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: APPACTIVEMODEL))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: APPACTIVEMODEL))!
            return item as? APPActiveModel
        }
        return nil
    }
    
    
    func savePlacholderImage(point:NSMutableDictionary){
        CacheManager._sharedInstance.otherCache?.setObject(point, forKey: PLACHOLDERIMAGE)
    }
    
    func getPlacholderImage() ->NSMutableDictionary?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: PLACHOLDERIMAGE))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: PLACHOLDERIMAGE))!
            return item as? NSMutableDictionary
        }
        return nil
    }
    
    func savePointModel(point:NSMutableArray){
        CacheManager._sharedInstance.otherCache?.setObject(point, forKey: CACHEMANAPointModel)
    }
    
    func getPointModel() ->NSMutableArray?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: CACHEMANAPointModel))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: CACHEMANAPointModel))!
            return item as? NSMutableArray
        }
        return nil
    }
    
    func saveFootBallInfoModel(point:NSDictionary){
        CacheManager._sharedInstance.otherCache?.setObject(point, forKey: FOOTBALLINFOMODEL)
    }
    
    func getFootBallInfoModel() ->NSDictionary?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: FOOTBALLINFOMODEL))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: FOOTBALLINFOMODEL))!
            return item as? NSDictionary
        }
        return nil
    }
    
    func saveFootBallEventModel(point:NSDictionary){
        CacheManager._sharedInstance.otherCache?.setObject(point, forKey: FOOTBALLEVENTODEL)
    }
    
    func getFootBallEventModel() ->NSDictionary?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: FOOTBALLEVENTODEL))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: FOOTBALLEVENTODEL))!
            return item as? NSDictionary
        }
        return nil
    }
    
    func saveFootBallEventIdModel(point:NSMutableArray){
        CacheManager._sharedInstance.otherCache?.setObject(point, forKey: FOOTBALLEVENTIDMODEL)
    }
    
    func getFootBallEventIdModel() ->NSMutableArray?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: FOOTBALLEVENTIDMODEL))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: FOOTBALLEVENTIDMODEL))!
            return item as? NSMutableArray
        }
        return nil
    }
    
    func saveFootBallEventSelectModel(point:NSDictionary){
        CacheManager._sharedInstance.otherCache?.setObject(point, forKey: FOOTBALLEVENTSELECTMODEL)
    }
    
    func getFootBallEventSelectModel() ->NSDictionary?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: FOOTBALLEVENTSELECTMODEL))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: FOOTBALLEVENTSELECTMODEL))!
            return item as? NSDictionary
        }
        return nil
    }
    
    func saveFootBallEventLevelModel(point:NSDictionary){
        CacheManager._sharedInstance.otherCache?.setObject(point, forKey: FOOTBALLEVENTLEVELMODEL)
    }
    
    func getFootBallEventLevelModel() ->NSDictionary?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: FOOTBALLEVENTLEVELMODEL))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: FOOTBALLEVENTLEVELMODEL))!
            return item as? NSDictionary
        }
        return nil
    }
    
    func saveFootBallNorthSigleModel(point:NSDictionary){
        CacheManager._sharedInstance.otherCache?.setObject(point, forKey: FOOTBALLNORTHSIGLEMODEL)
    }
    
    func getFootBallNorthSigleModel() ->NSDictionary?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: FOOTBALLNORTHSIGLEMODEL))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: FOOTBALLNORTHSIGLEMODEL))!
            return item as? NSDictionary
        }
        return nil
    }
    
    func saveFootBallLotteryModel(point:NSDictionary){
        CacheManager._sharedInstance.otherCache?.setObject(point, forKey: FOOTBALLLOTTERYMODEL)
    }
    
    func getFootBallLotteryModel() ->NSDictionary?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: FOOTBALLLOTTERYMODEL))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: FOOTBALLLOTTERYMODEL))!
            return item as? NSDictionary
        }
        return nil
    }
    
    func saveFootBallIndexModel(point:NSDictionary){
        CacheManager._sharedInstance.otherCache?.setObject(point, forKey: FOOTBALLINDEXMODEL)
    }
    
    func getFootBallIndexModel() ->NSDictionary?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: FOOTBALLINDEXMODEL))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: FOOTBALLINDEXMODEL))!
            return item as? NSDictionary
        }
        return nil
    }
    
    func saveFootBallMatchCollectModel(point:NSMutableArray){
        let resultArray = point.filter({ (dic) -> Bool in
            return Date.init().hoursSince(Date.init(timeIntervalSince1970: (dic as! FootBallModel).startTime.double)) < 12
        })

        CacheManager._sharedInstance.otherCache?.setObject(NSMutableArray.init(array: resultArray), forKey: FOOTBALLMATCHCOLLECTMODEL)
    }
    
    func getFootBallMatchCollectModel() ->NSMutableArray?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: FOOTBALLMATCHCOLLECTMODEL))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: FOOTBALLMATCHCOLLECTMODEL))!
            let resultArray = (item as! NSMutableArray).filter({ (dic) -> Bool in
                return Date.init().hoursSince(Date.init(timeIntervalSince1970: (dic as! FootBallModel).startTime.double)) < 12
            })
            return  NSMutableArray.init(array: resultArray)
        }
        return nil
    }
    
    func saveBasketBallInfoModel(point:NSDictionary){
        CacheManager._sharedInstance.otherCache?.setObject(point, forKey: BASKETBALLINFOMODEL)
    }
    
    func getBasketBallInfoModel() ->NSDictionary?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey:BASKETBALLINFOMODEL))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: BASKETBALLINFOMODEL))!
            return item as? NSDictionary
        }
        return nil
    }
    
    func saveBasketBallEventModel(point:NSDictionary){
        CacheManager._sharedInstance.otherCache?.setObject(point, forKey: BASKETBALLEVENTODEL)
    }
    
    func getBasketBallEventModel() ->NSDictionary?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: BASKETBALLEVENTODEL))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: BASKETBALLEVENTODEL))!
            return item as? NSDictionary
        }
        return nil
    }
    
    func saveBasketBallEventIdModel(point:NSMutableArray){
        CacheManager._sharedInstance.otherCache?.setObject(point, forKey: BASKETBALLEVENTIDMODEL)
    }
    
    func getBasketBallEventIdModel() ->NSMutableArray?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: BASKETBALLEVENTIDMODEL))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: BASKETBALLEVENTIDMODEL))!
            return item as? NSMutableArray
        }
        return nil
    }
    
    func saveBasketBallEventSelectModel(point:NSDictionary){
        CacheManager._sharedInstance.otherCache?.setObject(point, forKey: BASKETBALLEVENTSELECTMODEL)
    }
    
    func getBasketBallEventSelectModel() ->NSDictionary?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: BASKETBALLEVENTSELECTMODEL))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: BASKETBALLEVENTSELECTMODEL))!
            return item as? NSDictionary
        }
        return nil
    }
    
    func saveBasketBallEventLevelModel(point:NSDictionary){
        CacheManager._sharedInstance.otherCache?.setObject(point, forKey: BASKETBALLEVENTLEVELMODEL)
    }
    
    func getBasketBallEventLevelModel() ->NSDictionary?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: BASKETBALLEVENTLEVELMODEL))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: BASKETBALLEVENTLEVELMODEL))!
            return item as? NSDictionary
        }
        return nil
    }
    
    func saveBasketBallIndexModel(point:NSDictionary){
        CacheManager._sharedInstance.otherCache?.setObject(point, forKey: BASKETBALLINDEXMODEL)
    }
    
    func getBasketBallIndexModel() ->NSDictionary?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: BASKETBALLINDEXMODEL))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: BASKETBALLINDEXMODEL))!
            return item as? NSDictionary
        }
        return nil
    }
    
    func saveBasketBallMatchCollectModel(point:NSMutableArray){
        let resultArray = point.filter({ (dic) -> Bool in
            return Date.init().hoursSince(Date.init(timeIntervalSince1970: (dic as! BasketBallModel).time.double)) < 12
        })
        
        CacheManager._sharedInstance.otherCache?.setObject(NSMutableArray.init(array: resultArray), forKey: BASKETBALLMATCHCOLLECTMODEL)
    }
    
    func getBasketBallMatchCollectModel() ->NSMutableArray?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: BASKETBALLMATCHCOLLECTMODEL))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: BASKETBALLMATCHCOLLECTMODEL))!
            let resultArray = (item as! NSMutableArray).filter({ (dic) -> Bool in
                return Date.init().hoursSince(Date.init(timeIntervalSince1970: (dic as! BasketBallModel).time.double)) < 12
            })
            return NSMutableArray.init(array: resultArray)
        }
        return nil
    }
    
}
