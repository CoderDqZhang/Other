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

typealias AliPayManagerSuccess = (_ images:[String],_ strs:String, _ success:Bool) ->Void

class AliPayManager: NSObject {

    var client:OSSClient!
    
    private static let _sharedInstance = AliPayManager()
    
    class func getSharedInstance() -> AliPayManager {
        return _sharedInstance
    }
    
    private override init() {} // 私有化init方法
    
    func ossSetUp()->Void {
//        let credential = OSSPlainTextAKSKPairCredentialProvider.init(plainTextAccessKey: OSS_ACCESSKEY_ID, secretKey: OSS_SECRETKEY_ID)
            
            
        let credential = OSSCustomSignerCredentialProvider.init { (sign, error) -> String? in
            let signature = OSSUtil.calBase64Sha1(withData: sign, withSecret: OSS_SECRETKEY_ID)
            if signature != nil {
                let str = "OSS \(OSS_ACCESSKEY_ID):\(signature!)"
                return str

            }else{
                return "出现错误"
            }
        }
        
        
        client = OSSClient.init(endpoint: OSS_ENDPOINT, credentialProvider: credential!)
    }
    
    func uploadFile(images:NSMutableArray,type:AliPayManagerType, result:@escaping AliPayManagerSuccess){
            
        var resultStrs:[String] = []
        var resultString = ""
        let count = MutableProperty<Int>(0)

        for index in 0...images.count - 1 {
            AliPayManager.getSharedInstance().uploadFileImage(images: images[index] as! UIImage, type: type) { (str, _, success)  in
                count.value = count.value + 1
                resultStrs.append(str[0])
                resultString = "\(resultString)\(str[0]),"
                if count.value == images.count {
                    result(resultStrs,resultString,success)
                }
            }
        }
    }
    
    func uploadFileImage(images:UIImage,type:AliPayManagerType, result:@escaping AliPayManagerSuccess){

        let put = OSSPutObjectRequest.init()
        put.bucketName = OSS_BUCKET_PUBLIC
        let date = Date.init()
        let phone:String = (CacheManager.getSharedInstance().getUserInfo()?.id.string)!
        let imageKey = "\(Date().string(withFormat: "yyyy/MM/dd"))/\(phone)_\(date.nanosecond)_w\(Int(images.size.width))_h\(Int(images.size.height))_i.png"


        switch type{
        case .post:
            put.objectKey = "post/\(imageKey)"
        default:
            put.objectKey = "user/\(imageKey)"
        }
        put.uploadingData = images.compressedData(quality: 0.75)!
        put.uploadProgress = { (bytesent, totalbytesent,ttalbytesexpected) in
            print("bytesent:\(bytesent)")
            print("totalbytesent:\(totalbytesent)")
            print("ttalbytesexpected:\(ttalbytesexpected)")
        }

        let credential = OSSCustomSignerCredentialProvider.init { (sign, error) -> String? in
            let signature = OSSUtil.calBase64Sha1(withData: sign, withSecret: OSS_SECRETKEY_ID)
            if signature != nil {
                let str = "OSS \(OSS_ACCESSKEY_ID):\(signature!)"
                return str

            }else{
                return "出现错误"
            }
        }
        
        
        let client = OSSClient.init(endpoint: OSS_ENDPOINT, credentialProvider: credential!)
        
        let putTask = client.putObject(put)
        putTask.continue(successBlock: { (task) -> Any? in
            if (task ).error == nil {
                switch type{
                case .post:
                    result(["/post/\(imageKey)"],"",true)
                default:
                    result(["/user/\(imageKey)"],"",true)
                }
                putTask.waitUntilFinished()
                print("upload object success")
            }else{
                result(["/user/\(imageKey)"],"",false)
                print("upload object fail:\((task).error ?? "" as! Error)")
            }
            return nil
        }, cancellationToken: nil)
    }
}
