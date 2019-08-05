//
//  BallTeamModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/5.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class BallTeamModel : NSObject, NSCoding{
    
    var found : String!
    var id : Int!
    var logo : String!
    var matcheventId : Int!
    var nameEn : String!
    var nameZh : String!
    var nameZht : String!
    var website : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        found = dictionary["found"] as? String
        id = dictionary["id"] as? Int
        logo = dictionary["logo"] as? String
        matcheventId = dictionary["matchevent_id"] as? Int
        nameEn = dictionary["name_en"] as? String
        nameZh = dictionary["name_zh"] as? String
        nameZht = dictionary["name_zht"] as? String
        website = dictionary["website"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if found != nil{
            dictionary["found"] = found
        }
        if id != nil{
            dictionary["id"] = id
        }
        if logo != nil{
            dictionary["logo"] = logo
        }
        if matcheventId != nil{
            dictionary["matchevent_id"] = matcheventId
        }
        if nameEn != nil{
            dictionary["name_en"] = nameEn
        }
        if nameZh != nil{
            dictionary["name_zh"] = nameZh
        }
        if nameZht != nil{
            dictionary["name_zht"] = nameZht
        }
        if website != nil{
            dictionary["website"] = website
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        found = aDecoder.decodeObject(forKey: "found") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        logo = aDecoder.decodeObject(forKey: "logo") as? String
        matcheventId = aDecoder.decodeObject(forKey: "matchevent_id") as? Int
        nameEn = aDecoder.decodeObject(forKey: "name_en") as? String
        nameZh = aDecoder.decodeObject(forKey: "name_zh") as? String
        nameZht = aDecoder.decodeObject(forKey: "name_zht") as? String
        website = aDecoder.decodeObject(forKey: "website") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if found != nil{
            aCoder.encode(found, forKey: "found")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if logo != nil{
            aCoder.encode(logo, forKey: "logo")
        }
        if matcheventId != nil{
            aCoder.encode(matcheventId, forKey: "matchevent_id")
        }
        if nameEn != nil{
            aCoder.encode(nameEn, forKey: "name_en")
        }
        if nameZh != nil{
            aCoder.encode(nameZh, forKey: "name_zh")
        }
        if nameZht != nil{
            aCoder.encode(nameZht, forKey: "name_zht")
        }
        if website != nil{
            aCoder.encode(website, forKey: "website")
        }
        
    }
    
}

class BallTeamSqlModel : NSObject, NSCoding{
    
    var id : Int!
    var team : BallTeamModel!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["id"] as? Int
        if let teamData = dictionary["team"] as? [String:Any]{
            team = BallTeamModel(fromDictionary: teamData)
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if id != nil{
            dictionary["id"] = id
        }
        if team != nil{
            dictionary["team"] = team.toDictionary()
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        team = aDecoder.decodeObject(forKey: "team") as? BallTeamModel
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if team != nil{
            aCoder.encode(team, forKey: "team")
        }
        
    }
    
}
