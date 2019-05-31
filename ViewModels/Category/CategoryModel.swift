//
//  CategoryModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/23.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class CategoryModel : NSObject, NSCoding{
    
    var descriptionField : String!
    var id : Int!
    var tipNo : Int!
    var tribeBg : String!
    var tribeFork : Int!
    var tribeImg : String!
    var tribeName : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        descriptionField = dictionary["description"] as? String
        id = dictionary["id"] as? Int
        tipNo = dictionary["tipNo"] as? Int
        tribeBg = dictionary["tribeBg"] as? String
        tribeFork = dictionary["tribeFork"] as? Int
        tribeImg = dictionary["tribeImg"] as? String
        tribeName = dictionary["tribeName"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if id != nil{
            dictionary["id"] = id
        }
        if tipNo != nil{
            dictionary["tipNo"] = tipNo
        }
        if tribeBg != nil{
            dictionary["tribeBg"] = tribeBg
        }
        if tribeFork != nil{
            dictionary["tribeFork"] = tribeFork
        }
        if tribeImg != nil{
            dictionary["tribeImg"] = tribeImg
        }
        if tribeName != nil{
            dictionary["tribeName"] = tribeName
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        tipNo = aDecoder.decodeObject(forKey: "tipNo") as? Int
        tribeBg = aDecoder.decodeObject(forKey: "tribeBg") as? String
        tribeFork = aDecoder.decodeObject(forKey: "tribeFork") as? Int
        tribeImg = aDecoder.decodeObject(forKey: "tribeImg") as? String
        tribeName = aDecoder.decodeObject(forKey: "tribeName") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if tipNo != nil{
            aCoder.encode(tipNo, forKey: "tipNo")
        }
        if tribeBg != nil{
            aCoder.encode(tribeBg, forKey: "tribeBg")
        }
        if tribeFork != nil{
            aCoder.encode(tribeFork, forKey: "tribeFork")
        }
        if tribeImg != nil{
            aCoder.encode(tribeImg, forKey: "tribeImg")
        }
        if tribeName != nil{
            aCoder.encode(tribeName, forKey: "tribeName")
        }
        
    }
    
}
