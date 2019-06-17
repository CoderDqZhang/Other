//
//  StoreModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class StoreModel : NSObject, NSCoding{
    
    var createTime : String!
    var descriptionField : String!
    var id : Int!
    var inPoint : Int!
    var outPoint : Int!
    var point : Int!
    var title : String!
    var totalPoint : Int!
    var type : String!
    var updateTime : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        createTime = dictionary["createTime"] as? String
        descriptionField = dictionary["description"] as? String
        id = dictionary["id"] as? Int
        inPoint = dictionary["inPoint"] as? Int
        outPoint = dictionary["outPoint"] as? Int
        point = dictionary["point"] as? Int
        title = dictionary["title"] as? String
        totalPoint = dictionary["totalPoint"] as? Int
        type = dictionary["type"] as? String
        updateTime = dictionary["updateTime"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if createTime != nil{
            dictionary["createTime"] = createTime
        }
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if id != nil{
            dictionary["id"] = id
        }
        if inPoint != nil{
            dictionary["inPoint"] = inPoint
        }
        if outPoint != nil{
            dictionary["outPoint"] = outPoint
        }
        if point != nil{
            dictionary["point"] = point
        }
        if title != nil{
            dictionary["title"] = title
        }
        if totalPoint != nil{
            dictionary["totalPoint"] = totalPoint
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
        createTime = aDecoder.decodeObject(forKey: "createTime") as? String
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        inPoint = aDecoder.decodeObject(forKey: "inPoint") as? Int
        outPoint = aDecoder.decodeObject(forKey: "outPoint") as? Int
        point = aDecoder.decodeObject(forKey: "point") as? Int
        title = aDecoder.decodeObject(forKey: "title") as? String
        totalPoint = aDecoder.decodeObject(forKey: "totalPoint") as? Int
        type = aDecoder.decodeObject(forKey: "type") as? String
        updateTime = aDecoder.decodeObject(forKey: "updateTime") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if createTime != nil{
            aCoder.encode(createTime, forKey: "createTime")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if inPoint != nil{
            aCoder.encode(inPoint, forKey: "inPoint")
        }
        if outPoint != nil{
            aCoder.encode(outPoint, forKey: "outPoint")
        }
        if point != nil{
            aCoder.encode(point, forKey: "point")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if totalPoint != nil{
            aCoder.encode(totalPoint, forKey: "totalPoint")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if updateTime != nil{
            aCoder.encode(updateTime, forKey: "updateTime")
        }
        
    }
    
}
