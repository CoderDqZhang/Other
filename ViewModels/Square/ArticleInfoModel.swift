//
//  ArticleInfoModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class ArticleInfoModel : NSObject, NSCoding{
    
    var clickNum : Int!
    var createTime : String!
    var descriptionField : String!
    var id : Int!
    var image : String!
    var isTop : Bool!
    var origin : String!
    var status : Int!
    var title : String!
    var type : Int!
    var updateTime : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        clickNum = dictionary["clickNum"] as? Int
        createTime = dictionary["createTime"] as? String
        descriptionField = dictionary["description"] as? String
        id = dictionary["id"] as? Int
        image = dictionary["image"] as? String
        isTop = dictionary["isTop"] as? Bool
        origin = dictionary["origin"] as? String
        status = dictionary["status"] as? Int
        title = dictionary["title"] as? String
        type = dictionary["type"] as? Int
        updateTime = dictionary["updateTime"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if clickNum != nil{
            dictionary["clickNum"] = clickNum
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
        if image != nil{
            dictionary["image"] = image
        }
        if isTop != nil{
            dictionary["isTop"] = isTop
        }
        if origin != nil{
            dictionary["origin"] = origin
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
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        clickNum = aDecoder.decodeObject(forKey: "clickNum") as? Int
        createTime = aDecoder.decodeObject(forKey: "createTime") as? String
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        image = aDecoder.decodeObject(forKey: "image") as? String
        isTop = aDecoder.decodeObject(forKey: "isTop") as? Bool
        origin = aDecoder.decodeObject(forKey: "origin") as? String
        status = aDecoder.decodeObject(forKey: "status") as? Int
        title = aDecoder.decodeObject(forKey: "title") as? String
        type = aDecoder.decodeObject(forKey: "type") as? Int
        updateTime = aDecoder.decodeObject(forKey: "updateTime") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if clickNum != nil{
            aCoder.encode(clickNum, forKey: "clickNum")
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
        if image != nil{
            aCoder.encode(image, forKey: "image")
        }
        if isTop != nil{
            aCoder.encode(isTop, forKey: "isTop")
        }
        if origin != nil{
            aCoder.encode(origin, forKey: "origin")
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
        
    }
    
}
