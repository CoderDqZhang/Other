//
//  BasketBallIndexModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/19.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class BasketBallIndexModel : NSObject, NSCoding{
    
    var away : String!
    var comp : String!
    var home : String!
    var id : Int!
    var isSelect : Bool!
    var issueNum : String!
    var matchId : Int!
    var matchTime : Int!
    var eventsName : String!
    var matchIds : [String]!
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        away = dictionary["away"] as? String
        comp = dictionary["comp"] as? String
        home = dictionary["home"] as? String
        eventsName = dictionary["eventsName"] as? String
        id = dictionary["id"] as? Int
        isSelect = dictionary["is_select"] as? Bool
        issueNum = dictionary["issue_num"] as? String
        matchId = dictionary["match_id"] as? Int
        matchTime = dictionary["match_time"] as? Int
        matchIds = [dictionary["match_ids"]] as? [String]
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if away != nil{
            dictionary["away"] = away
        }
        if eventsName != nil{
            dictionary["eventsName"] = eventsName
        }
        if comp != nil{
            dictionary["comp"] = comp
        }
        if home != nil{
            dictionary["home"] = home
        }
        if id != nil{
            dictionary["id"] = id
        }
        if isSelect != nil{
            dictionary["is_select"] = isSelect
        }
        if issueNum != nil{
            dictionary["issue_num"] = issueNum
        }
        if matchId != nil{
            dictionary["match_id"] = matchId
        }
        if matchTime != nil{
            dictionary["match_time"] = matchTime
        }
        if matchIds != nil{
            dictionary["match_ids"] = matchIds
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        away = aDecoder.decodeObject(forKey: "away") as? String
        comp = aDecoder.decodeObject(forKey: "comp") as? String
        home = aDecoder.decodeObject(forKey: "home") as? String
        eventsName = aDecoder.decodeObject(forKey: "eventsName") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        isSelect = aDecoder.decodeObject(forKey: "is_select") as? Bool
        issueNum = aDecoder.decodeObject(forKey: "issue_num") as? String
        matchId = aDecoder.decodeObject(forKey: "match_id") as? Int
        matchTime = aDecoder.decodeObject(forKey: "match_time") as? Int
        matchIds = aDecoder.decodeObject(forKey: "match_ids") as? [String]
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if away != nil{
            aCoder.encode(away, forKey: "away")
        }
        if eventsName != nil{
            aCoder.encode(eventsName, forKey: "eventsName")
        }
        if comp != nil{
            aCoder.encode(comp, forKey: "comp")
        }
        if home != nil{
            aCoder.encode(home, forKey: "home")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if isSelect != nil{
            aCoder.encode(isSelect, forKey: "is_select")
        }
        if issueNum != nil{
            aCoder.encode(issueNum, forKey: "issue_num")
        }
        if matchId != nil{
            aCoder.encode(matchId, forKey: "match_id")
        }
        if matchTime != nil{
            aCoder.encode(matchTime, forKey: "match_time")
        }
        if matchIds != nil{
            aCoder.encode(matchIds, forKey: "match_ids")
        }
        
    }
    
}

