//
//  UnreadMessageModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class UnreadMessageModel : NSObject, NSCoding{
    
    var approveMine : Int!
    var atMine : Int!
    var commentMine : Int!
    var violation : Int!
    var allunread : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        approveMine = dictionary["approveMine"] as? Int
        atMine = dictionary["atMine"] as? Int
        commentMine = dictionary["commentMine"] as? Int
        violation = dictionary["violation"] as? Int
        allunread = approveMine + atMine + commentMine + violation
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if approveMine != nil{
            dictionary["approveMine"] = approveMine
        }
        if atMine != nil{
            dictionary["atMine"] = atMine
        }
        if commentMine != nil{
            dictionary["commentMine"] = commentMine
        }
        if violation != nil{
            dictionary["violation"] = violation
        }
        if allunread != nil{
            dictionary["allunread"] = allunread
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        approveMine = aDecoder.decodeObject(forKey: "approveMine") as? Int
        atMine = aDecoder.decodeObject(forKey: "atMine") as? Int
        commentMine = aDecoder.decodeObject(forKey: "commentMine") as? Int
        violation = aDecoder.decodeObject(forKey: "violation") as? Int
        allunread = aDecoder.decodeObject(forKey: "allunread") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if approveMine != nil{
            aCoder.encode(approveMine, forKey: "approveMine")
        }
        if atMine != nil{
            aCoder.encode(atMine, forKey: "atMine")
        }
        if commentMine != nil{
            aCoder.encode(commentMine, forKey: "commentMine")
        }
        if violation != nil{
            aCoder.encode(violation, forKey: "violation")
        }
        if allunread != nil{
            aCoder.encode(allunread, forKey: "allunread")
        }
        
    }
    
}
