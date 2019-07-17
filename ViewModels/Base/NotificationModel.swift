//
//  NotificationModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/15.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class NotificationModel: NSObject, NSCoding{
    
    var forword : String!
    var param : String!
    var type : String!
    var url : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        forword = dictionary["forword"] as? String
        param = dictionary["param"] as? String
        type = dictionary["type"] as? String
        url = dictionary["url"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if forword != nil{
            dictionary["forword"] = forword
        }
        if param != nil{
            dictionary["param"] = param
        }
        if type != nil{
            dictionary["type"] = type
        }
        if url != nil{
            dictionary["url"] = url
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        forword = aDecoder.decodeObject(forKey: "forword") as? String
        param = aDecoder.decodeObject(forKey: "param") as? String
        type = aDecoder.decodeObject(forKey: "type") as? String
        url = aDecoder.decodeObject(forKey: "url") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if forword != nil{
            aCoder.encode(forword, forKey: "forword")
        }
        if param != nil{
            aCoder.encode(param, forKey: "param")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if url != nil{
            aCoder.encode(url, forKey: "url")
        }
        
    }
    
}

class TypeModel : NSObject, NSCoding{
    
    var id : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["id"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if id != nil{
            dictionary["id"] = id
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "id") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        
    }
    
}
