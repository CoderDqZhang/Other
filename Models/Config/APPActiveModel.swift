//
//  APPActiveModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/25.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class APPActiveModel : NSObject, NSCoding{
    
    var active : Int!
    var background : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        active = dictionary["active"] as? Int
        background = dictionary["background"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if active != nil{
            dictionary["active"] = active
        }
        if background != nil{
            dictionary["background"] = background
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        active = aDecoder.decodeObject(forKey: "active") as? Int
        background = aDecoder.decodeObject(forKey: "background") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if active != nil{
            aCoder.encode(active, forKey: "active")
        }
        if background != nil{
            aCoder.encode(background, forKey: "background")
        }
        
    }
    
}
