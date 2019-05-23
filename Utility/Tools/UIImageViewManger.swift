//
//  UIImageViewManger.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import SDWebImage
import YYWebImage
typealias DownLoadImageCompletionBlock = (_ image:UIImage?, _ error:Error?, _ url:URL) -> Void
typealias ImageDownLoadImageCompletionBlock = (_ image:UIImage?, _ data:Data?,  _ error:Error?, _ ret:Bool) ->Void

let ImageRootURL = "https://\(OSS_BUCKET_PUBLIC).\(OSS_ENDPOINT)"

class UIImageViewManger: NSObject {

    class func sd_imageView(url:String, imageView:UIImageView,placeholderImage:UIImage?, completedBlock: SDWebImage.SDExternalCompletionBlock? = nil){
        imageView.sd_setImage(with: URL.init(string: "\(ImageRootURL)\(url)"), placeholderImage: placeholderImage, options: .retryFailed, completed: completedBlock)
    }
    
    class func sd_downImage(url:String, placeholderImage:UIImage?, completedBlock: SDWebImage.SDWebImageDownloaderCompletedBlock? = nil) {
        SDWebImageDownloader.shared.downloadImage(with: URL.init(string: "\(ImageRootURL)\(url)"), options: .continueInBackground, progress: { (pro, end, url) in
        }, completed: completedBlock)
    }
    
    
    
}
