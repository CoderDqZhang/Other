//
//  TransModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/25.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class TransModel : NSObject, NSCoding{
    
    var backend : Int!
    var orig : String!
    var trans : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        backend = dictionary["backend"] as? Int
        orig = dictionary["orig"] as? String
        trans = dictionary["trans"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if backend != nil{
            dictionary["backend"] = backend
        }
        if orig != nil{
            dictionary["orig"] = orig
        }
        if trans != nil{
            dictionary["trans"] = trans
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        backend = aDecoder.decodeObject(forKey: "backend") as? Int
        orig = aDecoder.decodeObject(forKey: "orig") as? String
        trans = aDecoder.decodeObject(forKey: "trans") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if backend != nil{
            aCoder.encode(backend, forKey: "backend")
        }
        if orig != nil{
            aCoder.encode(orig, forKey: "orig")
        }
        if trans != nil{
            aCoder.encode(trans, forKey: "trans")
        }
        
    }
    
}
