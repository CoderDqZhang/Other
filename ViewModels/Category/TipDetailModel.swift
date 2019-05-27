//
//  TipDetailModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/27.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class TipDetailModel : NSObject, NSCoding{
    
    var tip : TipModel!
    var user : UserInfoModel!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let tipData = dictionary["tip"] as? [String:Any]{
            tip = TipModel(fromDictionary: tipData)
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
        if tip != nil{
            dictionary["tip"] = tip.toDictionary()
        }
        if user != nil{
//            dictionary["user"] = UserInfoModel.
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        tip = aDecoder.decodeObject(forKey: "tip") as? TipModel
        user = aDecoder.decodeObject(forKey: "user") as? UserInfoModel
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if tip != nil{
            aCoder.encode(tip, forKey: "tip")
        }
        if user != nil{
            aCoder.encode(user, forKey: "user")
        }
        
    }
    
}
