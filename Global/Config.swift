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

let JPushKey = "d64257d3a941be47886fcdd6"

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
let OSS_CALLBACK_URL: String = "https://oss-demo.aliyuncs.com:23450"
let OSS_CNAME_URL: String = "https://www.cnametest.com/"
let OSS_STSTOKEN_URL: String = "https://*.*.*.*.****/sts/getsts"


let CACHEMANAGERCATEGORYMODELS = "CategoryModels"
let CACHEMANAPSOTMODEL = "PostModel"
let CACHEMANAUSERINFO = "userInfo"
let CACHEMANAUSERTOKEN = "UserToken"
let CACHEMANACONFIGMODEL = "ConfigModel"
let CACHEMANAUNREADMESSAGEMODEL = "UnreadMessageModel"
let ADMODEL = "ADModel"
let APPACTIVEMODEL = "APPActiveModel"
let CACHEMANAPointModel = "PointModel"
let PLACHOLDERIMAGE = "PlacholderImage"
//助球队信息
let FOOTBALLINFOMODEL = "FootBallInfoModel" //保存足球队信息 已移除
let FOOTBALLEVENTODEL = "FootBallEventModel" //保存足球赛事信息
let FOOTBALLEVENTSELECTMODEL = "FootBallEventSelectModel" //保存足球筛选中赛事数据
let FOOTBALLEVENTLEVELMODEL = "FootBallEventLevelModel" //保存足球一级赛事信息
let FOOTBALLNORTHSIGLEMODEL = "FootBallNorthSigle" //保存北单数据
let FOOTBALLLOTTERYMODEL = "FootBallLottery" //保存足彩数据
let FOOTBALLINDEXMODEL = "FootBallIndex" //保存竞彩数据
let FOOTBALLMATCHCOLLECTMODEL = "FootBallMatchCollectModel" //保存竞彩数据
let RELOADFOOTBALLEVENTDATA = "ReloadFootEventData" ///更新足球赛事信息
let CLICKRELOADFOOTBALLEVENTDATA = "ClickReloadFootEventData" //点击更新其他j界面的赛事选择
let ALLFOOTBALLMACTH = "AllFootBallMacth" //所有赛程数
let RELOADFILTERFOOTBALLMODEL = "ReloadFilterFootModel" //更新列表页模型数据通知
let RELOADCOLLECTFOOTBALLMODEL = "ReloadCollectFootModel" //更新列表页模型数据通知
let RELOADCOLLECTFOOTBALLTYPEMODEL = "ReloadCollectFootTypeModel" //更新列表页模型数据通知
let UPDATEFOOTBALLSELECTEVENT = "UpdateFootBallSelectEvent" //更新列表页模型数据通知
let RELOADFOOTBALLENTERACTIVE = "ReloadFootBallEnterActive" //进入后台后重新加载模型数据
let RELOADFOOTBALLMATCHEVENT = "ReloadFootBallMatchEvent" //增加赛事更新数据

//助球队信息
let BASKETBALLINFOMODEL = "BasketBallInfoModel" //保存足球队信息 已移除
let BASKETBALLEVENTODEL = "BasketBallEventModel" //保存足球赛事信息
let BASKETBALLEVENTSELECTMODEL = "BasketBallEventSelectModel" //保存足球筛选中赛事数据
let BASKETBALLEVENTLEVELMODEL = "BasketBallEventLevelModel" //保存足球一级赛事信息
let BASKETBALLINDEXMODEL = "BasketBallIndex" //保存竞彩数据
let BASKETBALLMATCHCOLLECTMODEL = "BasketBallMatchCollectModel" //保存竞彩数据
let RELOADBASKETBALLEVENTDATA = "ReloadBaketBallEventData" ///更新足球赛事信息
let RELOADBASKETBALLMATCHEVENT = "ReloadBasketBallMatchEvent" //增加赛事更新数据


let CLICKRELOADBASKETBALLEVENTDATA = "ClickReloadBasketBallEventData"
let CLICKRELOADBASKETBALLEVENTYPETDATA = "ClickReloadBasketBallEventTypeData"//点击更新其他j界面的赛事选择
let ALLBASKETBALLMACTH = "AllBasketBallMacth" //所有赛程数
let RELOADFILTERBASKETBALLMODEL = "ReloadFilterBasketBallModel" //更新列表页模型数据通知
let RELOADCOLLECTRBASKETBALLMODEL = "ReloadCollectBasketBallModel" //更新列表页模型数据通知
let UPDATEBASKETBALLSELECTEVENT = "UpdateBasketBallSelectEvent" //更新列表页模型数据通知
let RELOADBASKETBALLENTERACTIVE = "ReloadBasketBallEnterActive" //进入后台后重新加载模型数据

let JPUSHALIAS = "touqiu_"
let NOTIFICATIOINSPUSHCONTROLLER = "NOTIFICATIOINSPUSHCONTROLLER"

//QQ开发平台
let QQAPPID  = "1109440727"
let QQAPPKEY = "SOmsWVgiESswZOpw"

//微博
let WeiboAPPKEY = "2894873924"
let WeiboAppSecret = "bb759bcc23ee0c68f2e1e0470514f0f9"
let WeiboRedirectUrl = "http://sns.whalecloud.com/sina2/callback"


let WeiXinAppID = "wxc12aa2683cd59692"
let WeiXinAppSecret = "7de854c8c6a50165fe7f46cc4060b00e"

let BuglyAppId = "7e5fac7a69"
let BuglyScrec = "8e80f3ea-a553-438d-8d3a-3141ca81b896"

func getNoLoginUserModel()->UserInfoModel{
    let userInfo = UserInfoModel.init(fromDictionary: ["id": 8,
                                                       "img": "/user/default.png",
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




