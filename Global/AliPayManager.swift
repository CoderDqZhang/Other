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
import MBProgressHUD

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
        var loading:MBProgressHUD!
        DispatchQueue.main.async {
            loading = Tools.shareInstance.showLoading(KWindow, msg: "图片上传")
        }
        var resultStrs:[String] = []
        var resultString = ""
        let count = MutableProperty<Int>(0)
        DispatchQueue.global().async {
            for index in 0...images.count - 1 {
                AliPayManager.getSharedInstance().uploadFileImage(images: images[index] as! UIImage, type: type) { (str, _, success)  in
                    count.value = count.value + 1
                    resultStrs.append(str[0])
                    resultString = "\(resultString)\(str[0]),"
                    if count.value == images.count {
                        DispatchQueue.main.async {
                            loading.hide(animated: true)
                            _ = Tools.shareInstance.showMessage(KWindow, msg: "上传成功", autoHidder: true)
                        }
                        result(resultStrs,resultString,success)
                    }
                }
            }
        }
    }
    
    func uploadFileImage(images:UIImage,type:AliPayManagerType, result:@escaping AliPayManagerSuccess){

        let put = OSSPutObjectRequest.init()
        put.bucketName = OSS_BUCKET_PUBLIC
        let date = Date.init()
        let phone:String = (CacheManager.getSharedInstance().getUserInfo()?.id.string)!
        let imageKey = "\(Date().string(withFormat: "yyyy/MM/dd"))/\(phone)_\(date.nanosecond)_i_w\(Int(images.size.width))_h\(Int(images.size.height)).png"


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

        AliPayManager.getSharedInstance().client.putObject(put).continue(successBlock: { (task) -> Any? in
            if (task ).error == nil {
                switch type{
                case .post:
                    result(["/post/\(imageKey)"],"",true)
                default:
                    result(["/user/\(imageKey)"],"",true)
                }
                print("upload object success")
            }else{
                result(["/user/\(imageKey)"],"",false)
                print("upload object fail:\((task).error ?? "" as! Error)")
            }
            return nil
        }, cancellationToken: nil)
    }
}
