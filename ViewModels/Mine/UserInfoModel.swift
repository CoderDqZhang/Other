//
//  UserInfoModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import YYModel

class UserInfoModel : NSObject, NSCoding, YYModel{
    
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
    var nickname : String!
    var phone : String!
    var refreshTime : Int!
    var signIn : Int!
    var token : String!
    var username : String!
    
    
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
        nickname = dictionary["nickname"] as? String
        phone = dictionary["phone"] as? String
        refreshTime = dictionary["refreshTime"] as? Int
        signIn = dictionary["signIn"] as? Int
        token = dictionary["token"] as? String
        username = dictionary["username"] as? String
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
        if nickname != nil{
            dictionary["nickname"] = nickname
        }
        if phone != nil{
            dictionary["phone"] = phone
        }
        if refreshTime != nil{
            dictionary["refreshTime"] = refreshTime
        }
        if signIn != nil{
            dictionary["signIn"] = signIn
        }
        if token != nil{
            dictionary["token"] = token
        }
        if username != nil{
            dictionary["username"] = username
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
        nickname = aDecoder.decodeObject(forKey: "nickname") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        refreshTime = aDecoder.decodeObject(forKey: "refreshTime") as? Int
        signIn = aDecoder.decodeObject(forKey: "signIn") as? Int
        token = aDecoder.decodeObject(forKey: "token") as? String
        username = aDecoder.decodeObject(forKey: "username") as? String
        
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
        if nickname != nil{
            aCoder.encode(nickname, forKey: "nickname")
        }
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }
        if refreshTime != nil{
            aCoder.encode(refreshTime, forKey: "refreshTime")
        }
        if signIn != nil{
            aCoder.encode(signIn, forKey: "signIn")
        }
        if token != nil{
            aCoder.encode(token, forKey: "token")
        }
        if username != nil{
            aCoder.encode(username, forKey: "username")
        }
        
    }
    
}
