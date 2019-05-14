//
//  AuthorityManager.swift
//  CatchMe
//
//  Created by Zhang on 17/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import MapKit

class AuthorityManager: NSObject, CLLocationManagerDelegate {

    class func setUpAuthorityManager(controller:BaseViewController?){
        AuthorityManager.checkAudioStatus(controller: controller)
        AuthorityManager.checkVideoStatus(controller: controller)
        AuthorityManager.checkPhotoStauts(controller: controller)
    }
    
    //获取麦克风权限
    class func checkAudioStatus(controller:BaseViewController?){
        let authorizate = AVCaptureDevice.authorizationStatus(for: .audio)
        switch authorizate {
        case .denied:
            UIAlertController.showAlertControl(controller!, style: .alert, title: "请允许使用麦克风", message: "游戏需要麦克风权限", cancel: "取消", doneTitle: "确定", cancelAction: {
                
            }, doneAction: {
                SHARE_APPLICATION.openURL(URL.init(string: UIApplication.openSettingsURLString)!)
            })
//        case .authorized:
        case .notDetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { (ret) in
            }
        default:
            break;
        }
    }
    
    //获取照相机权限
    class func checkVideoStatus(controller:BaseViewController?){
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
            //没有询问开启相机
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (ret) in
                
            })
            //家长限制
//        case .restricted:
//            print()
        case .denied:
            UIAlertController.showAlertControl(controller!, style: .alert, title: "获取相机权限", message: "游戏需要麦克风权限", cancel: "取消", doneTitle: "确定", cancelAction: {
                
            }, doneAction: {
                SHARE_APPLICATION.openURL(URL.init(string: UIApplication.openSettingsURLString)!)
            })
//        case .authorized:
        default:
            break;
        }
    }
    
    //获取照片权限
    class func checkPhotoStauts(controller:BaseViewController?){
        let photoAuthorStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorStatus {
//        case .authorized:
//            break;
        case .denied:
            break;
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                
            })
        case .restricted:
            UIAlertController.showAlertControl(controller!, style: .alert, title: "获取相册权限", message: "游戏需要麦克风权限", cancel: "取消", doneTitle: "确定", cancelAction: {
                
            }, doneAction: {
                SHARE_APPLICATION.openURL(URL.init(string: UIApplication.openSettingsURLString)!)
            })
        default:
            break;
        }
    }
    
    //获取地理信息权限
}
