//
//  AliPayManager.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/23.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
enum AliPayManagerType {
    case user
    case post
    case comment
}

typealias AliPayManagerSuccess = (_ images:[String]) ->Void

class AliPayManager: NSObject {

    var client:OSSClient!
    
    private static let _sharedInstance = AliPayManager()
    
    class func getSharedInstance() -> AliPayManager {
        return _sharedInstance
    }
    
    private override init() {} // 私有化init方法
    
    func ossSetUp()->Void {
        let credential = OSSCustomSignerCredentialProvider.init { (sign, error) -> String? in
            let signature = OSSUtil.calBase64Sha1(withData: sign, withSecret: OSS_SECRETKEY_ID)
            if signature != nil {
                return "OSS \(OSS_ACCESSKEY_ID):\(signature!)"
            }else{
                return "出现错误"
            }
        }
        client = OSSClient.init(endpoint: OSS_ENDPOINT, credentialProvider: credential!)
    }
    
    func uploadFile(images:[UIImage],type:AliPayManagerType, result:@escaping AliPayManagerSuccess){
        let put = OSSPutObjectRequest.init()
        put.bucketName = OSS_BUCKET_PUBLIC
        var resultStrs:[String] = []
        var count = 0
        for index in 0...images.count - 1 {
            let date = Date.init()
            let phone:String = (CacheManager.getSharedInstance().getUserInfo()?.id.string)!
            let imageKey = "\(date.year)/\(date.month)/\(date.day)/\(phone)_\(date.nanosecond)"
            switch type{
            case .post:
                put.objectKey = "post/\(imageKey).png"
            default:
                put.objectKey = "user/\(imageKey).png"
            }
            
            put.uploadingData = images[index].compressedData(quality: 0.75)!
            put.uploadProgress = { (bytesent, totalbytesent,ttalbytesexpected) in
                print("bytesent:\(bytesent)")
                print("totalbytesent:\(totalbytesent)")
                print("ttalbytesexpected:\(ttalbytesexpected)")
            }
            
            AliPayManager.getSharedInstance().client.putObject(put).continue({ (task) -> Any? in
                count = count + 1
                if (task ).error == nil {
                    resultStrs.append(imageKey)
                    print("upload object success")
                }else{
                    print("upload object fail:\((task).error ?? "" as! Error)")
                }
                if count == images.count {
                    result(resultStrs)
                }
                return nil
            }, cancellationToken: nil)
        }
        
        
    }
}
