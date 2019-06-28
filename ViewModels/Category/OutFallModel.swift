
//
//  OutFallModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/25.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class OutFallModel: NSObject, NSCoding{
    
    var cnContent : String!
    var commentTime : String!
    var commentTotal : AnyObject!
    var content : String!
    var createTime : String!
    var favor : Int!
    var fork : Int!
    var id : Int!
    var image : String!
    var img : String!
    var isCollect : Int!
    var isFork : Int!
    var nickname : String!
    var status : String!
    var title : String!
    var userId : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        cnContent = dictionary["cnContent"] as? String
        commentTime = dictionary["commentTime"] as? String
        commentTotal = dictionary["commentTotal"] as? AnyObject
        content = dictionary["content"] as? String
        createTime = dictionary["createTime"] as? String
        favor = dictionary["favor"] as? Int
        fork = dictionary["fork"] as? Int
        id = dictionary["id"] as? Int
        image = dictionary["image"] as? String
        img = dictionary["img"] as? String
        isCollect = dictionary["isCollect"] as? Int
        isFork = dictionary["isFork"] as? Int
        nickname = dictionary["nickname"] as? String
        status = dictionary["status"] as? String
        title = dictionary["title"] as? String
        userId = dictionary["userId"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if cnContent != nil{
            dictionary["cnContent"] = cnContent
        }
        if commentTime != nil{
            dictionary["commentTime"] = commentTime
        }
        if commentTotal != nil{
            dictionary["commentTotal"] = commentTotal
        }
        if content != nil{
            dictionary["content"] = content
        }
        if createTime != nil{
            dictionary["createTime"] = createTime
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
        if img != nil{
            dictionary["img"] = img
        }
        if isCollect != nil{
            dictionary["isCollect"] = isCollect
        }
        if isFork != nil{
            dictionary["isFork"] = isFork
        }
        if nickname != nil{
            dictionary["nickname"] = nickname
        }
        if status != nil{
            dictionary["status"] = status
        }
        if title != nil{
            dictionary["title"] = title
        }
        if userId != nil{
            dictionary["userId"] = userId
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        cnContent = aDecoder.decodeObject(forKey: "cnContent") as? String
        commentTime = aDecoder.decodeObject(forKey: "commentTime") as? String
        commentTotal = aDecoder.decodeObject(forKey: "commentTotal") as? AnyObject
        content = aDecoder.decodeObject(forKey: "content") as? String
        createTime = aDecoder.decodeObject(forKey: "createTime") as? String
        favor = aDecoder.decodeObject(forKey: "favor") as? Int
        fork = aDecoder.decodeObject(forKey: "fork") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? Int
        image = aDecoder.decodeObject(forKey: "image") as? String
        img = aDecoder.decodeObject(forKey: "img") as? String
        isCollect = aDecoder.decodeObject(forKey: "isCollect") as? Int
        isFork = aDecoder.decodeObject(forKey: "isFork") as? Int
        nickname = aDecoder.decodeObject(forKey: "nickname") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
        userId = aDecoder.decodeObject(forKey: "userId") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if cnContent != nil{
            aCoder.encode(cnContent, forKey: "cnContent")
        }
        if commentTime != nil{
            aCoder.encode(commentTime, forKey: "commentTime")
        }
        if commentTotal != nil{
            aCoder.encode(commentTotal, forKey: "commentTotal")
        }
        if content != nil{
            aCoder.encode(content, forKey: "content")
        }
        if createTime != nil{
            aCoder.encode(createTime, forKey: "createTime")
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
        if img != nil{
            aCoder.encode(img, forKey: "img")
        }
        if isCollect != nil{
            aCoder.encode(isCollect, forKey: "isCollect")
        }
        if isFork != nil{
            aCoder.encode(isFork, forKey: "isFork")
        }
        if nickname != nil{
            aCoder.encode(nickname, forKey: "nickname")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }
        
    }
    
}
