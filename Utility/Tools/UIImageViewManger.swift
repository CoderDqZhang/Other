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


let normalImage = UIImage.init(named: "")

//func getholderImage(size:CGSize) ->UIImage{
//    UIImageViewManger.sd_downImage(url: "", placeholderImage: nil) { (image, data, error, ret) in
//        return image
//    }
//    return normalImage!
//}


class UIImageViewManger: NSObject {

    
    private static let _sharedInstance = UIImageViewManger()
    
    class func getSharedInstance() -> UIImageViewManger {
        return _sharedInstance
    }
    
    private override init() {} // 私有化init方法
    
    
//    func sd_imageView(url:String, imageView:UIImageView,placeholderImage:UIImage?, completedBlock: SDWebImage.SDExternalCompletionBlock? = nil){
//        imageView.sd_setImage(with: URL.init(string: UIImageViewManger.getSharedInstance().appendImageUrl(url: url)), placeholderImage: placeholderImage == nil ? holderImage : placeholderImage, options: .retryFailed, completed: completedBlock)
//    }
//
//    func sd_downImage(url:String, placeholderImage:UIImage?, completedBlock: SDWebImage.SDWebImageDownloaderCompletedBlock? = nil) {
//        SDWebImageDownloader.shared.downloadImage(with: URL.init(string: "\(ImageRootURL)\(url)"), options: .continueInBackground, progress: { (pro, end, url) in
//        }, completed: completedBlock)
//    }
    
    func appendImageUrl(url:String) ->String{
        return "\(ImageRootURL)\(url)"
    }
    
}

extension UIImageView {
    
    func sd_crope_imageView(url:String, imageView:UIImageView, placeholderImage:UIImage?, completedBlock:YYWebImageCompletionBlock?){
        self.yy_setImage(with: URL.init(string: UIImageViewManger.getSharedInstance().appendImageUrl(url: url)), placeholder: nil, options: [.setImageWithFadeAnimation, .refreshImageCache, .progressiveBlur, .showNetworkActivity], manager: nil, progress: { (start, end) in
            
        }, transform: { (image, url) -> UIImage? in
            return image.yy_imageByResize(to: imageView.size, contentMode: UIView.ContentMode.scaleAspectFill)
        }) { (image, url, type, state, error) in
            if error == nil {
                DispatchQueue.main.async(execute: {
                    completedBlock!(image, url, type, state, error)
                })
            }
        }
    }
    
    func sd_downImage(url:String, placeholderImage:UIImage?, completedBlock: SDWebImage.SDWebImageDownloaderCompletedBlock? = nil) {
        SDWebImageDownloader.shared.downloadImage(with: URL.init(string: "\(ImageRootURL)\(url)"), options: .continueInBackground, progress: { (pro, end, url) in
        }, completed: completedBlock)
    }
    
    
}
