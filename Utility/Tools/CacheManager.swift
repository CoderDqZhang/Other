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
        if (CacheManager.getSharedInstance().otherCache?.containsObject(forKey: "CategoryModels"))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: "CategoryModels"))!
            array = NSMutableArray.init(array: item as! [Any])
        }
        for model in array {
            if category.id == CategoryModel.init(fromDictionary: model as! [String : Any]).id {
                return
            }
        }
        array.add(category.toDictionary())
        CacheManager._sharedInstance.otherCache?.setObject(array, forKey: "CategoryModels")
    }
    
    func getCategoryModels() ->NSMutableArray? {
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: "CategoryModels"))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: "CategoryModels"))!
            return item as? NSMutableArray
        }
        return nil
    }
    
    func savePostModel(postModel:PostModel){
        CacheManager._sharedInstance.otherCache?.setObject(postModel, forKey: "PostModel")
    }
    
    func getPostModel() ->PostModel? {
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: "PostModel"))! == true {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: "PostModel"))!
            return NSKeyedUnarchiver.unarchiveObject(with: item as! Data) as? PostModel
        }
        return nil
    }
    
    func removePostModel(){
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: "PostModel"))! {
            CacheManager._sharedInstance.otherCache?.removeObject(forKey: "PostModel")
        }
    }
    
    
    func saveUserInfo(userInfo:UserInfoModel){
        CacheManager._sharedInstance.otherCache?.setObject(userInfo, forKey: "userInfo")
    }
    
    func getUserInfo() ->UserInfoModel? {
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: "userInfo"))! == true {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: "userInfo"))!
            return item as? UserInfoModel
        }
        return nil
    }
    
    func logout(){
        if (CacheManager._sharedInstance.userCache?.containsObject(forKey: "userInfo"))! {
            CacheManager._sharedInstance.userCache?.removeObject(forKey: "userInfo")
        }
        UserDefaults.init().removeObject(forKey: "UserToken")
    }
    
    func isLogin() ->Bool {
        if UserDefaults.init().object(forKey: "UserToken") == nil ||  (CacheManager._sharedInstance.userCache?.containsObject(forKey: "userInfo")) == nil{
            CacheManager._sharedInstance.logout()
            return false
        }
        return true
    }
    
    
    func saveConfigModel(category:ConfigModel){
        CacheManager._sharedInstance.otherCache?.setObject(category, forKey: "ConfigModel")
    }
    
    func getConfigModel() ->ConfigModel?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: "ConfigModel"))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: "ConfigModel"))!
            return item as? ConfigModel
        }
        return nil
    }
    
    func saveUnreadModel(category:UnreadMessageModel){
         CacheManager._sharedInstance.otherCache?.setObject(category, forKey: "UnreadMessageModel")
    }
    
    func getUnreadModel() ->UnreadMessageModel?{
        if (CacheManager._sharedInstance.otherCache?.containsObject(forKey: "UnreadMessageModel"))! {
            let item = (CacheManager._sharedInstance.otherCache?.object(forKey: "UnreadMessageModel"))!
            return item as? UnreadMessageModel
        }
        return nil
    }
}
