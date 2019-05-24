//
//  PostModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/24.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class PostModel : NSObject, NSCoding{
    
    var content : String!
    var images : NSMutableArray!
    var title : String!
    var tribe : CategoryModel!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        content = dictionary["content"] as? String
        images = dictionary["images"] as? NSMutableArray
        title = dictionary["title"] as? String
        if let tribeData = dictionary["tribe"] as? [String:Any]{
            tribe = CategoryModel(fromDictionary: tribeData)
        }
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
        if images != nil{
            dictionary["images"] = images
        }
        if title != nil{
            dictionary["title"] = title
        }
        if tribe != nil{
            dictionary["tribe"] = tribe.toDictionary()
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
        images = aDecoder.decodeObject(forKey: "images") as? NSMutableArray
        title = aDecoder.decodeObject(forKey: "title") as? String
        tribe = aDecoder.decodeObject(forKey: "tribe") as? CategoryModel
        
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
        if images != nil{
            aCoder.encode(images, forKey: "images")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if tribe != nil{
            aCoder.encode(tribe, forKey: "tribe")
        }
        
    }
    
}
