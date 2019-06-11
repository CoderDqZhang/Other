//
//  InviteModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/11.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class InviteModel : NSObject, NSCoding{
    
    var chargeCoin : Double!
    var firstNum : Int!
    var integral : Double!
    var inviteCode : String!
    var inviteCoin : Double!
    var inviteNo : Int!
    var recomCoin : Double!
    var secondNum : Int!
    var thirdNum : Int!
    var userId : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        chargeCoin = dictionary["chargeCoin"] as? Double
        firstNum = dictionary["firstNum"] as? Int
        integral = dictionary["integral"] as? Double
        inviteCode = dictionary["inviteCode"] as? String
        inviteCoin = dictionary["inviteCoin"] as? Double
        inviteNo = dictionary["inviteNo"] as? Int
        recomCoin = dictionary["recomCoin"] as? Double
        secondNum = dictionary["secondNum"] as? Int
        thirdNum = dictionary["thirdNum"] as? Int
        userId = dictionary["userId"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if chargeCoin != nil{
            dictionary["chargeCoin"] = chargeCoin
        }
        if firstNum != nil{
            dictionary["firstNum"] = firstNum
        }
        if integral != nil{
            dictionary["integral"] = integral
        }
        if inviteCode != nil{
            dictionary["inviteCode"] = inviteCode
        }
        if inviteCoin != nil{
            dictionary["inviteCoin"] = inviteCoin
        }
        if inviteNo != nil{
            dictionary["inviteNo"] = inviteNo
        }
        if recomCoin != nil{
            dictionary["recomCoin"] = recomCoin
        }
        if secondNum != nil{
            dictionary["secondNum"] = secondNum
        }
        if thirdNum != nil{
            dictionary["thirdNum"] = thirdNum
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
        chargeCoin = aDecoder.decodeObject(forKey: "chargeCoin") as? Double
        firstNum = aDecoder.decodeObject(forKey: "firstNum") as? Int
        integral = aDecoder.decodeObject(forKey: "integral") as? Double
        inviteCode = aDecoder.decodeObject(forKey: "inviteCode") as? String
        inviteCoin = aDecoder.decodeObject(forKey: "inviteCoin") as? Double
        inviteNo = aDecoder.decodeObject(forKey: "inviteNo") as? Int
        recomCoin = aDecoder.decodeObject(forKey: "recomCoin") as? Double
        secondNum = aDecoder.decodeObject(forKey: "secondNum") as? Int
        thirdNum = aDecoder.decodeObject(forKey: "thirdNum") as? Int
        userId = aDecoder.decodeObject(forKey: "userId") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if chargeCoin != nil{
            aCoder.encode(chargeCoin, forKey: "chargeCoin")
        }
        if firstNum != nil{
            aCoder.encode(firstNum, forKey: "firstNum")
        }
        if integral != nil{
            aCoder.encode(integral, forKey: "integral")
        }
        if inviteCode != nil{
            aCoder.encode(inviteCode, forKey: "inviteCode")
        }
        if inviteCoin != nil{
            aCoder.encode(inviteCoin, forKey: "inviteCoin")
        }
        if inviteNo != nil{
            aCoder.encode(inviteNo, forKey: "inviteNo")
        }
        if recomCoin != nil{
            aCoder.encode(recomCoin, forKey: "recomCoin")
        }
        if secondNum != nil{
            aCoder.encode(secondNum, forKey: "secondNum")
        }
        if thirdNum != nil{
            aCoder.encode(thirdNum, forKey: "thirdNum")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }
        
    }
    
}
