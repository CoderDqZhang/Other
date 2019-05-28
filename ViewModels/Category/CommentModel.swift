//
//  CommentModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/27.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class CommentModel : NSObject, NSCoding{
    
    var approveNum : Int!
    var content : String!
    var createTime : String!
    var id : Int!
    var img : String!
    var isFollow : Int!
    var replyList : [ReplyList]!
    var replyNum : Int!
    var user : UserInfoModel!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        approveNum = dictionary["approveNum"] as? Int
        content = dictionary["content"] as? String
        createTime = dictionary["createTime"] as? String
        id = dictionary["id"] as? Int
        img = dictionary["img"] as? String
        isFollow = dictionary["isFollow"] as? Int
        replyList = [ReplyList]()
        if let replyListArray = dictionary["replyList"] as? [[String:Any]]{
            for dic in replyListArray{
                let value = ReplyList(fromDictionary: dic)
                replyList.append(value)
            }
        }
        replyNum = dictionary["replyNum"] as? Int
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
        if approveNum != nil{
            dictionary["approveNum"] = approveNum
        }
        if content != nil{
            dictionary["content"] = content
        }
        if createTime != nil{
            dictionary["createTime"] = createTime
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
        if replyList != nil{
            var dictionaryElements = [[String:Any]]()
            for replyListElement in replyList {
                dictionaryElements.append(replyListElement.toDictionary())
            }
            dictionary["replyList"] = dictionaryElements
        }
        if replyNum != nil{
            dictionary["replyNum"] = replyNum
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
        approveNum = aDecoder.decodeObject(forKey: "approveNum") as? Int
        content = aDecoder.decodeObject(forKey: "content") as? String
        createTime = aDecoder.decodeObject(forKey: "createTime") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        img = aDecoder.decodeObject(forKey: "img") as? String
        isFollow = aDecoder.decodeObject(forKey: "isFollow") as? Int
        replyList = aDecoder.decodeObject(forKey :"replyList") as? [ReplyList]
        replyNum = aDecoder.decodeObject(forKey: "replyNum") as? Int
        user = aDecoder.decodeObject(forKey: "user") as? UserInfoModel
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if approveNum != nil{
            aCoder.encode(approveNum, forKey: "approveNum")
        }
        if content != nil{
            aCoder.encode(content, forKey: "content")
        }
        if createTime != nil{
            aCoder.encode(createTime, forKey: "createTime")
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
        if replyList != nil{
            aCoder.encode(replyList, forKey: "replyList")
        }
        if replyNum != nil{
            aCoder.encode(replyNum, forKey: "replyNum")
        }
        if user != nil{
            aCoder.encode(user, forKey: "user")
        }
        
    }
    
}

class ReplyList : NSObject, NSCoding{
    
    var content : String!
    var createTime : String!
    var followNum : Int!
    var id : Int!
    var img : String!
    var isFollow : Int!
    var nickname : String!
    var toNickname : String!
    var userId : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        content = dictionary["content"] as? String
        createTime = dictionary["createTime"] as? String
        followNum = dictionary["followNum"] as? Int
        id = dictionary["id"] as? Int
        img = dictionary["img"] as? String
        isFollow = dictionary["isFollow"] as? Int
        nickname = dictionary["nickname"] as? String
        toNickname = dictionary["toNickname"] as? String
        userId = dictionary["userId"] as? Int
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
        if createTime != nil{
            dictionary["createTime"] = createTime
        }
        if followNum != nil{
            dictionary["followNum"] = followNum
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
        if toNickname != nil{
            dictionary["toNickname"] = toNickname
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
        content = aDecoder.decodeObject(forKey: "content") as? String
        createTime = aDecoder.decodeObject(forKey: "createTime") as? String
        followNum = aDecoder.decodeObject(forKey: "followNum") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? Int
        img = aDecoder.decodeObject(forKey: "img") as? String
        isFollow = aDecoder.decodeObject(forKey: "isFollow") as? Int
        nickname = aDecoder.decodeObject(forKey: "nickname") as? String
        toNickname = aDecoder.decodeObject(forKey: "toNickname") as? String
        userId = aDecoder.decodeObject(forKey: "userId") as? Int
        
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
        if createTime != nil{
            aCoder.encode(createTime, forKey: "createTime")
        }
        if followNum != nil{
            aCoder.encode(followNum, forKey: "followNum")
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
        if toNickname != nil{
            aCoder.encode(toNickname, forKey: "toNickname")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }
        
    }
    
}
