//
//  RequestURL.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/7.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import Foundation
//http://192.168.0.172:4141/swagger-ui.html

//ZKFgTvUb5BXiuD7KK2iuFiOUintS6mLgFi+ukIPiol801JlCola+lkGcFGN886nd
//ZKFgTvUb5BXiuD7KK2iuFtphhrg2uQu1kTJ0q4cnRothrdDXMpq+CNSo2UaDlDuI
let RootIPAddress:String = "192.168.3.4"
//let RootIPAddress:String = "192.168.0.172"
let SocketPort:Int = 4162
let RootUrl = "http://\(RootIPAddress):10020/social/"

let UserforgetPasswordUrl = "\(RootUrl)user/forgetPassword"
let UserBindPhoneUrl = "\(RootUrl)user/bindPhone"
let UserLoginUrl = "\(RootUrl)user/login"
let UserLoginThirdPartyUrl = "\(RootUrl)user/thirdPartyLogin"
let UserLoginBindPhoneUrl = "\(RootUrl)user/bindPhone"
let UserlogoutUrl = "\(RootUrl)user/logout"
let UserregisterUrl = "\(RootUrl)user/register"
let UsersendCodeUrl = "\(RootUrl)user/sendCode"
let SurePasswordUrl = "\(RootUrl)user/updatePassword"
let UserInfoUrl = "\(RootUrl)user/getUserInfo"
let StoreGoodsListUrl = "\(RootUrl)goods/getGoodsList"

let AccountbindAccountUrl = "\(RootUrl)account/addAccount"
let AccountcashUrl = "\(RootUrl)account/addCashRecord"
let AccountcoinDetailUrl = "\(RootUrl)account/getCoinDetail"
let AccountfindAccountUrl = "\(RootUrl)account/getAccount"
let AccountfindInviteUrl = "\(RootUrl)account/getInvite"
let AccountfindPasswordUrl = "\(RootUrl)account/getPassword"
let AccountgetPointCountUrl = "\(RootUrl)account/getPointCount"
let AccountpointDetailUrl = "\(RootUrl)account/getPointDetail"
let AccountUsersurePasswordUrl = "\(RootUrl)account/updatePassword"
let AccountFindCashAccountUrl = "\(RootUrl)account/getCashAccount"
let AccountDeleteAccountUrl = "\(RootUrl)account/delCashAccount"

let CommentcommentUrl = "\(RootUrl)comment/addComment"
let CommentcommentApprovetUrl = "\(RootUrl)comment/addApproveComment"
let CommentcommentDetailUrl = "\(RootUrl)comment/addCommentDetail"
let CommentcommentListUrl = "\(RootUrl)comment/getCommentList"
let CommentcommentDelUrl = "\(RootUrl)comment/delComment"
let ReplyreplyUrl = "\(RootUrl)commentReply/addReply"
let ReplyreplyreplyListUrl = "\(RootUrl)commentReply/getReplyList"
let ReplyreplyreplyDeleteUrl = "\(RootUrl)commentReply/delReply"
let ReportAddReportUrl = "\(RootUrl)report/addReport"

let ArticleTypeUrl = "\(RootUrl)article/getArticleType"
let ArticleInfoUrl = "\(RootUrl)article/getArticleInfo"
let ArticleListUrl = "\(RootUrl)article"

let CommentgetPointUrl = "\(RootUrl)common/getPointList"
let CommentgetRechargeUrl = "\(RootUrl)common/getRechargeList"
let CommentgetTimetUrl = "\(RootUrl)common/getTime"
let CommentReplyApprovetUrl = "\(RootUrl)commentReply/addReplyApprove"

let NotifynotifyListUrl = "\(RootUrl)notify/getNotifyList"
let NotifyUnreadUrl = "\(RootUrl)notify/getUnreadNotify"
let NotifyAlertStatusUrl = "\(RootUrl)notify/updateNotifyStatus"
let NotifyAlertDeleteUrl = "\(RootUrl)notify/delNotify"

let PersonapplyMasterUrl = "\(RootUrl)person/applyMaster"
let PersonfindRecentUrl = "\(RootUrl)person/findRecent"
let PersonfollowUserUrl = "\(RootUrl)person/followUser"
let PersonmyFansUrl = "\(RootUrl)person/getFansList"
let PersonmyfollowUrl = "\(RootUrl)person/getFollowList"
let PersonnameAuthUrl = "\(RootUrl)person/nameAuth"
let PersonsignInUrl = "\(RootUrl)person/signIn"
let PersonsignStatusInUrl = "\(RootUrl)person/signInStatus"
let PersonupdateFollowUrl = "\(RootUrl)person/updateFollow"
let PersonupdateUserUrl = "\(RootUrl)person/updateUser"

let TipapproveTipUrl = "\(RootUrl)tip/addApproveTip"
let TipcollectTipUrl = "\(RootUrl)tip/addCollectTip"
let TipgetTipDetailUrl = "\(RootUrl)tip/getTipDetail"
let TipgetTipListUrl = "\(RootUrl)tip/getTipList"
let TippublishTipUrl = "\(RootUrl)tip/addTip"
let TipArticleDeleteUrl = "\(RootUrl)tip/delTip"
let TippublishTopTipUrl = "\(RootUrl)topic/getTopicList"

let TribesubscribeUrl = "\(RootUrl)tribe/subscribe"
let TribetribeListUrl = "\(RootUrl)tribe/getTribeList"

//let NotificationDetailUrl = "\(RootUrl)notify/getNotifyList"
let NotificationListUrl = "\(RootUrl)notify/getNotifyList"

let PayUrl = "\(RootUrl)pay/iosPay"

let UserFeedBackinsertFeedbackUrl = "\(RootUrl)userFeedback/addFeedback"

let ADvertiseUsableAdvertise = "\(RootUrl)advertise/getUsableAdvertise"


let FootBallMatchUrl = "\(RootUrl)football/getData"
let FootBallInfoUrl = "\(RootUrl)football/getTeamsAndSoOn"

let BasketBallInfoUrl = "\(RootUrl)basketball/getBasketBallEventsAndSoOn"
let BasketBallMatchUrl = "\(RootUrl)basketball/getData"

let RegisterLoginUrl = "http://www.baodiantiyu.com:8081/bdty/index.html"
let InviteUrl = "http://www.baodiantiyu.com:8081/bdty/register.html"
let ShareUrl = "http://www.baodiantiyu.com:8081/bdty/invite.html"
let MasterUrl = "http://www.baodiantiyu.com:8081/bdty/master.html"
let SecretUrl="http://www.baodiantiyu.com:8081/bdty/secret.html"

let FootBallEVENTUrl = "https://open.sportnanoapi.com/api/sports/football/matchevent/list?user=xmtq&secret=2f9e2c9e7426285ed"

func getAliPayBankNameUrl(banNo:String) ->String {
    return "https://ccdcapi.alipay.com/validateAndCacheCardInfo.json?_input_charset=utf-8&cardNo=\(banNo)&cardBinCheck=true"
}

func getGoogleTransUrl() ->String {
    return "http://translate.google.cn/translate_a/single"
}

