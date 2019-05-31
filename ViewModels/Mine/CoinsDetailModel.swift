//
//  CoinsDetailModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/27.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class CoinsDetailModel : NSObject, NSCoding{
    
    var coin : Int!
    var createTime : String!
    var descriptionField : String!
    var id : Int!
    var status : String!
    var title : String!
    var type : String!
    var updateTime : String!
    var userId : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        coin = dictionary["coin"] as? Int
        createTime = dictionary["createTime"] as? String
        descriptionField = dictionary["description"] as? String
        id = dictionary["id"] as? Int
        status = dictionary["status"] as? String
        title = dictionary["title"] as? String
        type = dictionary["type"] as? String
        updateTime = dictionary["updateTime"] as? String
        userId = dictionary["userId"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if coin != nil{
            dictionary["coin"] = coin
        }
        if createTime != nil{
            dictionary["createTime"] = createTime
        }
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if id != nil{
            dictionary["id"] = id
        }
        if status != nil{
            dictionary["status"] = status
        }
        if title != nil{
            dictionary["title"] = title
        }
        if type != nil{
            dictionary["type"] = type
        }
        if updateTime != nil{
            dictionary["updateTime"] = updateTime
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
        coin = aDecoder.decodeObject(forKey: "coin") as? Int
        createTime = aDecoder.decodeObject(forKey: "createTime") as? String
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        status = aDecoder.decodeObject(forKey: "status") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
        type = aDecoder.decodeObject(forKey: "type") as? String
        updateTime = aDecoder.decodeObject(forKey: "updateTime") as? String
        userId = aDecoder.decodeObject(forKey: "userId") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if coin != nil{
            aCoder.encode(coin, forKey: "coin")
        }
        if createTime != nil{
            aCoder.encode(createTime, forKey: "createTime")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if updateTime != nil{
            aCoder.encode(updateTime, forKey: "updateTime")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }
        
    }
    
}
