//
//  ConfigModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class ConfigModel : NSObject, NSCoding{
    
    var isComLogin : Int!
    var isQqLogin : Int!
    var isSmsLogin : Int!
    var isWbLogin : Int!
    var isWxLogin : Int!
    var time : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        isComLogin = dictionary["isComLogin"] as? Int
        isQqLogin = dictionary["isQqLogin"] as? Int
        isSmsLogin = dictionary["isSmsLogin"] as? Int
        isWbLogin = dictionary["isWbLogin"] as? Int
        isWxLogin = dictionary["isWxLogin"] as? Int
        time = dictionary["time"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if isComLogin != nil{
            dictionary["isComLogin"] = isComLogin
        }
        if isQqLogin != nil{
            dictionary["isQqLogin"] = isQqLogin
        }
        if isSmsLogin != nil{
            dictionary["isSmsLogin"] = isSmsLogin
        }
        if isWbLogin != nil{
            dictionary["isWbLogin"] = isWbLogin
        }
        if isWxLogin != nil{
            dictionary["isWxLogin"] = isWxLogin
        }
        if time != nil{
            dictionary["time"] = time
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        isComLogin = aDecoder.decodeObject(forKey: "isComLogin") as? Int
        isQqLogin = aDecoder.decodeObject(forKey: "isQqLogin") as? Int
        isSmsLogin = aDecoder.decodeObject(forKey: "isSmsLogin") as? Int
        isWbLogin = aDecoder.decodeObject(forKey: "isWbLogin") as? Int
        isWxLogin = aDecoder.decodeObject(forKey: "isWxLogin") as? Int
        time = aDecoder.decodeObject(forKey: "time") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if isComLogin != nil{
            aCoder.encode(isComLogin, forKey: "isComLogin")
        }
        if isQqLogin != nil{
            aCoder.encode(isQqLogin, forKey: "isQqLogin")
        }
        if isSmsLogin != nil{
            aCoder.encode(isSmsLogin, forKey: "isSmsLogin")
        }
        if isWbLogin != nil{
            aCoder.encode(isWbLogin, forKey: "isWbLogin")
        }
        if isWxLogin != nil{
            aCoder.encode(isWxLogin, forKey: "isWxLogin")
        }
        if time != nil{
            aCoder.encode(time, forKey: "time")
        }
        
    }
    
}
