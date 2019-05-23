//
//  AccountInfoModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/23.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class AccountInfoModel : NSObject, NSCoding{
    
    var bankNo : String!
    var bankPhone : String!
    var chargeCoin : Int!
    var firstNum : Int!
    var integral : Int!
    var inviteCode : String!
    var inviteCoin : Int!
    var inviteNo : Int!
    var recomCoin : Int!
    var secondNum : Int!
    var thirdNum : Int!
    var userId : Int!
    var zfbNo : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        bankNo = dictionary["bankNo"] as? String
        bankPhone = dictionary["bankPhone"] as? String
        chargeCoin = dictionary["chargeCoin"] as? Int
        firstNum = dictionary["firstNum"] as? Int
        integral = dictionary["integral"] as? Int
        inviteCode = dictionary["inviteCode"] as? String
        inviteCoin = dictionary["inviteCoin"] as? Int
        inviteNo = dictionary["inviteNo"] as? Int
        recomCoin = dictionary["recomCoin"] as? Int
        secondNum = dictionary["secondNum"] as? Int
        thirdNum = dictionary["thirdNum"] as? Int
        userId = dictionary["userId"] as? Int
        zfbNo = dictionary["zfbNo"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if bankNo != nil{
            dictionary["bankNo"] = bankNo
        }
        if bankPhone != nil{
            dictionary["bankPhone"] = bankPhone
        }
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
        if zfbNo != nil{
            dictionary["zfbNo"] = zfbNo
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        bankNo = aDecoder.decodeObject(forKey: "bankNo") as? String
        bankPhone = aDecoder.decodeObject(forKey: "bankPhone") as? String
        chargeCoin = aDecoder.decodeObject(forKey: "chargeCoin") as? Int
        firstNum = aDecoder.decodeObject(forKey: "firstNum") as? Int
        integral = aDecoder.decodeObject(forKey: "integral") as? Int
        inviteCode = aDecoder.decodeObject(forKey: "inviteCode") as? String
        inviteCoin = aDecoder.decodeObject(forKey: "inviteCoin") as? Int
        inviteNo = aDecoder.decodeObject(forKey: "inviteNo") as? Int
        recomCoin = aDecoder.decodeObject(forKey: "recomCoin") as? Int
        secondNum = aDecoder.decodeObject(forKey: "secondNum") as? Int
        thirdNum = aDecoder.decodeObject(forKey: "thirdNum") as? Int
        userId = aDecoder.decodeObject(forKey: "userId") as? Int
        zfbNo = aDecoder.decodeObject(forKey: "zfbNo") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if bankNo != nil{
            aCoder.encode(bankNo, forKey: "bankNo")
        }
        if bankPhone != nil{
            aCoder.encode(bankPhone, forKey: "bankPhone")
        }
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
        if zfbNo != nil{
            aCoder.encode(zfbNo, forKey: "zfbNo")
        }
        
    }
    
}
