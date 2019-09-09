//
//  FootBallEventModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class FootBallEventModel : NSObject, NSCoding{
    
    var areaId : Int!
    var countryId : Int!
    var id : Int!
    var level : Int!
    var logo : String!
    var nameEn : String!
    var nameZh : String!
    var nameZht : String!
    var shortNameEn : String!
    var shortNameZh : String!
    var shortNameZht : String!
    var type : Int!
    var isSelect : Bool!
    var titleName : String!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        areaId = dictionary["area_id"] as? Int
        countryId = dictionary["country_id"] as? Int
        id = dictionary["id"] as? Int
        level = dictionary["level"] as? Int
        logo = dictionary["logo"] as? String
        nameEn = dictionary["name_en"] as? String
        nameZh = dictionary["name_zh"] as? String
        nameZht = dictionary["name_zht"] as? String
        shortNameEn = dictionary["short_name_en"] as? String
        shortNameZh = dictionary["short_name_zh"] as? String
        shortNameZht = dictionary["short_name_zht"] as? String
        type = dictionary["type"] as? Int
        isSelect = dictionary["is_select"] as? Bool
        titleName = dictionary["title_name"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if areaId != nil{
            dictionary["area_id"] = areaId
        }
        if countryId != nil{
            dictionary["country_id"] = countryId
        }
        if id != nil{
            dictionary["id"] = id
        }
        if level != nil{
            dictionary["level"] = level
        }
        if isSelect != nil{
            dictionary["is_select"] = isSelect
        }
        if titleName != nil{
            dictionary["title_name"] = titleName
        }
        if logo != nil{
            dictionary["logo"] = logo
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
        if shortNameEn != nil{
            dictionary["short_name_en"] = shortNameEn
        }
        if shortNameZh != nil{
            dictionary["short_name_zh"] = shortNameZh
        }
        if shortNameZht != nil{
            dictionary["short_name_zht"] = shortNameZht
        }
        if type != nil{
            dictionary["type"] = type
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        areaId = aDecoder.decodeObject(forKey: "area_id") as? Int
        countryId = aDecoder.decodeObject(forKey: "country_id") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? Int
        isSelect = aDecoder.decodeObject(forKey: "is_select") as? Bool
        level = aDecoder.decodeObject(forKey: "level") as? Int
        logo = aDecoder.decodeObject(forKey: "logo") as? String
        nameEn = aDecoder.decodeObject(forKey: "name_en") as? String
        nameZh = aDecoder.decodeObject(forKey: "name_zh") as? String
        nameZht = aDecoder.decodeObject(forKey: "name_zht") as? String
        shortNameEn = aDecoder.decodeObject(forKey: "short_name_en") as? String
        shortNameZh = aDecoder.decodeObject(forKey: "short_name_zh") as? String
        shortNameZht = aDecoder.decodeObject(forKey: "short_name_zht") as? String
        type = aDecoder.decodeObject(forKey: "type") as? Int
        titleName = aDecoder.decodeObject(forKey: "title_name") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if areaId != nil{
            aCoder.encode(areaId, forKey: "area_id")
        }
        if countryId != nil{
            aCoder.encode(countryId, forKey: "country_id")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if level != nil{
            aCoder.encode(level, forKey: "level")
        }
        if logo != nil{
            aCoder.encode(logo, forKey: "logo")
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
        if shortNameEn != nil{
            aCoder.encode(shortNameEn, forKey: "short_name_en")
        }
        if isSelect != nil{
            aCoder.encode(isSelect, forKey: "is_select")
        }
        if shortNameZh != nil{
            aCoder.encode(shortNameZh, forKey: "short_name_zh")
        }
        if shortNameZht != nil{
            aCoder.encode(shortNameZht, forKey: "short_name_zht")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if titleName != nil{
            aCoder.encode(titleName, forKey: "title_name")
        }
        
    }
    
}
