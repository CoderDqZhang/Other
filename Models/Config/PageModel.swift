//
//  PageModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class PageModel: NSObject, NSCoding{
    
    var current : Int!
    var pages : Int!
    var searchCount : Bool!
    var size : Int!
    var total : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        current = dictionary["current"] as? Int
        pages = dictionary["pages"] as? Int
        searchCount = dictionary["searchCount"] as? Bool
        size = dictionary["size"] as? Int
        total = dictionary["total"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if current != nil{
            dictionary["current"] = current
        }
        if pages != nil{
            dictionary["pages"] = pages
        }
        if searchCount != nil{
            dictionary["searchCount"] = searchCount
        }
        if size != nil{
            dictionary["size"] = size
        }
        if total != nil{
            dictionary["total"] = total
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        current = aDecoder.decodeObject(forKey: "current") as? Int
        pages = aDecoder.decodeObject(forKey: "pages") as? Int
        searchCount = aDecoder.decodeObject(forKey: "searchCount") as? Bool
        size = aDecoder.decodeObject(forKey: "size") as? Int
        total = aDecoder.decodeObject(forKey: "total") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if current != nil{
            aCoder.encode(current, forKey: "current")
        }
        if pages != nil{
            aCoder.encode(pages, forKey: "pages")
        }
        if searchCount != nil{
            aCoder.encode(searchCount, forKey: "searchCount")
        }
        if size != nil{
            aCoder.encode(size, forKey: "size")
        }
        if total != nil{
            aCoder.encode(total, forKey: "total")
        }
        
    }
    
}
