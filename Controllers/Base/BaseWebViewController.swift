//
//  BaseWebViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/16.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit


/**
 IOS7 以后才可以使用的
 超出WebView大小的View,展示形式
 */
 public enum UIWebPaginationMode : Int {
    // 默认
    case unpaginated
 
    // 从左到右进行翻页
    case leftToRight
 
    // 从顶部到底部进行翻页
    case topToBottom
 
    // 从底部到顶部进行翻页
    case bottomToTop
 
    // 从右向左进行翻页
    case rightToLeft
 }

class BaseWebViewController: UIViewController {

    var webView:UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = App_Theme_F6F6F6_Color
        self.setNavigationItemBack()
        self.setUpView()
        // Do any additional setup after loading the view.
    }
    
    
    
    func setUpView(){
        if webView == nil {
            webView = UIWebView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
            webView.sizeToFit()
            webView.sizeThatFits(CGSize.init(width: SCREENWIDTH, height: SCREENHEIGHT))
            webView.scalesPageToFit = true
            webView.allowsInlineMediaPlayback = true
            webView.mediaPlaybackRequiresUserAction = true
            webView.suppressesIncrementalRendering = true
            webView.keyboardDisplayRequiresUserAction = true
            webView.mediaPlaybackAllowsAirPlay = true
            webView.paginationMode  = .bottomToTop
            
            //        let pageWidth = webView.pageLength
            //        webView.pageLength = 100
            //        let grapWeb = webView.gapBetweenPages
            //        webView.gapBetweenPages = 20
            
            self.view.addSubview(webView)
            webView.delegate = self
        }
    }
    
    func loadRequest(url:String){
        let request = URLRequest.init(url: URL.init(string: url)!)
        if webView == nil {
            self.setUpView()
        }
        webView.loadRequest(request)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension BaseWebViewController : UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        return true
    }
}
