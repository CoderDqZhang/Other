//
//  NotificationService.swift
//  JPushExtentions
//
//  Created by Zhang on 2019/7/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UserNotifications
import UIKit

typealias completionHandler = (_ attach:UNNotificationAttachment) -> Void
let kEncodeUserCachesDirectory = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as String
let NOTIFICATIOINSPUSHCONTROLLER = "NOTIFICATIOINSPUSHCONTROLLER"


class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            bestAttemptContent.title = "\(bestAttemptContent.title)"
            bestAttemptContent.subtitle = "\(bestAttemptContent.subtitle)"
            bestAttemptContent.body = "\(bestAttemptContent.body)"
//            self.loadAttachmentForUrlString(urlStr: bestAttemptContent.launchImageName, type: "image") { (attach) in
//                self.bestAttemptContent!.attachments = [attach]
//                self.contentHandler!(self.bestAttemptContent!);
//            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATIOINSPUSHCONTROLLER), object: nil, userInfo: bestAttemptContent.userInfo)
            contentHandler(bestAttemptContent)
        }
        
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
    
    func loadAttachmentForUrlString(urlStr:String, type:String, completionHandle:@escaping completionHandler) {
        let url = NSURL.init(string: urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        let fileExt = self.fileExtensionForMediaType(type: type)
        let task = session.dataTask(with: url! as URL) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                let path = self.getCachesDirectoryUserInfoDocumetPathDocument(user: "Public", document: "PushImages")
                let saveName = path?.appending("/pushImage\(fileExt)")
                do {
                    try data!.write(to: NSURL.init(string: saveName!)! as URL, options: Data.WritingOptions.atomicWrite)
                    var attachment:UNNotificationAttachment
                    try  attachment = UNNotificationAttachment(identifier: "remote-atta1", url: NSURL.init(fileURLWithPath: saveName!) as URL, options: nil)
                    completionHandle(attachment)
                }catch{
                    
                }
            }
        }
        task.resume()
    }
    
    func getCachesDirectoryUserInfoDocumetPathDocument(user:String, document:String) ->String? {
        let manager = FileManager.default
        let path = kEncodeUserCachesDirectory.appending("/\(user)").appending("/\(document)")
        if !manager.fileExists(atPath: path) {
            do {
                try manager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                return path
            } catch {
                print("创建失败")
                return nil
            }
        }else{
            return path
        }
    }
    
    func fileExtensionForMediaType(type:String) -> String{
        var ext = type
        if type == "image" {
            ext = "jpg"
        }
        
        if type == "video" {
            ext = "mp4"
        }
        
        if type == "audio" {
            ext = "mp3"
        }
        return ".\(ext)"
    }

}
