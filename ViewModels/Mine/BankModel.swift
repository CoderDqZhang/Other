//
//  BankModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/30.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class BankModel : NSObject, NSCoding{
    
    var account : String!
    var bank : String!
    var createTime : String!
    var id : Int!
    var type : String!
    var userId : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        account = dictionary["account"] as? String
        bank = dictionary["bank"] as? String
        createTime = dictionary["createTime"] as? String
        id = dictionary["id"] as? Int
        type = dictionary["type"] as? String
        userId = dictionary["userId"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if account != nil{
            dictionary["account"] = account
        }
        if bank != nil{
            dictionary["bank"] = bank
        }
        if createTime != nil{
            dictionary["createTime"] = createTime
        }
        if id != nil{
            dictionary["id"] = id
        }
        if type != nil{
            dictionary["type"] = type
        }
        if userId != nil{
            dictionary["userId"] = userId
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        account = aDecoder.decodeObject(forKey: "account") as? String
        bank = aDecoder.decodeObject(forKey: "bank") as? String
        createTime = aDecoder.decodeObject(forKey: "createTime") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        type = aDecoder.decodeObject(forKey: "type") as? String
        userId = aDecoder.decodeObject(forKey: "userId") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if account != nil{
            aCoder.encode(account, forKey: "account")
        }
        if bank != nil{
            aCoder.encode(bank, forKey: "bank")
        }
        if createTime != nil{
            aCoder.encode(createTime, forKey: "createTime")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }
        
    }
    
}
