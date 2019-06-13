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
    
    var userCache = YYKVStorage.init(path: kEncodeUserCachesDirectory, type: YYKVStorageType.file)
    var otherCache = YYKVStorage.init(path: kEncodedObjectPath, type: YYKVStorageType.file)
    
    class func getSharedInstance() -> CacheManager {
        
        return _sharedInstance
    }
    
    private override init() {} // 私有化init方法
    
    
    func getUserId() ->String{
        return (CacheManager.getSharedInstance().getUserInfo()?.id.string)!
    }
    
    func saveNormaltModel(category:CategoryModel){
        var array = NSMutableArray.init()
        if (CacheManager._sharedInstance.otherCache?.itemExists(forKey: "CategoryModels"))! {
            let item:Data = ((CacheManager._sharedInstance.otherCache?.getItemValue(forKey: "CategoryModels"))!)
            array =  NSKeyedUnarchiver.unarchiveObject(with: item) as! NSMutableArray
        }
        for model in array {
            if category.id == CategoryModel.init(fromDictionary: model as! [String : Any]).id {
                return
            }
        }
        array.add(category.toDictionary())
        
        CacheManager._sharedInstance.otherCache?.saveItem(withKey: "CategoryModels", value: NSKeyedArchiver.archivedData(withRootObject: array), filename: "CategoryTemp", extendedData: nil)
    }
    
    func getCategoryModels() ->NSMutableArray? {
        if (CacheManager._sharedInstance.otherCache?.itemExists(forKey: "CategoryModels"))! {
            let item:Data = ((CacheManager._sharedInstance.otherCache?.getItemValue(forKey: "CategoryModels"))!)
            return NSKeyedUnarchiver.unarchiveObject(with: item) as? NSMutableArray
        }
        return nil
    }
    
    func savePostModel(postModel:PostModel){
        CacheManager._sharedInstance.otherCache?.saveItem(withKey: "PostModel", value: NSKeyedArchiver.archivedData(withRootObject: postModel), filename: "PostTemp", extendedData: nil)
    }
    
    func getPostModel() ->PostModel? {
        if (CacheManager._sharedInstance.otherCache?.itemExists(forKey: "PostModel"))! == true {
            let item:Data = ((CacheManager._sharedInstance.otherCache?.getItemValue(forKey: "PostModel"))!)
            return NSKeyedUnarchiver.unarchiveObject(with: item) as? PostModel
        }
        return PostModel.init(fromDictionary: ["":""])
    }
    
    func removePostModel(){
        if (CacheManager._sharedInstance.otherCache?.itemExists(forKey: "PostModel"))! {
            CacheManager._sharedInstance.otherCache?.removeItem(forKey: "PostModel")
        }
    }
    
    
    func saveUserInfo(userInfo:UserInfoModel){
        CacheManager._sharedInstance.userCache?.saveItem(withKey: "userInfo", value: userInfo.toDictionary().jsonData()!, filename: "UserInfoFile", extendedData: nil)
    }
    
    func getUserInfo() ->UserInfoModel? {
        if CacheManager._sharedInstance.isLogin() {
            do {
                let item:Data = try ((CacheManager._sharedInstance.userCache?.getItemValue(forKey: "userInfo"))!)
                return UserInfoModel.init(fromDictionary: try item.jsonObject() as! [String : Any])
            }catch{
                return nil
            }
        }else{
            return nil
        }
        
    }
    
    func logout(){
        if (CacheManager._sharedInstance.userCache?.itemExists(forKey: "userInfo"))! {
            CacheManager._sharedInstance.userCache?.removeItem(forKey: "userInfo")
        }
        UserDefaults.init().removeObject(forKey: "UserToken")
    }
    
    func isLogin() ->Bool {
        return (CacheManager._sharedInstance.userCache?.itemExists(forKey: "userInfo"))! 
    }
    
    
    func saveConfigModel(category:ConfigModel){
         CacheManager._sharedInstance.otherCache?.saveItem(withKey: "ConfigModel", value: NSKeyedArchiver.archivedData(withRootObject: category), filename: "ConfigModel", extendedData: nil)
    }
    
    func getConfigModel() ->ConfigModel?{
        if (CacheManager._sharedInstance.otherCache?.itemExists(forKey: "ConfigModel"))! {
            let item:Data = ((CacheManager._sharedInstance.otherCache?.getItemValue(forKey: "ConfigModel"))!)
            return NSKeyedUnarchiver.unarchiveObject(with: item) as? ConfigModel
        }
        return nil
    }
    
    func saveUnreadModel(category:UnreadMessageModel){
        CacheManager._sharedInstance.otherCache?.saveItem(withKey: "UnreadMessageModel", value: NSKeyedArchiver.archivedData(withRootObject: category), filename: "UnreadMessageModel", extendedData: nil)
    }
    
    func getUnreadModel() ->UnreadMessageModel?{
        if (CacheManager._sharedInstance.otherCache?.itemExists(forKey: "UnreadMessageModel"))! {
            let item:Data = ((CacheManager._sharedInstance.otherCache?.getItemValue(forKey: "UnreadMessageModel"))!)
            return NSKeyedUnarchiver.unarchiveObject(with: item) as? UnreadMessageModel
        }
        return nil
    }
}
