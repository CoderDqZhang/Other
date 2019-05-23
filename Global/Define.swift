//
//  define.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/7.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import Foundation
import SwifterSwift
import YYText
import ReactiveCocoa

let SCREENWIDTH = UIScreen.main.bounds.size.width
let SCREENHEIGHT = UIScreen.main.bounds.size.height

let IPHONE_VERSION:Int = UIDevice.current.systemVersion.nsString.integerValue

let IPHONE_VERSION_LAST9 = IPHONE_VERSION >= 9 ? true:false
let IPHONE_VERSION_LAST10 = IPHONE_VERSION >= 10 ? true:false
let IPHONE_VERSION_LAST11 = IPHONE_VERSION >= 11 ? true:false
let IPHONE_VERSION_LAST12 = IPHONE_VERSION >= 12 ? true:false

let IPHONE4 = SCREENHEIGHT == 480 ? true:false
let IPHONE5 = SCREENHEIGHT == 568 ? true:false
let IPHONE6 = SCREENHEIGHT == 667 ? true:false
let IPHONE6P = SCREENWIDTH == 414 ? true:false
let IPHONE7P = SCREENHEIGHT == 736 ? true:false
let IPHONEXs = SCREENHEIGHT == 812.0 ? true : false
let IPHONEXR = SCREENHEIGHT == 896.0 ? true : false
let IPHONEXsMax = SCREENHEIGHT == 812.0 ? true : false

let SHARE_APPLICATION = UIApplication.shared

@available(iOS 11.0, *)
let INTERFACE_IS_IPHONEX = KWindow.safeAreaInsets.bottom > 0 ? true : false
@available(iOS 11.0, *)
let NAV_HEIGHT:CGFloat = INTERFACE_IS_IPHONEX ? 48 : 0
@available(iOS 11.0, *)
let TABBAR_HEIGHT:CGFloat = INTERFACE_IS_IPHONEX ? 24 : 0

let IPAD = UIDevice.current.userInterfaceIdiom == .pad ? true : false

let IPHONEWIDTH320 = SCREENWIDTH == 320 ? true:false
let IPHONEWIDTH375 = SCREENWIDTH == 375 ? true:false
let IPHONEWIDTH414 = SCREENWIDTH == 414 ? true:false

let IPHONEXFRAMEHEIGHT:CGFloat = IPHONEXs ? 24 : 0
let IPHONEXTABBARHEIGHT:CGFloat = IPHONEXs ? 30 : 0

let KWindow:UIWindow = UIApplication.shared.keyWindow!


func isIPhoneXSeries() -> Bool{
    var iPhoneXSeries:Bool = false
    if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
        return iPhoneXSeries
    }
    
    if  #available(iOS 11.0, *){
        if KWindow.safeAreaInsets.bottom > 0.0{
            iPhoneXSeries = true
        }
    }
    
    return iPhoneXSeries
}


let AnimationTime = 0.3

let TitleLineSpace:Float = 3.0




func AppCallViewShow(_ view:UIView, phone:String) {
    UIAlertController.showAlertControl(view.findViewController()!, style: .alert, title: "联系投球电话客服", message: phone, cancel: "取消", doneTitle: "确定", cancelAction: {
        
    }, doneAction: {
//        UIApplication.shared.open(URL.init(string: "tel:\(phone)")!, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler: { (ret) in
//            
//        })
    })
}


func NavigationPushView(_ formviewController:UIViewController, toConroller:UIViewController) {
    toConroller.hidesBottomBarWhenPushed = true
    formviewController.navigationController?.pushViewController(toConroller, animated: true)
}

func NavigaiontPresentView(_ formViewController:UIViewController, toController:UIViewController) {
    formViewController.present(toController, animated: true) {
        
    }
}

func MainThreadAlertShow(_ msg:String,view:UIView){
    DispatchQueue.main.async(execute: {
        _ = Tools.shareInstance.showMessage(view, msg: msg, autoHidder: true)
    })
}

func MainThreanShowErrorMessage(_ error:AnyObject){
    if error is NSDictionary {
        DispatchQueue.main.async(execute: {
            _ = Tools.shareInstance.showErrorMessage(error)
        })
    }
}

func MainThreanShowNetWorkError(_ error:AnyObject){
    DispatchQueue.main.async(execute: {
        _ = Tools.shareInstance.showNetWorkError(error)
    })
}



let AESKey = "agtoc*xPAj1h8^G9"


func AddAESKeyPassword(str:String)->String{
    return NSString.aes128Encrypt(str, key:AESKey)
}

let UMengKey = "5ce3c7b5570df31299000416"

let OSS_ACCESSKEY_ID: String = "LTAIFreEhG934EtV"
let OSS_SECRETKEY_ID: String = "fDma5kP0VpOqrEz15OPJA2xnXjIRIq"
let OSS_BUCKET_PUBLIC: String = "tq-baodian"
let OSS_BUCKET_PRIVATE: String = "tq-baodian"
let OSS_ENDPOINT: String = "oss-cn-hangzhou.aliyuncs.com"
let OSS_MULTIPART_UPLOADKEY: String = "multipart"
let OSS_RESUMABLE_UPLOADKEY: String = "resumable"
let OSS_CALLBACK_URL: String = "http://oss-demo.aliyuncs.com:23450"
let OSS_CNAME_URL: String = "http://www.cnametest.com/"
let OSS_STSTOKEN_URL: String = "http://*.*.*.*.****/sts/getsts"

