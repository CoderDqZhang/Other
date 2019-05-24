//
//  TipModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/24.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class TipModel : NSObject, NSCoding{
    
    var commentTime : String!
    var commentTotal : Int!
    var content : String!
    var favor : Int!
    var fork : Int!
    var id : Int!
    var image : String!
    var status : String!
    var title : String!
    var tribe : CategoryModel!
    var user : UserInfoModel!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        commentTime = dictionary["commentTime"] as? String
        commentTotal = dictionary["commentTotal"] as? Int
        content = dictionary["content"] as? String
        favor = dictionary["favor"] as? Int
        fork = dictionary["fork"] as? Int
        id = dictionary["id"] as? Int
        image = dictionary["image"] as? String
        status = dictionary["status"] as? String
        title = dictionary["title"] as? String
        if let tribeData = dictionary["tribe"] as? [String:Any]{
            tribe = CategoryModel(fromDictionary: tribeData)
        }
        if let userData = dictionary["user"] as? [String:Any]{
            user = UserInfoModel(fromDictionary: userData)
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if commentTime != nil{
            dictionary["commentTime"] = commentTime
        }
        if commentTotal != nil{
            dictionary["commentTotal"] = commentTotal
        }
        if content != nil{
            dictionary["content"] = content
        }
        if favor != nil{
            dictionary["favor"] = favor
        }
        if fork != nil{
            dictionary["fork"] = fork
        }
        if id != nil{
            dictionary["id"] = id
        }
        if image != nil{
            dictionary["image"] = image
        }
        if status != nil{
            dictionary["status"] = status
        }
        if title != nil{
            dictionary["title"] = title
        }
        if tribe != nil{
            dictionary["tribe"] = tribe.toDictionary()
        }
        if user != nil{
            dictionary["user"] = user.toDictionary()
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        commentTime = aDecoder.decodeObject(forKey: "commentTime") as? String
        commentTotal = aDecoder.decodeObject(forKey: "commentTotal") as? Int
        content = aDecoder.decodeObject(forKey: "content") as? String
        favor = aDecoder.decodeObject(forKey: "favor") as? Int
        fork = aDecoder.decodeObject(forKey: "fork") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? Int
        image = aDecoder.decodeObject(forKey: "image") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
        tribe = aDecoder.decodeObject(forKey: "tribe") as? CategoryModel
        user = aDecoder.decodeObject(forKey: "user") as? UserInfoModel
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if commentTime != nil{
            aCoder.encode(commentTime, forKey: "commentTime")
        }
        if commentTotal != nil{
            aCoder.encode(commentTotal, forKey: "commentTotal")
        }
        if content != nil{
            aCoder.encode(content, forKey: "content")
        }
        if favor != nil{
            aCoder.encode(favor, forKey: "favor")
        }
        if fork != nil{
            aCoder.encode(fork, forKey: "fork")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if image != nil{
            aCoder.encode(image, forKey: "image")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if tribe != nil{
            aCoder.encode(tribe, forKey: "tribe")
        }
        if user != nil{
            aCoder.encode(user, forKey: "user")
        }
        
    }
    
}
