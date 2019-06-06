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

let RootUrl = "http://192.168.0.155:10020/social/"
//let RootUrl = "http://192.168.0.172:10020/social/"

let UserforgetPasswordUrl = "\(RootUrl)user/forgetPassword"
let UserLoginUrl = "\(RootUrl)user/login"
let UserlogoutUrl = "\(RootUrl)user/logout"
let UserregisterUrl = "\(RootUrl)user/register"
let UsersendCodeUrl = "\(RootUrl)user/sendCode"
let SurePasswordUrl = "\(RootUrl)user/surePassword"
let UserInfoUrl = "\(RootUrl)user/userInfo"

let AccountbindAccountUrl = "\(RootUrl)account/bindAccount"
let AccountcashUrl = "\(RootUrl)account/cash"
let AccountcoinDetailUrl = "\(RootUrl)account/coinDetail"
let AccountfindAccountUrl = "\(RootUrl)account/findAccount"
let AccountfindInviteUrl = "\(RootUrl)account/findInvite"
let AccountfindPasswordUrl = "\(RootUrl)account/findPassword"
let AccountgetPointCountUrl = "\(RootUrl)account/getPointCount"
let AccountpointDetailUrl = "\(RootUrl)account/pointDetail"
let AccountUsersurePasswordUrl = "\(RootUrl)account/surePassword"
let AccountFindCashAccountUrl = "\(RootUrl)account/findCashAccount"
let AccountDeleteAccountUrl = "\(RootUrl)account/deleteCashAccount"

let CommentcommentUrl = "\(RootUrl)comment/comment"
let CommentcommentApprovetUrl = "\(RootUrl)comment/commentApprove"
let CommentcommentDetailUrl = "\(RootUrl)comment/commentDetail"
let CommentcommentListUrl = "\(RootUrl)comment/commentList"
let ReplyreplyUrl = "\(RootUrl)commentReply/reply"
let ReplyreplyreplyListUrl = "\(RootUrl)commentReply/replyList"
let CommentgetPointUrl = "\(RootUrl)common/getPoint"
let CommentgetRechargeUrl = "\(RootUrl)common/getRecharge"
let CommentgetTimetUrl = "\(RootUrl)common/getTime"
let CommentReplyApprovetUrl = "\(RootUrl)commentReply/replyApprove"

let NotifynotifyListUrl = "\(RootUrl)notify/notifyList"

let PersonapplyMasterUrl = "\(RootUrl)person/applyMaster"
let PersonfindRecentUrl = "\(RootUrl)person/findRecent"
let PersonfollowUserUrl = "\(RootUrl)person/followUser"
let PersonmyFansUrl = "\(RootUrl)person/myFans"
let PersonmyfollowUrl = "\(RootUrl)person/myfollow"
let PersonnameAuthUrl = "\(RootUrl)person/nameAuth"
let PersonsignInUrl = "\(RootUrl)person/signIn"
let PersonupdateFollowUrl = "\(RootUrl)person/updateFollow"
let PersonupdateUserUrl = "\(RootUrl)person/updateUser"

let TipapproveTipUrl = "\(RootUrl)tip/approveTip"
let TipcollectTipUrl = "\(RootUrl)tip/collectTip"
let TipgetTipDetailUrl = "\(RootUrl)tip/getTipDetail"
let TipgetTipListUrl = "\(RootUrl)tip/getTipList"
let TippublishTipUrl = "\(RootUrl)tip/publishTip"

let TribesubscribeUrl = "\(RootUrl)tribe/subscribe"
let TribetribeListUrl = "\(RootUrl)tribe/tribeList"

let NotificationDetailUrl = "\(RootUrl)notify/findNotify"
let NotificationListUrl = "\(RootUrl)notify/notifyList"

let UserFeedBackinsertFeedbackUrl = "\(RootUrl)userFeedback/insertFeedback"


func getAliPayBankNameUrl(banNo:String) ->String {
    return "https://ccdcapi.alipay.com/validateAndCacheCardInfo.json?_input_charset=utf-8&cardNo=\(banNo)&cardBinCheck=true"
}

