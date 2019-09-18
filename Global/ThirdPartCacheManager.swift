//
//  ThirdPartCacheManager.swift
//  Touqiu
//
//  Created by Zhang on 2019/9/18.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import YYWebImage
import YYCache
import SDWebImage

class ThirdPartCacheManager: NSObject {
    
    private static let _sharedInstance = ThirdPartCacheManager()
    
    class func getSharedInstance() -> ThirdPartCacheManager {
        return _sharedInstance
    }
    
    private override init() {} // 私有化init方法
    
    func cleanCache(){
        SDImageCache.shared.clearDisk {
            
        }
        
        YYImageCache.shared().diskCache.removeAllObjects()
        YYImageCache.shared().memoryCache.removeAllObjects()
    }
    
    func getCacheSize() -> Int{
        let cache = YYImageCache.shared().diskCache
        let size = cache.totalCost() / 1024 / 1024
        
        let sdCache = SDImageCache.shared
        let sdSize = sdCache.totalDiskSize() / 1024 / 1024
        return size + Int(sdSize)
    }
}
