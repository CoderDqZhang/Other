//
//  BaseNetWorke.swift
//  LiangPiao
//
//  Created by Zhang on 28/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import Alamofire
import ReactiveSwift
import MBProgressHUD

typealias SuccessClouse = (_ responseObject:AnyObject) -> Void
typealias FailureClouse = (_ responseError:AnyObject) -> Void

enum HttpRequestType {
    case post
    case get
    case delete
    case put
}

class BaseNetWorke {
    fileprivate init() {
    
    }
    
    static let sharedInstance = BaseNetWorke()
    //加一个特使标识，首页请求失败
    /// getRequest
    /// - parameter url:        输入URL
    /// - parameter parameters: 参数
    ///
    /// - returns: 一个信号

    func getUrlWithString(_ url:String, parameters:AnyObject?) -> Signal<Any, NSError> {
        return Signal.init({ (subscriber, liftTime) in
            self.httpRequest(.get, url: url, parameters: parameters, success: { (responseObject) in
                if (responseObject as! NSDictionary).object(forKey: "code")! as! Int == 10000 {
                    subscriber.send(value: (responseObject as! NSDictionary).object(forKey: "data") ?? "")
                }else if (responseObject as! NSDictionary).object(forKey: "code")! as! Int == 3006  {
                    subscriber.send(error: NSError.init())
                }else{
                     _ = Tools.shareInstance.showMessage(KWindow, msg: (responseObject as! NSDictionary).object(forKey: "message") as! String, autoHidder: true)
                }
                subscriber.sendCompleted()
            }, failure: { (responseError) in
                if responseError is NSDictionary {
                    MainThreanShowErrorMessage(responseError)
                }else{
                    MainThreanShowNetWorkError(responseError)
                    subscriber.sendCompleted()
                }
                subscriber.sendCompleted()
            })
        })
    }
    /// postRequest
    /// - parameter url:        输入URL
    /// - parameter parameters: 参数
    ///
    /// - returns: 一个信号
    func postUrlWithString(_ url:String, parameters:AnyObject?) -> Signal<Any, NSError> {
        return Signal.init({ (subscriber, liftTime) in
            self.httpRequest(.post, url: url, parameters: parameters, success: { (responseObject) in
                if (responseObject as! NSDictionary).object(forKey: "code")! as! Int == 10000 {
                    subscriber.send(value: (responseObject as! NSDictionary).object(forKey: "data") ?? "")
                }else{
                    _ = Tools.shareInstance.showMessage(KWindow, msg: (responseObject as! NSDictionary).object(forKey: "message") as! String, autoHidder: true)
                }
                subscriber.sendCompleted()
                }, failure: { (responseError) in
                    if responseError is NSDictionary {
                        MainThreanShowErrorMessage(responseError)
                    }else{
                        print(responseError)
                        MainThreanShowNetWorkError(responseError)
//                        subscriber.send(error: responseError as! NSError)
                    }
                subscriber.sendCompleted()
            })
        })
        
    }
    
    /// Putrequest
    /// - parameter url:        输入URL
    /// - parameter parameters: 参数
    ///
    /// - returns: 一个信号
    func putUrlWithString(_ url:String, parameters:AnyObject?) -> Signal<Any, NSError> {
        return Signal.init({ (subscriber, liftTime) in
            self.httpRequest(.put, url: url, parameters: parameters, success: { (responseObject) in
                if (responseObject as! NSDictionary).object(forKey: "code")! as! Int == 10000 {
                    subscriber.send(value: (responseObject as! NSDictionary).object(forKey: "data") ?? "")
                }else{
                    _ = Tools.shareInstance.showMessage(KWindow, msg: (responseObject as! NSDictionary).object(forKey: "message") as! String, autoHidder: true)
                }
                subscriber.sendCompleted()
                }, failure: { (responseError) in
                    if responseError is NSDictionary {
                        MainThreanShowErrorMessage(responseError)
                    }else{
                        MainThreanShowNetWorkError(responseError)
                    }
                subscriber.sendCompleted()
            })
        })
    }
    
