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
}
