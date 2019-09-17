//
//  NorthSigleModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/14.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class NorthSigleModel : NSObject, NSCoding{
    
    var away : String!
    var comp : String!
    var eventsName : String!
    var home : String!
    var isSelect : Bool!
    var id : Int!
    var issue : Int!
    var issueNum : Int!
    var matchId : String!
    var matchTime : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        away = dictionary["away"] as? String
        comp = dictionary["comp"] as? String
        eventsName = dictionary["eventsName"] as? String
        home = dictionary["home"] as? String
        id = dictionary["id"] as? Int
        isSelect = dictionary["is_select"] as? Bool
        issue = dictionary["issue"] as? Int
        issueNum = dictionary["issue_num"] as? Int
        matchId = dictionary["match_id"] as? String
        matchTime = dictionary["match_time"] as? Int
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
        if comp != nil{
            dictionary["comp"] = comp
        }
        if isSelect != nil{
            dictionary["is_select"] = isSelect
        }
        if eventsName != nil{
            dictionary["eventsName"] = eventsName
        }
        if home != nil{
            dictionary["home"] = home
        }
        if id != nil{
            dictionary["id"] = id
        }
        if issue != nil{
            dictionary["issue"] = issue
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
        eventsName = aDecoder.decodeObject(forKey: "eventsName") as? String
        home = aDecoder.decodeObject(forKey: "home") as? String
        isSelect = aDecoder.decodeObject(forKey: "is_select") as? Bool
        id = aDecoder.decodeObject(forKey: "id") as? Int
        issue = aDecoder.decodeObject(forKey: "issue") as? Int
        issueNum = aDecoder.decodeObject(forKey: "issue_num") as? Int
        matchId = aDecoder.decodeObject(forKey: "match_id") as? String
        matchTime = aDecoder.decodeObject(forKey: "match_time") as? Int
        
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
        if comp != nil{
            aCoder.encode(comp, forKey: "comp")
        }
        if eventsName != nil{
            aCoder.encode(eventsName, forKey: "eventsName")
        }
        if home != nil{
            aCoder.encode(home, forKey: "home")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if issue != nil{
            aCoder.encode(issue, forKey: "issue")
        }
        if issueNum != nil{
            aCoder.encode(issueNum, forKey: "issue_num")
        }
        if isSelect != nil{
            aCoder.encode(isSelect, forKey: "is_select")
        }
        if matchId != nil{
            aCoder.encode(matchId, forKey: "match_id")
        }
        if matchTime != nil{
            aCoder.encode(matchTime, forKey: "match_time")
        }
        
    }
    
}
