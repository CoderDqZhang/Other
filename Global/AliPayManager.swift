//
//  AliPayManager.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/23.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

enum AliPayManagerType {
    case user
    case post
    case comment
}

typealias AliPayManagerSuccess = (_ images:[String],_ strs:String) ->Void

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
        var resultString = ""
        let count = MutableProperty<Int>(0)
        
        for index in 0...images.count - 1 {
            AliPayManager.getSharedInstance().uploadFileImage(images: images[index], type: type) { (str, _)  in
                count.value = count.value + 1
                resultStrs.append(str[0])
                resultString = "\(resultString)\(str[0]),"
                if count.value == images.count {
                    result(resultStrs,resultString)
                }
            }
        }
    }
    
    func uploadFileImage(images:UIImage,type:AliPayManagerType, result:@escaping AliPayManagerSuccess){
        let put = OSSPutObjectRequest.init()
        put.bucketName = OSS_BUCKET_PUBLIC
        var resultStrs:[String] = []
        
        let count = MutableProperty<Int>(0)
        
        
        let date = Date.init()
        let phone:String = (CacheManager.getSharedInstance().getUserInfo()?.id.string)!
        let imageKey = "\(date.year)/\(date.month)/\(date.day)/\(phone)_\(date.nanosecond).png"
        switch type{
        case .post:
            put.objectKey = "/post/\(imageKey)"
        default:
            put.objectKey = "/user/\(imageKey)"
        }
        
        put.uploadingData = images.compressedData(quality: 0.75)!
        put.uploadProgress = { (bytesent, totalbytesent,ttalbytesexpected) in
            print("bytesent:\(bytesent)")
            print("totalbytesent:\(totalbytesent)")
            print("ttalbytesexpected:\(ttalbytesexpected)")
        }
        
        AliPayManager.getSharedInstance().client.putObject(put).continue({ (task) -> Any? in
            count.value = count.value + 1
            if (task ).error == nil {
                switch type{
                case .post:
                    resultStrs.append("/post/\(imageKey)")
                default:
                    resultStrs.append("/user/\(imageKey)")
                }
                print("upload object success")
            }else{
                print("upload object fail:\((task).error ?? "" as! Error)")
            }
            result(resultStrs,"")
            return nil
        }, cancellationToken: nil)
    }
    
    
}
