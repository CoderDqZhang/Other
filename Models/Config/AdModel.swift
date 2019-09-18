//
//  AdModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/25.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class AdModel : NSObject, NSCoding{
    
    var forwordType : String!
    var id : Int!
    var image : String!
    var params : String!
    var position : Int!
    var secondType : Int!
    var status : String!
    var title : AnyObject!
    var typeId : Int!
    var url : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        forwordType = dictionary["forwordType"] as? String
        id = dictionary["id"] as? Int
        image = dictionary["image"] as? String
        params = dictionary["params"] as? String
        position = dictionary["position"] as? Int
        secondType = dictionary["secondType"] as? Int
        status = dictionary["status"] as? String
        title = dictionary["title"] as? AnyObject
        typeId = dictionary["typeId"] as? Int
        url = dictionary["url"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if forwordType != nil{
            dictionary["forwordType"] = forwordType
        }
        if id != nil{
            dictionary["id"] = id
        }
        if image != nil{
            dictionary["image"] = image
        }
        if params != nil{
            dictionary["params"] = params
        }
        if position != nil{
            dictionary["position"] = position
        }
        if secondType != nil{
            dictionary["secondType"] = secondType
        }
        if status != nil{
            dictionary["status"] = status
        }
        if title != nil{
            dictionary["title"] = title
        }
        if typeId != nil{
            dictionary["typeId"] = typeId
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
        forwordType = aDecoder.decodeObject(forKey: "forwordType") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        image = aDecoder.decodeObject(forKey: "image") as? String
        params = aDecoder.decodeObject(forKey: "params") as? String
        position = aDecoder.decodeObject(forKey: "position") as? Int
        secondType = aDecoder.decodeObject(forKey: "secondType") as? Int
        status = aDecoder.decodeObject(forKey: "status") as? String
        title = aDecoder.decodeObject(forKey: "title") as? AnyObject
        typeId = aDecoder.decodeObject(forKey: "typeId") as? Int
        url = aDecoder.decodeObject(forKey: "url") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if forwordType != nil{
            aCoder.encode(forwordType, forKey: "forwordType")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if image != nil{
            aCoder.encode(image, forKey: "image")
        }
        if params != nil{
            aCoder.encode(params, forKey: "params")
        }
        if position != nil{
            aCoder.encode(position, forKey: "position")
        }
        if secondType != nil{
            aCoder.encode(secondType, forKey: "secondType")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if typeId != nil{
            aCoder.encode(typeId, forKey: "typeId")
        }
        if url != nil{
            aCoder.encode(url, forKey: "url")
        }
        
    }
    
}
