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
    
    func saveUserInfo(userInfo:UserInfoModel){
        CacheManager._sharedInstance.userCache?.saveItem(withKey: "userInfo", value: userInfo.toDictionary().jsonData()!, filename: "UserInfoFile", extendedData: nil)
    }
    
    func getUserInfo() ->UserInfoModel? {
        if CacheManager._sharedInstance.isLogin() {
            let item:Data = ((CacheManager._sharedInstance.userCache?.getItemValue(forKey: "userInfo"))!)
            do {
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
    }
    
    func isLogin() ->Bool {
        return (CacheManager._sharedInstance.userCache?.itemExists(forKey: "userInfo"))!
    }
}
