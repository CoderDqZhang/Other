//
//  BasketBallModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/7.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class BasketBallModel  : NSObject, NSCoding{
    
    var allSecond : Int!
    var basketBallTeamA : BasketBallteamA!
    var basketballEvent : BasketBallEventModel!
    var basketballRemark : BasketballRemark!
    var basketballTeamB : BasketBallteamA!
//    var basketIndex : BasketBallIndexModel!
    var id : Int!
    var section : Int!
    var status : Int!
    var time : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        allSecond = dictionary["all_second"] as? Int
        if let basketBallteamAData = dictionary["basketball_teamA"] as? [String:Any]{
            basketBallTeamA = BasketBallteamA(fromDictionary: basketBallteamAData)
        }
        if let basketballEventData = dictionary["basketball_event"] as? [String:Any]{
            basketballEvent = BasketBallEventModel(fromDictionary: basketballEventData)
        }
        if let basketballRemarkData = dictionary["basketball_remark"] as? [String:Any]{
            basketballRemark = BasketballRemark(fromDictionary: basketballRemarkData)
        }
        if let basketballTeamBData = dictionary["basketball_teamB"] as? [String:Any]{
            basketballTeamB = BasketBallteamA(fromDictionary: basketballTeamBData)
        }
        id = dictionary["id"] as? Int
        section = dictionary["section"] as? Int
        status = dictionary["status"] as? Int
        time = dictionary["time"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if allSecond != nil{
            dictionary["all_second"] = allSecond
        }
        if basketBallTeamA != nil{
            dictionary["basketball_teamA"] = basketBallTeamA.toDictionary()
        }
        if basketballEvent != nil{
            dictionary["basketball_event"] = basketballEvent.toDictionary()
        }
        if basketballRemark != nil{
            dictionary["basketball_remark"] = basketballRemark.toDictionary()
        }
        if basketballTeamB != nil{
            dictionary["basketball_teamB"] = basketballTeamB.toDictionary()
        }
        if id != nil{
            dictionary["id"] = id
        }
        if section != nil{
            dictionary["section"] = section
        }
        if status != nil{
            dictionary["status"] = status
        }
        if time != nil{
            dictionary["time"] = time
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        allSecond = aDecoder.decodeObject(forKey: "all_second") as? Int
        basketBallTeamA = aDecoder.decodeObject(forKey: "basketball_teamA") as? BasketBallteamA
        basketballEvent = aDecoder.decodeObject(forKey: "basketball_event") as? BasketBallEventModel
        basketballRemark = aDecoder.decodeObject(forKey: "basketball_remark") as? BasketballRemark
        basketballTeamB = aDecoder.decodeObject(forKey: "basketball_teamB") as? BasketBallteamA
        id = aDecoder.decodeObject(forKey: "id") as? Int
        section = aDecoder.decodeObject(forKey: "section") as? Int
        status = aDecoder.decodeObject(forKey: "status") as? Int
        time = aDecoder.decodeObject(forKey: "time") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if allSecond != nil{
            aCoder.encode(allSecond, forKey: "all_second")
        }
        if basketBallTeamA != nil{
            aCoder.encode(basketBallTeamA, forKey: "basketball_teamA")
        }
        if basketballEvent != nil{
            aCoder.encode(basketballEvent, forKey: "basketball_event")
        }
        if basketballRemark != nil{
            aCoder.encode(basketballRemark, forKey: "basketball_remark")
        }
        if basketballTeamB != nil{
            aCoder.encode(basketballTeamB, forKey: "basketball_teamB")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if section != nil{
            aCoder.encode(section, forKey: "section")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if time != nil{
            aCoder.encode(time, forKey: "time")
        }
        
    }
    
}

class BasketballRemark : NSObject, NSCoding{
    
    var remarkDetail : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        remarkDetail = dictionary["remark_detail"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if remarkDetail != nil{
            dictionary["remark_detail"] = remarkDetail
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        remarkDetail = aDecoder.decodeObject(forKey: "remark_detail") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if remarkDetail != nil{
            aCoder.encode(remarkDetail, forKey: "remark_detail")
        }
        
    }
    
}

class BasketBallteamA : NSObject, NSCoding{
    
    var basketballTeamInfo : BasketballTeamInfo!
    var first : Int!
    var four : Int!
    var overtime : Int!
    var second : Int!
    var sort : String!
    var third : Int!
    var teamName : String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let basketballTeamInfoData = dictionary["basketball_team_info"] as? [String:Any]{
            basketballTeamInfo = BasketballTeamInfo(fromDictionary: basketballTeamInfoData)
        }
        first = dictionary["first"] as? Int
        four = dictionary["four"] as? Int
        overtime = dictionary["overtime"] as? Int
        second = dictionary["second"] as? Int
        sort = dictionary["sort"] as? String
        third = dictionary["third"] as? Int
        teamName = dictionary["team_name"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if basketballTeamInfo != nil{
            dictionary["basketball_team_info"] = basketballTeamInfo.toDictionary()
        }
        if teamName != nil{
            dictionary["team_name"] = teamName
        }
        if first != nil{
            dictionary["first"] = first
        }
        if four != nil{
            dictionary["four"] = four
        }
        if overtime != nil{
            dictionary["overtime"] = overtime
        }
        if second != nil{
            dictionary["second"] = second
        }
        if sort != nil{
            dictionary["sort"] = sort
        }
        
        if third != nil{
            dictionary["third"] = third
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        basketballTeamInfo = aDecoder.decodeObject(forKey: "basketball_team_info") as? BasketballTeamInfo
        first = aDecoder.decodeObject(forKey: "first") as? Int
        teamName = aDecoder.decodeObject(forKey: "team_name") as? String
        four = aDecoder.decodeObject(forKey: "four") as? Int
        overtime = aDecoder.decodeObject(forKey: "overtime") as? Int
        second = aDecoder.decodeObject(forKey: "second") as? Int
        sort = aDecoder.decodeObject(forKey: "sort") as? String
        third = aDecoder.decodeObject(forKey: "third") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if basketballTeamInfo != nil{
            aCoder.encode(basketballTeamInfo, forKey: "basketball_team_info")
        }
        if first != nil{
            aCoder.encode(first, forKey: "first")
        }
        if four != nil{
            aCoder.encode(four, forKey: "four")
        }
        if overtime != nil{
            aCoder.encode(overtime, forKey: "overtime")
        }
        if second != nil{
            aCoder.encode(second, forKey: "second")
        }
        if sort != nil{
            aCoder.encode(sort, forKey: "sort")
        }
        if third != nil{
            aCoder.encode(third, forKey: "third")
        }
        if teamName != nil{
            aCoder.encode(teamName, forKey: "team_name")
        }
        
    }
    
}

class BasketballTeamInfo : NSObject, NSCoding{
    
    var id : Int!
    var logo : String!
    var matcheventId : Int!
    var nameEn : String!
    var nameZh : String!
    var nameZht : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["id"] as? Int
        logo = dictionary["logo"] as? String
        matcheventId = dictionary["matchevent_id"] as? Int
        nameEn = dictionary["name_en"] as? String
        nameZh = dictionary["name_zh"] as? String
        nameZht = dictionary["name_zht"] as? String
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
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        logo = aDecoder.decodeObject(forKey: "logo") as? String
        matcheventId = aDecoder.decodeObject(forKey: "matchevent_id") as? Int
        nameEn = aDecoder.decodeObject(forKey: "name_en") as? String
        nameZh = aDecoder.decodeObject(forKey: "name_zh") as? String
        nameZht = aDecoder.decodeObject(forKey: "name_zht") as? String
        
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
        
    }
    
}
