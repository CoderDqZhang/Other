//
//  UserInfoModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import YYModel

class UserInfoModel : NSObject, NSCoding{
    
    var descriptionField : String!
    var email : String!
    var fansNum : Int!
    var followNum : Int!
    var id : Int!
    var idNumber : String!
    var img : String!
    var isFollow : Int!
    var isLive : Int!
    var isMaster : String!
    var isMember : String!
    var lastLoginTime : String!
    var nickname : String!
    var openId : String!
    var phone : String!
    var qqId : String!
    var sex : String!
    var signIn : Int!
    var username : String!
    var wbId : String!
    var token: String!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        descriptionField = dictionary["description"] as? String
        email = dictionary["email"] as? String
        fansNum = dictionary["fansNum"] as? Int
        followNum = dictionary["followNum"] as? Int
        id = dictionary["id"] as? Int
        idNumber = dictionary["idNumber"] as? String
        img = dictionary["img"] as? String
        isFollow = dictionary["isFollow"] as? Int
        isLive = dictionary["isLive"] as? Int
        isMaster = dictionary["isMaster"] as? String
        isMember = dictionary["isMember"] as? String
        lastLoginTime = dictionary["lastLoginTime"] as? String
        nickname = dictionary["nickname"] as? String
        openId = dictionary["openId"] as? String
        phone = dictionary["phone"] as? String
        qqId = dictionary["qqId"] as? String
        sex = dictionary["sex"] as? String
        signIn = dictionary["signIn"] as? Int
        username = dictionary["username"] as? String
        wbId = dictionary["wbId"] as? String
        token = dictionary["token"] as? String
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
        if email != nil{
            dictionary["email"] = email
        }
        if fansNum != nil{
            dictionary["fansNum"] = fansNum
        }
        if followNum != nil{
            dictionary["followNum"] = followNum
        }
        if id != nil{
            dictionary["id"] = id
        }
        if idNumber != nil{
            dictionary["idNumber"] = idNumber
        }
        if img != nil{
            dictionary["img"] = img
        }
        if isFollow != nil{
            dictionary["isFollow"] = isFollow
        }
        if isLive != nil{
            dictionary["isLive"] = isLive
        }
        if isMaster != nil{
            dictionary["isMaster"] = isMaster
        }
        if isMember != nil{
            dictionary["isMember"] = isMember
        }
        if lastLoginTime != nil{
            dictionary["lastLoginTime"] = lastLoginTime
        }
        if nickname != nil{
            dictionary["nickname"] = nickname
        }
        if openId != nil{
            dictionary["openId"] = openId
        }
        if phone != nil{
            dictionary["phone"] = phone
        }
        if qqId != nil{
            dictionary["qqId"] = qqId
        }
        if sex != nil{
            dictionary["sex"] = sex
        }
        if signIn != nil{
            dictionary["signIn"] = signIn
        }
        if username != nil{
            dictionary["username"] = username
        }
        if wbId != nil{
            dictionary["wbId"] = wbId
        }
        if token != nil{
            dictionary["token"] = wbId
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
        email = aDecoder.decodeObject(forKey: "email") as? String
        fansNum = aDecoder.decodeObject(forKey: "fansNum") as? Int
        followNum = aDecoder.decodeObject(forKey: "followNum") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? Int
        idNumber = aDecoder.decodeObject(forKey: "idNumber") as? String
        img = aDecoder.decodeObject(forKey: "img") as? String
        isFollow = aDecoder.decodeObject(forKey: "isFollow") as? Int
        isLive = aDecoder.decodeObject(forKey: "isLive") as? Int
        isMaster = aDecoder.decodeObject(forKey: "isMaster") as? String
        isMember = aDecoder.decodeObject(forKey: "isMember") as? String
        lastLoginTime = aDecoder.decodeObject(forKey: "lastLoginTime") as? String
        nickname = aDecoder.decodeObject(forKey: "nickname") as? String
        openId = aDecoder.decodeObject(forKey: "openId") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        qqId = aDecoder.decodeObject(forKey: "qqId") as? String
        sex = aDecoder.decodeObject(forKey: "sex") as? String
        signIn = aDecoder.decodeObject(forKey: "signIn") as? Int
        username = aDecoder.decodeObject(forKey: "username") as? String
        wbId = aDecoder.decodeObject(forKey: "wbId") as? String
        token = aDecoder.decodeObject(forKey: "token") as? String
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
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if fansNum != nil{
            aCoder.encode(fansNum, forKey: "fansNum")
        }
        if followNum != nil{
            aCoder.encode(followNum, forKey: "followNum")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if idNumber != nil{
            aCoder.encode(idNumber, forKey: "idNumber")
        }
        if img != nil{
            aCoder.encode(img, forKey: "img")
        }
        if isFollow != nil{
            aCoder.encode(isFollow, forKey: "isFollow")
        }
        if isLive != nil{
            aCoder.encode(isLive, forKey: "isLive")
        }
        if isMaster != nil{
            aCoder.encode(isMaster, forKey: "isMaster")
        }
        if isMember != nil{
            aCoder.encode(isMember, forKey: "isMember")
        }
        if lastLoginTime != nil{
            aCoder.encode(lastLoginTime, forKey: "lastLoginTime")
        }
        if nickname != nil{
            aCoder.encode(nickname, forKey: "nickname")
        }
        if openId != nil{
            aCoder.encode(openId, forKey: "openId")
        }
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }
        if qqId != nil{
            aCoder.encode(qqId, forKey: "qqId")
        }
        if sex != nil{
            aCoder.encode(sex, forKey: "sex")
        }
        if signIn != nil{
            aCoder.encode(signIn, forKey: "signIn")
        }
        if username != nil{
            aCoder.encode(username, forKey: "username")
        }
        if wbId != nil{
            aCoder.encode(wbId, forKey: "wbId")
        }
        
        if token != nil{
            aCoder.encode(wbId, forKey: "token")
        }
        
    }
    
}
