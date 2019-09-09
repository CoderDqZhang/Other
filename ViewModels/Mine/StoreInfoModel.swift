//
//  StoreInfoModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/23.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class StoreInfoModel : NSObject, NSCoding{
    
    var content : String!
    var createTime : String!
    var id : Int!
    var image : String!
    var price : Int!
    var status : Int!
    var title : String!
    var updateTime : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        content = dictionary["content"] as? String
        createTime = dictionary["createTime"] as? String
        id = dictionary["id"] as? Int
        image = dictionary["image"] as? String
        price = dictionary["price"] as? Int
        status = dictionary["status"] as? Int
        title = dictionary["title"] as? String
        updateTime = dictionary["updateTime"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if content != nil{
            dictionary["content"] = content
        }
        if createTime != nil{
            dictionary["createTime"] = createTime
        }
        if id != nil{
            dictionary["id"] = id
        }
        if image != nil{
            dictionary["image"] = image
        }
        if price != nil{
            dictionary["price"] = price
        }
        if status != nil{
            dictionary["status"] = status
        }
        if title != nil{
            dictionary["title"] = title
        }
        if updateTime != nil{
            dictionary["updateTime"] = updateTime
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        content = aDecoder.decodeObject(forKey: "content") as? String
        createTime = aDecoder.decodeObject(forKey: "createTime") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        image = aDecoder.decodeObject(forKey: "image") as? String
        price = aDecoder.decodeObject(forKey: "price") as? Int
        status = aDecoder.decodeObject(forKey: "status") as? Int
        title = aDecoder.decodeObject(forKey: "title") as? String
        updateTime = aDecoder.decodeObject(forKey: "updateTime") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if content != nil{
            aCoder.encode(content, forKey: "content")
        }
        if createTime != nil{
            aCoder.encode(createTime, forKey: "createTime")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if image != nil{
            aCoder.encode(image, forKey: "image")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if updateTime != nil{
            aCoder.encode(updateTime, forKey: "updateTime")
        }
        
    }
    
}
