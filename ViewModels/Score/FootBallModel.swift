//
//  FootBallModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/1.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class FootBallModel : NSObject, NSCoding{
    
    var eventInfo : FootBallEventModel!
    var northSigle : NorthSigleModel!
    var footballLottery : FootBallLotteryModel!
    var id : Int!
    var remark : Remark!
    var season : Season!
    var stage : Stage!
    var startTime : Int!
    var status : Int!
    var teamA : Team!
    var teamB : Team!
    var time : Int!
    var isSelect: Bool!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let eventInfoData = dictionary["event_info"] as? [String:Any]{
            eventInfo = FootBallEventModel(fromDictionary: eventInfoData)
        }
        if let northSigleData = dictionary["north_sigle"] as? [String:Any]{
            northSigle = NorthSigleModel(fromDictionary: northSigleData)
        }
        if let footballLotteryData = dictionary["lottery"] as? [String:Any]{
            footballLottery = FootBallLotteryModel(fromDictionary: footballLotteryData)
        }
        id = dictionary["id"] as? Int
        if let remarkData = dictionary["remark"] as? [String:Any]{
            remark = Remark(fromDictionary: remarkData)
        }
        if let seasonData = dictionary["season"] as? [String:Any]{
            season = Season(fromDictionary: seasonData)
        }
        if let stageData = dictionary["stage"] as? [String:Any]{
            stage = Stage(fromDictionary: stageData)
        }
        isSelect = dictionary["is_select"] as? Bool
        startTime = dictionary["start_time"] as? Int
        status = dictionary["status"] as? Int
        if let teamAData = dictionary["teamA"] as? [String:Any]{
            teamA = Team(fromDictionary: teamAData)
        }
        if let teamBData = dictionary["teamB"] as? [String:Any]{
            teamB = Team(fromDictionary: teamBData)
        }
        time = dictionary["time"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if eventInfo != nil{
            dictionary["event_info"] = eventInfo.toDictionary()
        }
        if northSigle != nil{
            dictionary["north_sigle"] = northSigle.toDictionary()
        }
        if footballLottery != nil{
            dictionary["lottery"] = footballLottery.toDictionary()
        }
        if id != nil{
            dictionary["id"] = id
        }
        if remark != nil{
            dictionary["remark"] = remark.toDictionary()
        }
        if season != nil{
            dictionary["season"] = season.toDictionary()
        }
        if isSelect != nil{
            dictionary["is_select"] = isSelect
        }
        if stage != nil{
            dictionary["stage"] = stage.toDictionary()
        }
        if startTime != nil{
            dictionary["start_time"] = startTime
        }
        if status != nil{
            dictionary["status"] = status
        }
        if teamA != nil{
            dictionary["teamA"] = teamA.toDictionary()
        }
        if teamB != nil{
            dictionary["teamB"] = teamB.toDictionary()
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
        eventInfo = aDecoder.decodeObject(forKey: "event_info") as? FootBallEventModel
        northSigle = aDecoder.decodeObject(forKey: "north_sigle") as? NorthSigleModel
        footballLottery = aDecoder.decodeObject(forKey: "lottery") as? FootBallLotteryModel
        id = aDecoder.decodeObject(forKey: "id") as? Int
        isSelect = aDecoder.decodeObject(forKey: "is_select") as? Bool
        remark = aDecoder.decodeObject(forKey: "remark") as? Remark
        season = aDecoder.decodeObject(forKey: "season") as? Season
        stage = aDecoder.decodeObject(forKey: "stage") as? Stage
        startTime = aDecoder.decodeObject(forKey: "start_time") as? Int
        status = aDecoder.decodeObject(forKey: "status") as? Int
        teamA = aDecoder.decodeObject(forKey: "teamA") as? Team
        teamB = aDecoder.decodeObject(forKey: "teamB") as? Team
        time = aDecoder.decodeObject(forKey: "time") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if eventInfo != nil{
            aCoder.encode(eventInfo, forKey: "event_info")
        }
        if footballLottery != nil{
            aCoder.encode(footballLottery, forKey: "lottery")
        }
        if isSelect != nil{
            aCoder.encode(isSelect, forKey: "is_select")
        }
        if northSigle != nil{
            aCoder.encode(northSigle, forKey: "north_sigle")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if remark != nil{
            aCoder.encode(remark, forKey: "remark")
        }
        if season != nil{
            aCoder.encode(season, forKey: "season")
        }
        if stage != nil{
            aCoder.encode(stage, forKey: "stage")
        }
        if startTime != nil{
            aCoder.encode(startTime, forKey: "start_time")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if teamA != nil{
            aCoder.encode(teamA, forKey: "teamA")
        }
        if teamB != nil{
            aCoder.encode(teamB, forKey: "teamB")
        }
        if time != nil{
            aCoder.encode(time, forKey: "time")
        }
        
    }
    
}
class Team : NSObject, NSCoding{
    
    var addTimeScore : Int!
    var id : Int!
    var cornerBall : Int!
    var halfYellow : Int!
    var halfRed : Int!
    var halfScore : Int!
    var pointScore : Int!
    var score : Int!
    var sort : String!
    var teamsInfo : StageInfo!
    var teamName : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        addTimeScore = dictionary["add_time_score"] as? Int
        cornerBall = dictionary["corner_ball"] as? Int
        halfYellow = dictionary["half_yellow"] as? Int
        halfRed = dictionary["half_red"] as? Int
        halfScore = dictionary["half_score"] as? Int
        pointScore = dictionary["point_score"] as? Int
        score = dictionary["score"] as? Int
        id = dictionary["id"] as? Int
        sort = dictionary["sort"] as? String
        teamName = dictionary["team_name"] as? String
        if let teamsInfoData = dictionary["teams_info"] as? [String:Any]{
            teamsInfo = StageInfo(fromDictionary: teamsInfoData)
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if addTimeScore != nil{
            dictionary["add_time_score"] = addTimeScore
        }
        if teamName != nil{
            dictionary["team_name"] = teamName
        }
        if cornerBall != nil{
            dictionary["corner_ball"] = cornerBall
        }
        if halfYellow != nil{
            dictionary["half_yellow"] = halfYellow
        }
        if halfRed != nil{
            dictionary["half_red"] = halfRed
        }
        if id != nil{
            dictionary["id"] = id
        }
        if halfScore != nil{
            dictionary["half_score"] = halfScore
        }
        if pointScore != nil{
            dictionary["point_score"] = pointScore
        }
        if score != nil{
            dictionary["score"] = score
        }
        if sort != nil{
            dictionary["sort"] = sort
        }
        if teamsInfo != nil{
            dictionary["teams_info"] = teamsInfo.toDictionary()
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        addTimeScore = aDecoder.decodeObject(forKey: "add_time_score") as? Int
        cornerBall = aDecoder.decodeObject(forKey: "corner_ball") as? Int
        halfYellow = aDecoder.decodeObject(forKey: "half_yellow") as? Int
        halfRed = aDecoder.decodeObject(forKey: "half_red") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? Int
        halfScore = aDecoder.decodeObject(forKey: "half_score") as? Int
        pointScore = aDecoder.decodeObject(forKey: "point_score") as? Int
        score = aDecoder.decodeObject(forKey: "score") as? Int
        sort = aDecoder.decodeObject(forKey: "sort") as? String
        teamName = aDecoder.decodeObject(forKey: "team_name") as? String
        teamsInfo = aDecoder.decodeObject(forKey: "teams_info") as? StageInfo
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if addTimeScore != nil{
            aCoder.encode(addTimeScore, forKey: "add_time_score")
        }
        if cornerBall != nil{
            aCoder.encode(cornerBall, forKey: "corner_ball")
        }
        if halfYellow != nil{
            aCoder.encode(halfYellow, forKey: "half_yellow")
        }
        if halfRed != nil{
            aCoder.encode(halfRed, forKey: "half_red")
        }
        if halfScore != nil{
            aCoder.encode(halfScore, forKey: "half_score")
        }
        if pointScore != nil{
            aCoder.encode(pointScore, forKey: "point_score")
        }
        if score != nil{
            aCoder.encode(score, forKey: "score")
        }
        if sort != nil{
            aCoder.encode(sort, forKey: "sort")
        }
        if teamName != nil{
            aCoder.encode(teamName, forKey: "team_name")
        }
        if teamsInfo != nil{
            aCoder.encode(teamsInfo, forKey: "teams_info")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        
    }
    
}

class Stage : NSObject, NSCoding{
    
    var numberColumn : Int!
    var numberRow : Int!
    var stageInfo : StageInfo!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        numberColumn = dictionary["number_column"] as? Int
        numberRow = dictionary["number_row"] as? Int
        if let stageInfoData = dictionary["stage_info"] as? [String:Any]{
            stageInfo = StageInfo(fromDictionary: stageInfoData)
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if numberColumn != nil{
            dictionary["number_column"] = numberColumn
        }
        if numberRow != nil{
            dictionary["number_row"] = numberRow
        }
        if stageInfo != nil{
            dictionary["stage_info"] = stageInfo.toDictionary()
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        numberColumn = aDecoder.decodeObject(forKey: "number_column") as? Int
        numberRow = aDecoder.decodeObject(forKey: "number_row") as? Int
        stageInfo = aDecoder.decodeObject(forKey: "stage_info") as? StageInfo
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if numberColumn != nil{
            aCoder.encode(numberColumn, forKey: "number_column")
        }
        if numberRow != nil{
            aCoder.encode(numberRow, forKey: "number_row")
        }
        if stageInfo != nil{
            aCoder.encode(stageInfo, forKey: "stage_info")
        }
        
    }
    
}

class StageInfo : NSObject, NSCoding{
    
    var groupCount : Int!
    var id : Int!
    var mode : Int!
    var nameEn : String!
    var nameZh : String!
    var nameZht : String!
    var roundCount : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        groupCount = dictionary["group_count"] as? Int
        id = dictionary["id"] as? Int
        mode = dictionary["mode"] as? Int
        nameEn = dictionary["name_en"] as? String
        nameZh = dictionary["name_zh"] as? String
        nameZht = dictionary["name_zht"] as? String
        roundCount = dictionary["round_count"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if groupCount != nil{
            dictionary["group_count"] = groupCount
        }
        if id != nil{
            dictionary["id"] = id
        }
        if mode != nil{
            dictionary["mode"] = mode
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
        if roundCount != nil{
            dictionary["round_count"] = roundCount
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        groupCount = aDecoder.decodeObject(forKey: "group_count") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? Int
        mode = aDecoder.decodeObject(forKey: "mode") as? Int
        nameEn = aDecoder.decodeObject(forKey: "name_en") as? String
        nameZh = aDecoder.decodeObject(forKey: "name_zh") as? String
        nameZht = aDecoder.decodeObject(forKey: "name_zht") as? String
        roundCount = aDecoder.decodeObject(forKey: "round_count") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if groupCount != nil{
            aCoder.encode(groupCount, forKey: "group_count")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if mode != nil{
            aCoder.encode(mode, forKey: "mode")
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
        if roundCount != nil{
            aCoder.encode(roundCount, forKey: "round_count")
        }
        
    }
    
}

class Season : NSObject, NSCoding{
    
    var id : Int!
    var year : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["id"] as? Int
        year = dictionary["year"] as? String
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
        if year != nil{
            dictionary["year"] = year
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
        year = aDecoder.decodeObject(forKey: "year") as? String
        
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
        if year != nil{
            aCoder.encode(year, forKey: "year")
        }
        
    }
    
}

class Remark : NSObject, NSCoding{
    
    var isCenter : Int!
    var numberRow : Int!
    var remarkDetail : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        isCenter = dictionary["is_center"] as? Int
        numberRow = dictionary["number_row"] as? Int
        remarkDetail = dictionary["remark_detail"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if isCenter != nil{
            dictionary["is_center"] = isCenter
        }
        if numberRow != nil{
            dictionary["number_row"] = numberRow
        }
        if remarkDetail != nil{
            dictionary["remak_detail"] = remarkDetail
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        isCenter = aDecoder.decodeObject(forKey: "is_center") as? Int
        numberRow = aDecoder.decodeObject(forKey: "number_row") as? Int
        remarkDetail = aDecoder.decodeObject(forKey: "remark_detail") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if isCenter != nil{
            aCoder.encode(isCenter, forKey: "is_center")
        }
        if numberRow != nil{
            aCoder.encode(numberRow, forKey: "number_row")
        }
        if remarkDetail != nil{
            aCoder.encode(remarkDetail, forKey: "remark_detail")
        }
        
    }
    
}
