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
    
    func appendImageUrl(url:String) ->String{
        return "\(ImageRootURL)\(url)"
    }
    
}

extension UIImageView {
    
    func sd_crope_imageView(url:String, imageView:UIImageView, placeholderImage:UIImage?, completedBlock:YYWebImageCompletionBlock?){
        let size = imageView.size
        self.yy_setImage(with: URL.init(string: UIImageViewManger.getSharedInstance().appendImageUrl(url: url)), placeholder: nil, options: [.setImageWithFadeAnimation, .progressiveBlur, .showNetworkActivity], manager: nil, progress: { (start, end) in
            
        }, transform: { (image, url) -> UIImage? in
            return image.yy_imageByResize(to: size, contentMode: UIView.ContentMode.scaleAspectFill)
        }) { (image, url, type, state, error) in
            DispatchQueue.main.async(execute: {
                completedBlock!(image, url, type, state, error)
            })
        }
    }
    
    func sd_crope_imageView_withMaxWidth(url:String, placeholderImage:UIImage?, completedBlock:SDExternalCompletionBlock?) {
        self.sd_setImage(with: URL.init(string: UIImageViewManger.getSharedInstance().appendImageUrl(url: url)), placeholderImage: placeholderImage, options: .retryFailed, completed: completedBlock)
        
//        self.yy_setImage(with: URL.init(string: UIImageViewManger.getSharedInstance().appendImageUrl(url: url)), placeholder: nil, options: [.ignoreDiskCache], manager: nil, progress: { (start, end) in
//
//        }, transform: { (image, url) -> UIImage? in
//            let size = image.size
//            let height = size.height * (SCREENWIDTH - 30) / size.width
//            return image.yy_imageByResize(to: CGSize.init(width: SCREENWIDTH - 30, height: height), contentMode: UIView.ContentMode.scaleAspectFill)
//        }) { (image, url, type, state, error) in
//            DispatchQueue.main.async(execute: {
//                completedBlock!(image, url, type, state, error)
//            })
//        }
    }
    
    func sd_downImage(url:String, placeholderImage:UIImage?, completedBlock: SDWebImage.SDWebImageDownloaderCompletedBlock? = nil) {
        
        SDWebImageDownloader.shared.downloadImage(with: URL.init(string: "\(ImageRootURL)\(url)"), options: .continueInBackground, progress: { (pro, end, url) in
        }, completed: completedBlock)
    }
    
    
}
