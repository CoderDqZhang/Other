//
//  FansFlowwerModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/29.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class FansFlowwerModel : NSObject, NSCoding{
    
    var descriptionField : String!
    var id : Int!
    var img : String!
    var isFollow : Int!
    var nickname : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        descriptionField = dictionary["description"] as? String
        id = dictionary["id"] as? Int
        img = dictionary["img"] as? String
        isFollow = dictionary["isFollow"] as? Int
        nickname = dictionary["nickname"] as? String
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
        if img != nil{
            dictionary["img"] = img
        }
        if isFollow != nil{
            dictionary["isFollow"] = isFollow
        }
        if nickname != nil{
            dictionary["nickname"] = nickname
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
        img = aDecoder.decodeObject(forKey: "img") as? String
        isFollow = aDecoder.decodeObject(forKey: "isFollow") as? Int
        nickname = aDecoder.decodeObject(forKey: "nickname") as? String
        
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
        if img != nil{
            aCoder.encode(img, forKey: "img")
        }
        if isFollow != nil{
            aCoder.encode(isFollow, forKey: "isFollow")
        }
        if nickname != nil{
            aCoder.encode(nickname, forKey: "nickname")
        }
        
    }
    
}
