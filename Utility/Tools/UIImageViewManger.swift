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


let normalImage = UIImage.init(named: "placeholder")

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
    
    func appendImageUrl(url:String) ->String{
        return "\(ImageRootURL)\(url)"
    }
    
}

extension UIImageView {
    
    func sd_crope_imageView(url:String, imageView:UIImageView, placeholderImage:UIImage?, completedBlock:YYWebImageCompletionBlock?){
        let size = imageView.size
        
        self.yy_setImage(with: URL.init(string:url.contains("http") ? url : UIImageViewManger.getSharedInstance().appendImageUrl(url: url)), placeholder:normalImage!.yy_imageByResize(to: size, contentMode: UIView.ContentMode.scaleAspectFill), options: [.setImageWithFadeAnimation, .progressiveBlur, .showNetworkActivity,.ignoreImageDecoding], manager: nil, progress: { (start, end) in
            
        }, transform: { (image, url) -> UIImage? in
            return image.yy_imageByResize(to: size, contentMode: UIView.ContentMode.scaleAspectFill)
        }) { (image, url, type, state, error) in
            DispatchQueue.main.async(execute: {
                completedBlock!(image, url, type, state, error)
            })
        }
    }
    
    func sd_crope_imageView_withMaxWidth(url:String, imageSize:CGSize?, placeholderImage:UIImage?, completedBlock:SDExternalCompletionBlock?) {
//        self.sd_setImage(with: URL.init(string: url.contains("http") ? url :UIImageViewManger.getSharedInstance().appendImageUrl(url: url)), placeholderImage: normalImage, options: .retryFailed, completed: completedBlock)
        
        self.sd_setImage(with:  URL.init(string: url.contains("http") ? url : UIImageViewManger.getSharedInstance().appendImageUrl(url: url)), placeholderImage: normalImage, options: .retryFailed) { (image, error, cacheType, url) in
            
            completedBlock!(image,error,cacheType,url)
        }
        
//        let size = imageView.size
//        self.sd_setImage(with:  URL.init(string: url.contains("http") ? url : UIImageViewManger.getSharedInstance().appendImageUrl(url: url)), placeholderImage: normalImage, options: .retryFailed) { (image, error, cacheType, url) in
//            if error == nil {
//                completedBlock!(normalImage!.yy_imageByResize(to: size, contentMode: UIView.ContentMode.scaleAspectFill),error,cacheType,url)
//            }else{
//                completedBlock!(image,error,cacheType,url)
//            }
//        }
    }
    
    func sd_downImage(url:String, placeholderImage:UIImage?, completedBlock: SDWebImage.SDWebImageDownloaderCompletedBlock? = nil) {
        
        SDWebImageDownloader.shared.downloadImage(with: URL.init(string: "\(ImageRootURL)\(url)"), options: .continueInBackground, progress: { (pro, end, url) in
        }, completed: completedBlock)
    }
    
    
}
