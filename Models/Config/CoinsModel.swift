//
//  CoinsModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/11.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class CoinsModel: NSObject, NSCoding{
    
    var id : Int!
    var sort : Int!
    var text : String!
    var typeId : Int!
    var value : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["id"] as? Int
        sort = dictionary["sort"] as? Int
        text = dictionary["text"] as? String
        typeId = dictionary["typeId"] as? Int
        value = dictionary["value"] as? String
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
        if sort != nil{
            dictionary["sort"] = sort
        }
        if text != nil{
            dictionary["text"] = text
        }
        if typeId != nil{
            dictionary["typeId"] = typeId
        }
        if value != nil{
            dictionary["value"] = value
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        sort = aDecoder.decodeObject(forKey: "sort") as? Int
        text = aDecoder.decodeObject(forKey: "text") as? String
        typeId = aDecoder.decodeObject(forKey: "typeId") as? Int
        value = aDecoder.decodeObject(forKey: "value") as? String
        
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
        if sort != nil{
            aCoder.encode(sort, forKey: "sort")
        }
        if text != nil{
            aCoder.encode(text, forKey: "text")
        }
        if typeId != nil{
            aCoder.encode(typeId, forKey: "typeId")
        }
        if value != nil{
            aCoder.encode(value, forKey: "value")
        }
        
    }
    
}
