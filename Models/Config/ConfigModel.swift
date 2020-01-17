//
//  ConfigModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class ConfigModel : NSObject, NSCoding{

    var configuration : Configuration!
    var time : Int!
    var version : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let configurationData = dictionary["configuration"] as? [String:Any]{
            configuration = Configuration(fromDictionary: configurationData)
        }
        time = dictionary["time"] as? Int
        version = dictionary["version"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if configuration != nil{
            dictionary["configuration"] = configuration.toDictionary()
        }
        if time != nil{
            dictionary["time"] = time
        }
        if version != nil{
            dictionary["version"] = version
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         configuration = aDecoder.decodeObject(forKey: "configuration") as? Configuration
         time = aDecoder.decodeObject(forKey: "time") as? Int
         version = aDecoder.decodeObject(forKey: "version") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if configuration != nil{
            aCoder.encode(configuration, forKey: "configuration")
        }
        if time != nil{
            aCoder.encode(time, forKey: "time")
        }
        if version != nil{
            aCoder.encode(version, forKey: "version")
        }

    }

}

class Configuration : NSObject, NSCoding{

    var anAuditStatus : Int!
    var background : String!
    var id : Int!
    var ipAuditStatus : Int!
    var isComLogin : Int!
    var isIpLogin : Int!
    var isQqLogin : Int!
    var isSmsLogin : Int!
    var isWbLogin : Int!
    var isWxLogin : Int!
    var signStatus : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        anAuditStatus = dictionary["anAuditStatus"] as? Int
        background = dictionary["background"] as? String
        id = dictionary["id"] as? Int
        ipAuditStatus = dictionary["ipAuditStatus"] as? Int
        isComLogin = dictionary["isComLogin"] as? Int
        isIpLogin = dictionary["isIpLogin"] as? Int
        isQqLogin = dictionary["isQqLogin"] as? Int
        isSmsLogin = dictionary["isSmsLogin"] as? Int
        isWbLogin = dictionary["isWbLogin"] as? Int
        isWxLogin = dictionary["isWxLogin"] as? Int
        signStatus = dictionary["signStatus"] as? Int
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if anAuditStatus != nil{
            dictionary["anAuditStatus"] = anAuditStatus
        }
        if background != nil{
            dictionary["background"] = background
        }
        if id != nil{
            dictionary["id"] = id
        }
        if ipAuditStatus != nil{
            dictionary["ipAuditStatus"] = ipAuditStatus
        }
        if isComLogin != nil{
            dictionary["isComLogin"] = isComLogin
        }
        if isIpLogin != nil{
            dictionary["isIpLogin"] = isIpLogin
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
        if signStatus != nil{
            dictionary["signStatus"] = signStatus
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         anAuditStatus = aDecoder.decodeObject(forKey: "anAuditStatus") as? Int
         background = aDecoder.decodeObject(forKey: "background") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         ipAuditStatus = aDecoder.decodeObject(forKey: "ipAuditStatus") as? Int
         isComLogin = aDecoder.decodeObject(forKey: "isComLogin") as? Int
         isIpLogin = aDecoder.decodeObject(forKey: "isIpLogin") as? Int
         isQqLogin = aDecoder.decodeObject(forKey: "isQqLogin") as? Int
         isSmsLogin = aDecoder.decodeObject(forKey: "isSmsLogin") as? Int
         isWbLogin = aDecoder.decodeObject(forKey: "isWbLogin") as? Int
         isWxLogin = aDecoder.decodeObject(forKey: "isWxLogin") as? Int
         signStatus = aDecoder.decodeObject(forKey: "signStatus") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if anAuditStatus != nil{
            aCoder.encode(anAuditStatus, forKey: "anAuditStatus")
        }
        if background != nil{
            aCoder.encode(background, forKey: "background")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if ipAuditStatus != nil{
            aCoder.encode(ipAuditStatus, forKey: "ipAuditStatus")
        }
        if isComLogin != nil{
            aCoder.encode(isComLogin, forKey: "isComLogin")
        }
        if isIpLogin != nil{
            aCoder.encode(isIpLogin, forKey: "isIpLogin")
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
        if signStatus != nil{
            aCoder.encode(signStatus, forKey: "signStatus")
        }

    }

}
