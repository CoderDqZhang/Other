//
//  Config.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/30.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import Foundation
import SKPhotoBrowser

let AESKey = "agtoc*xPAj1h8^G9"


let LIMITNUMBER:String = "10"

let LOCALBANKNAME = "BankName.json"

let JPushKey = "3434b0b27289c88f8053e4fd"

let UMengKey = "5ce3c7b5570df31299000416"

let OSS_ACCESSKEY_ID: String = "LTAIFreEhG934EtV"
let OSS_SECRETKEY_ID: String = "fDma5kP0VpOqrEz15OPJA2xnXjIRIq"
let OSS_BUCKET_PUBLIC: String = "tq-baodian"
let OSS_BUCKET_PRIVATE: String = "tq-baodian"
//let OSS_BUCKET_PUBLIC: String = "tq-baodian-prd"
//let OSS_BUCKET_PRIVATE: String = "tq-baodian-prd"
let OSS_ENDPOINT: String = "oss-cn-hangzhou.aliyuncs.com"
let OSS_MULTIPART_UPLOADKEY: String = "multipart"
let OSS_RESUMABLE_UPLOADKEY: String = "resumable"
let OSS_CALLBACK_URL: String = "http://oss-demo.aliyuncs.com:23450"
let OSS_CNAME_URL: String = "http://www.cnametest.com/"
let OSS_STSTOKEN_URL: String = "http://*.*.*.*.****/sts/getsts"


let CACHEMANAGERCATEGORYMODELS = "CategoryModels"
let CACHEMANAPSOTMODEL = "PostModel"
let CACHEMANAUSERINFO = "userInfo"
let CACHEMANAUSERTOKEN = "UserToken"
let CACHEMANACONFIGMODEL = "ConfigModel"
let CACHEMANAUNREADMESSAGEMODEL = "UnreadMessageModel"
let ADMODEL = "ADModel"
let APPACTIVEMODEL = "APPActiveModel"
let CACHEMANAPointModel = "PointModel"

let JPUSHALIAS = "touqiu_"
let NOTIFICATIOINSPUSHCONTROLLER = "NOTIFICATIOINSPUSHCONTROLLER"

let holderImage = UIImage.init(named: "")


//QQ开发平台
let QQAPPID  = "1109440727"
let QQAPPKEY = "SOmsWVgiESswZOpw"

//微博
let WeiboAPPKEY = "2894873924"
let WeiboAppSecret = "bb759bcc23ee0c68f2e1e0470514f0f9"
let WeiboRedirectUrl = "http://sns.whalecloud.com/sina2/callback"


let WeiXinAppID = "wxde874e2be98bd508"


func getNoLoginUserModel()->UserInfoModel{
    let userInfo = UserInfoModel.init(fromDictionary: ["id": 8,
                                                       "img": "/user/2019/5/27/8_716837048.png",
                                                       "nickname": "请先登录",
                                                       "description": "还未登录",
                                                       "phone": "",
                                                       "sex": "0",
                                                       "openId": "",
                                                       "qqId": "",
                                                       "wbId": "",
                                                       "email": "",
                                                       "lastLoginTime": "",
                                                       "username": "",
                                                       "signIn": 4,
                                                       "idNumber": "",
                                                       "isMember": "",
                                                       "isMaster": "0",
                                                       "isFollow": 0,
                                                       "followNum": 0,
                                                       "fansNum": 0])
    return userInfo
}

func getNologinAccountModel() ->AccountInfoModel {
    let accountModel = AccountInfoModel.init(fromDictionary: [
        "userId": 8,
        "inviteCode": "ZO4AC5",
        "inviteNo": 0,
        "inviteCoin": 0.00,
        "integral": 0.00,
        "chargeCoin": 0.00,
        "recomCoin": 0.00
        ])
    return accountModel
}




