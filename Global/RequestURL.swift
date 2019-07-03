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

let RootUrl = "http://192.168.0.155:10020/social/"
//let RootUrl = "http://192.168.0.172:10020/social/"

let UserforgetPasswordUrl = "\(RootUrl)user/forgetPassword"
let UserBindPhoneUrl = "\(RootUrl)user/bindPhone"
let UserLoginUrl = "\(RootUrl)user/login"
let UserlogoutUrl = "\(RootUrl)user/logout"
let UserregisterUrl = "\(RootUrl)user/register"
let UsersendCodeUrl = "\(RootUrl)user/sendCode"
let SurePasswordUrl = "\(RootUrl)user/updatePassword"
let UserInfoUrl = "\(RootUrl)user/getUserInfo"

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
let TippublishTopTipUrl = "\(RootUrl)topic/getTopicList"

let TribesubscribeUrl = "\(RootUrl)tribe/subscribe"
let TribetribeListUrl = "\(RootUrl)tribe/getTribeList"

//let NotificationDetailUrl = "\(RootUrl)notify/getNotifyList"
let NotificationListUrl = "\(RootUrl)notify/getNotifyList"

let UserFeedBackinsertFeedbackUrl = "\(RootUrl)userFeedback/addFeedback"


func getAliPayBankNameUrl(banNo:String) ->String {
    return "https://ccdcapi.alipay.com/validateAndCacheCardInfo.json?_input_charset=utf-8&cardNo=\(banNo)&cardBinCheck=true"
}

func getGoogleTransUrl() ->String {
    return "http://translate.google.cn/translate_a/single"
}

