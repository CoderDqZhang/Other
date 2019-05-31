//
//  ReadFileDataManager.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/30.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class ReadFileDataManager: NSObject {
    private static let _sharedInstance = ReadFileDataManager()
    
    class func getSharedInstance() -> ReadFileDataManager {
        return _sharedInstance
    }
    
    private override init() {} // 私有化init方法
    
    func readFileData(resultPath:String) ->NSDictionary?{
        do {
            let jsonData = try FileManager.default.jsonFromFile(withFilename: resultPath)
            return NSDictionary.init(dictionary: jsonData!)
        }catch {
            return nil
        }
    }
    
    func getBankNameDic()->NSDictionary? {
        return ReadFileDataManager.getSharedInstance().readFileData(resultPath: LOCALBANKNAME)
    }
}
