//
//  BaseViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import MJRefresh

class BaseViewModel: NSObject {

    var controller:BaseViewController?
    var resultData:NSMutableArray!
    
    override init() {
        super.init()
    }
    
    func getControllerView() -> UIView{
        return self.controller!.view
    }
    
    func reloadTableViewData(){
        self.controller?.tableView.reloadData()
    }
    
    func hiddenMJLoadMoreData(resultData:Any){
        if self.controller?.tableView != nil {
            if resultData is NSDictionary {
                let pageModel = PageModel.init(fromDictionary: resultData as! [String : Any])
                if pageModel.current != nil && pageModel.current == pageModel.pages {
                    if self.controller?.tableView.mj_footer != nil {
                        self.controller?.tableView.mj_footer.endRefreshingWithNoMoreData()
                    }
                    self.controller?.stopRefresh()
                }else{
                    if pageModel.total != nil && pageModel.total != 0  && self.controller?.tableView.mj_footer == nil{
                        if self.controller!.setUpLoadMoreDataClouse != nil {
                            self.controller!.setUpLoadMoreDataClouse()
                        }
                    }
                    self.controller?.stopRefresh()
                }
            }else{
                self.controller?.stopRefresh()
            }
        }
    }
    
    //滑动到指定距离
    func tableViewScrollToPoint(_ point:CGPoint?, _ indexPath:IndexPath?){
        if indexPath != nil {
            self.controller?.tableView.scrollToRow(at: indexPath!, at: UITableView.ScrollPosition.top, animated: true)
        }
        
        if point != nil {
            self.controller?.tableView.setContentOffset(point!, animated: true)
        }
    }
    
    func imageContentHeight(image:String,contentWidth:CGFloat) ->CGFloat {
        var imageHeight:CGFloat = 0
        let images = image.split(separator: ",")
        if images.count >= 1 {
            for index in 0...images.count - 1 {
                var imageStrs = (images[index] as NSString).components(separatedBy: "_")
                if imageStrs.count > 2 {
                    let tempWidth = Int(imageStrs[imageStrs.count - 2].nsString.substring(with: NSRange.init(location: 1, length: imageStrs[imageStrs.count - 2].count - 1)))
                    let tempHeigth = Int(imageStrs[imageStrs.count - 1].nsString.components(separatedBy: ".")[0].nsString.substring(with: NSRange.init(location: 1, length: imageStrs[imageStrs.count - 1].nsString.components(separatedBy: ".")[0].count - 1)))
                    if CGFloat(tempWidth!) > contentWidth {
                        imageHeight = CGFloat(tempHeigth!) * contentWidth / CGFloat(tempWidth!) + imageHeight + 20
                    }else{
                        imageHeight = imageHeight + CGFloat(tempHeigth!) + 20
                    }
                }else{
                    imageHeight = imageHeight + 250 + 20
                }
            }
            return imageHeight - 20
        }else{
           return imageHeight
        }
    }
}

extension BaseViewModel : DZNEmptyDataSetDelegate {
    func emptyDataSetDidAppear(_ scrollView: UIScrollView!) {
        
    }
    
    func emptyDataSetWillAppear(_ scrollView: UIScrollView!) {
        
    }
    
    func emptyDataSetDidDisappear(_ scrollView: UIScrollView!) {
        
    }
    
    func emptyDataSetShouldFade(in scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
         return true
    }
}

extension BaseViewModel : DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributed = "网络开小猜了~"
        let attributedString = NSMutableAttributedString.init(string: attributed)
        attributedString.addAttributes([NSAttributedString.Key.font:App_Theme_PinFan_M_16_Font!,NSAttributedString.Key.foregroundColor:App_Theme_999999_Color!], range: NSRange.init(location: 0, length: 7))
        
        return attributedString
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "net_error")
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -64
    }
}
