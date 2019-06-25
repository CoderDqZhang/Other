//
//  DailyModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/12.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class DailyModel : NSObject, NSCoding{
    
    var signIn : Int!
    var status : Int!
    var points : String = "0"
    var maxPoint : Float = 0
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        signIn = dictionary["signIn"] as? Int
        status = dictionary["status"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if signIn != nil{
            dictionary["signIn"] = signIn
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        signIn = aDecoder.decodeObject(forKey: "signIn") as? Int
        status = aDecoder.decodeObject(forKey: "status") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if signIn != nil{
            aCoder.encode(signIn, forKey: "signIn")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        
    }
    
}
