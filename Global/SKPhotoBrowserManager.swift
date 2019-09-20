//
//  SKPhotoBrowserManager.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/18.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class SKPhotoBrowserManager: NSObject {

    private static let _sharedInstance = SKPhotoBrowserManager()
    
    class func getSharedInstance() -> SKPhotoBrowserManager {
        return _sharedInstance
    }
    
    private override init() {
        super.init()
        self.config()
    } // 私有化init方法
    
    func setUpBrowserWithImages(images:[UIImage],selectPageIndex:Int?) -> SKPhotoBrowser{
        var skImages = [SKPhoto]()

        for image in images{
            let photo = SKPhoto.photoWithImage(image)
            skImages.append(photo)
        }
        
        // 2. create PhotoBrowser Instance, and present from your viewController.
        let browser = SKPhotoBrowser(photos: skImages)
        browser.initializePageIndex(selectPageIndex == nil ? 0 : selectPageIndex!)
        return browser
    }
    
    func setUpBrowserWithUrl(urls:[Substring],selectPageIndex:Int?) -> SKPhotoBrowser{
        var images = [SKPhoto]()

        for url in urls{
            let photo = SKPhoto.photoWithImageURL(UIImageViewManger.getSharedInstance().appendImageUrl(url: String(url)), holder: holderImage)
            images.append(photo)
        }
        
        // 2. create PhotoBrowser Instance, and present from your viewController.
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(selectPageIndex == nil ? 0: selectPageIndex!)
        return browser
    }
    
    func setUpBrowserWithStrUrl(urls:[String],selectPageIndex:Int?) -> SKPhotoBrowser{
        var images = [SKPhoto]()
        
        for url in urls{
            let photo = SKPhoto.photoWithImageURL(UIImageViewManger.getSharedInstance().appendImageUrl(url: url), holder: holderImage)
            images.append(photo)
        }
        
        // 2. create PhotoBrowser Instance, and present from your viewController.
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(selectPageIndex == nil ? 0: selectPageIndex!)
        return browser
    }
    
    func config(){
        SKPhotoBrowserOptions.displayStatusbar = false                              // all tool bar will be hidden
        SKPhotoBrowserOptions.displayCounterLabel = false                         // counter label will be hidden
        SKPhotoBrowserOptions.displayBackAndForwardButton = false                 // back / forward button will be hidden
        SKPhotoBrowserOptions.displayAction = false                               // action button will be hidden
        SKPhotoBrowserOptions.displayHorizontalScrollIndicator = false            // horizontal scroll bar will be hidden
        SKPhotoBrowserOptions.displayVerticalScrollIndicator = false              // vertical scroll bar will be hidden
        SKPhotoBrowserOptions.enableSingleTapDismiss = true
    }
}
