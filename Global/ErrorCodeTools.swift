//
//  ErrorCodeTools.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/19.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

//INVALID_PARAM(false, 10003, "非法参数！"),
//SUCCESS(true, 10000, "操作成功！"),
//FAIL(false, 11111, "操作失败！"),
//UNAUTHENTICATED(false, 10001, "此操作需要登陆系统！"),
//UNAUTHORISE(false, 10002, "权限不足，无权操作！"),
//SERVER_ERROR(false, 99999, "抱歉，系统繁忙，请稍后重试！");
//AUTH_USERNAME_NONE(false,23001,"请输入账号！"),
//AUTH_PASSWORD_NONE(false,23002,"请输入密码！"),
//AUTH_VERIFYCODE_NONE(false,23003,"请输入验证码！"),
//AUTH_ACCOUNT_NOTEXISTS(false,23004,"账号不存在！"),
//AUTH_CREDENTIAL_ERROR(false,23005,"账号或密码错误！"),
//AUTH_LOGIN_ERROR(false,23006,"登陆过程出现异常请尝试重新操作！"),
//AUTH_ACCOUNT_FORBID(false,23007,"帐号被禁用"),
//AUTH_ACCOUNT_EXISTS(false,23008,"帐号已存在"),
//AUTH_IDNUMBER_FAIL(false,23009,"认证信息与实名认证信息不符"),
//AUTH_IS_MASTER(false,23010,"你已经是专家了"),
//AUTH_PHONE_EXISTS(false,23011,"手机号已存在 "),
//
//AUTH_PASSWROD_ERROR(false,23012,"密码错误"),
//AUTH_CODE_ERROR(false,23013,"验证码错误 "),
//AUTH_CODE_EXISTS(false,23014,"请勿重复发送验证码"),
//AUTH_COIN_NOENOUGH(false,23015,"余额不足"),
//AUTH_NOT_MEMBER(false,23016,"未实名认证"),
//AUTH_IDNUMBER_ERROR(false,23017,"身份证错误"),
//WAITE_AUTH(false,23018,"请等待管理员认证"),
//
//IS_NAME_AUTH(false,23019,"已认证请勿重复认证"),
//IS_STATUS_REDO(false,23020,"请勿重复操作"),
//IS_REVIEW(false,23021,"账号审核中"),
//IS_SIGN(false,23022,"已签到"),
//IS_FOLLOW_SELF(false,23023,"你已经很关注你自己了")

enum ErrorCode:Int {
    case INVALID_PARAM = 10003 //非法参数！
    case SUCCESS = 10000 //操作成功！
    case FAIL = 11111 //操作失败！
    case UNAUTHENTICATED = 10001 //此操作需要登陆系统！
    case UNAUTHORISE = 10002 //权限不足，无权操作！
    case LOGINTIMEOUT = 10006 //登录超时
    case LOGINOTHERPHONE = 10005 //另一端登录
    case SERVER_ERROR = 99999 //抱歉，系统繁忙，请稍后重试！");
    case AUTH_USERNAME_NONE = 23001  //请输入账号！
    case AUTH_PASSWORD_NONE = 23002  //请输入密码！
    case AUTH_VERIFYCODE_NONE = 23003  //请输入验证码！
    case AUTH_ACCOUNT_NOTEXISTS = 23004  //账号不存在！
    case AUTH_CREDENTIAL_ERROR = 23005  //账号或密码错误！
    case AUTH_LOGIN_ERROR = 23006  //登陆过程出现异常请尝试重新操作！
    case AUTH_ACCOUNT_FORBID = 23007  //帐号被禁用
    case AUTH_ACCOUNT_EXISTS = 23008  //帐号已存在
    case AUTH_IDNUMBER_FAIL = 23009  //认证信息与实名认证信息不符
    case AUTH_IS_MASTER = 23010  //你已经是专家了
    case AUTH_PHONE_EXISTS = 23011  //手机号已存在
    
    case AUTH_PASSWROD_ERROR = 23012  //密码错误
    case AUTH_CODE_ERROR = 23013  //验证码错误
    case AUTH_CODE_EXISTS = 23014  //请勿重复发送验证码
    case AUTH_COIN_NOENOUGH = 23015  //余额不足
    case AUTH_NOT_MEMBER = 23016  //未实名认证
    case AUTH_IDNUMBER_ERROR = 23017  //身份证错误
    case WAITE_AUTH = 23018  //请等待管理员认证
    
    case IS_NAME_AUTH = 23019  //已认证请勿重复认证
    case IS_STATUS_REDO = 23020  //请勿重复操作
    case IS_REVIEW = 23021  //账号审核中
    case IS_SIGN = 23022  //已签到
    case IS_FOLLOW_SELF = 23023  //你已经很关注你自己了
}

class ErrorCodeTools: NSObject {
    private static let _sharedInstance = ErrorCodeTools()
    
    class func getSharedInstance() -> ErrorCodeTools {
        return _sharedInstance
    }
    
    private override init() {} // 私有化init方法
    
    func errorCode(responseObject:NSDictionary, fail:FailureClouse, sucess:SuccessClouse){
        print(responseObject.object(forKey: "data") as AnyObject)
        switch responseObject.object(forKey: "code") as! Int {
        case ErrorCode.SUCCESS.rawValue:
            sucess(responseObject.object(forKey: "data") as AnyObject)
        case ErrorCode.INVALID_PARAM.rawValue:
//            sucess(responseObject)
            _ = Tools.shareInstance.showMessage(KWindow, msg: responseObject.object(forKey: "msg") as! String, autoHidder: true)
            break
        case ErrorCode.FAIL.rawValue:
//            sucess(responseObject)
            _ = Tools.shareInstance.showMessage(KWindow, msg: responseObject.object(forKey: "msg") as! String, autoHidder: true)
            break
        case ErrorCode.LOGINOTHERPHONE.rawValue:
//            sucess(responseObject)
            CacheManager.getSharedInstance().logout()
            _ = Tools.shareInstance.showMessage(KWindow, msg: responseObject.object(forKey: "msg") as! String, autoHidder: true)
            break
        case ErrorCode.UNAUTHENTICATED.rawValue:
//            sucess(responseObject)
            _ = Tools.shareInstance.showMessage(KWindow, msg: responseObject.object(forKey: "msg") as! String, autoHidder: true)
            break
        case ErrorCode.UNAUTHENTICATED.rawValue:
//            sucess(responseObject)
            _ = Tools.shareInstance.showMessage(KWindow, msg: responseObject.object(forKey: "msg") as! String, autoHidder: true)
            break
        case ErrorCode.UNAUTHENTICATED.rawValue:
//            sucess(responseObject)
            _ = Tools.shareInstance.showMessage(KWindow, msg: responseObject.object(forKey: "msg") as! String, autoHidder: true)
            break
        default:
            _ = Tools.shareInstance.showMessage(KWindow, msg: responseObject.object(forKey: "msg") as! String, autoHidder: true)
            break
//            sucess(responseObject)
        }
    }
}