    /// 删除request
    ///
    /// - parameter url:        输入URL
    /// - parameter parameters: 参数
    ///
    /// - returns: 一个信号
    func deleteUrlWithString(_ url:String, parameters:AnyObject?) -> Signal<Any, NSError> {
        return Signal.init({ (subscriber, liftTime) in
            self.httpRequest(.delete, url: url, parameters: parameters, success: { (responseObject) in
                if (responseObject as! NSDictionary).object(forKey: "code")! as! Int == 10000 {
                    subscriber.send(value: (responseObject as! NSDictionary).object(forKey: "data") ?? "")
                }else{
                    _ = Tools.shareInstance.showMessage(KWindow, msg: (responseObject as! NSDictionary).object(forKey: "message") as! String, autoHidder: true)
                }
                subscriber.sendCompleted()
                }, failure: { (responseError) in
                    if responseError is NSDictionary {
                        MainThreanShowErrorMessage(responseError)
                    }else{
                        MainThreanShowNetWorkError(responseError)
                    }
                subscriber.sendCompleted()
            })
        })
    }
    
    
    func uploadDataFile(_ url:String, parameters:NSDictionary?, images:NSDictionary?, hud:MBProgressHUD?) ->Signal<Any, NSError> {
        return Signal.init({ (subscriber, liftTime) in
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                if parameters != nil {
                    for i in 0...(parameters!).allValues.count - 1 {
                        multipartFormData.append((parameters!.allValues[i] as! String).data(using: String.Encoding.utf8, allowLossyConversion: true)!, withName: parameters!.allKeys[i] as! String)
                    }
                }
                
                if images != nil {
                    for j in 0...(images!).allValues.count - 1 {
                        multipartFormData.append(URL.init(fileURLWithPath: images?.allValues[j] as! String), withName: "file")
                    }
                }
                
            }, usingThreshold: 1, to: url, method: .post, headers: [
                "content-type": "multipart/form-data",
                "cache-control": "no-cache"
            ]) { (encodingResult) in
                print(encodingResult)
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseString(completionHandler: { (response) in
                        if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                            subscriber.send(value: response.result.value ?? "")
                        }else{
                            _ = Tools.shareInstance.showMessage(KWindow, msg: "上传失败", autoHidder: true)
                        }
                        if hud != nil {
                            Tools.shareInstance.hiddenLoading(hud: hud!)
                        }
                        subscriber.sendCompleted()
                    })
                case .failure(let encodingError):
                    print(encodingError)
                    if hud != nil {
                        Tools.shareInstance.hiddenLoading(hud: hud!)
                    }
                    _ = Tools.shareInstance.showMessage(KWindow, msg: "上传失败", autoHidder: true)
                    subscriber.sendCompleted()
                }
            }
        })
    }
    
    ///
    /// - parameter url:        输入URL
    /// - parameter parameters: 参数
    ///
    /// - returns: 一个信号
    func httpRequest(_ type:HttpRequestType,url:String, parameters:AnyObject?, success:@escaping SuccessClouse, failure:@escaping FailureClouse) {
        
        var methods:HTTPMethod
        switch type {
            case .post:
                methods = HTTPMethod.post
            case .get:
                methods = HTTPMethod.get
            case .delete:
                methods = HTTPMethod.delete
            default:
                methods = HTTPMethod.put
        }
        let headers:HTTPHeaders? = ["sign":"touqiutest"]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let tempDic = NSMutableDictionary.init(dictionary: (parameters as? [String: Any])!)
        if CacheManager.getSharedInstance().isLogin() {
            tempDic.addEntries(from: ["token":CacheManager.getSharedInstance().getUserInfo()?.token ?? ""])
        }
        Alamofire.request(url, method: methods , parameters: tempDic as? [String: Any], encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if response.result.error != nil{
                failure(response.result.error! as AnyObject)
            }else{
                if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                    print((response.value as! NSDictionary))
                    if (response.value as! NSDictionary).object(forKey: "code") as! Int == 10000 {
                        success(response.value as! NSDictionary)
                    }else{
                        failure(["message":(response.value as! NSDictionary).object(forKey: "msg") as! String] as AnyObject)
                    }
                }else{
                    failure(response.result.value! as AnyObject)
                }
            }
        }
    }
    
    func jsonStringToDic(_ dictionary_temp:String) ->NSDictionary {
        let data = dictionary_temp.data(using: String.Encoding.utf8)! as NSData
        let dictionary_temp_temp = try? JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
        return dictionary_temp_temp as! NSDictionary
        
    }
}
