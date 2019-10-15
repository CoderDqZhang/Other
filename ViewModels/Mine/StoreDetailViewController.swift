//
//  StoreDetailViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/26.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import WebKit
import WKWebViewJavascriptBridge

class StoreDetailViewController: BaseViewController {
    let webView = WKWebView(frame: CGRect(), configuration: WKWebViewConfiguration())
    var bridge: WKWebViewJavascriptBridge!
    var goodsId:String!
    let storeDetaiViewModel = StoreDetailViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup webView
        if #available(iOS 11.0, *) {
            webView.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT - 64 - NAV_HEIGHT)
        } else {
             webView.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT - 64)
            // Fallback on earlier versions
        }
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        // setup bridge
        bridge = WKWebViewJavascriptBridge(webView: webView)
        bridge.isLogEnable = true
        bridge.register(handlerName: "exchage") { (paramters, callback) in
            self.storeDetaiViewModel.exchangeNet(goodsId: self.goodsId, remark: (paramters! as NSDictionary).object(forKey: "remark") as! String)
        }
        bridge.call(handlerName: "testJavascriptHandler", data: ["foo": "before ready"], callback: nil)
    }
    
    override func setUpViewNavigationItem() {
        self.setNavigationItemBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadPage(url:String) {
        enum LoadDemoPageError: Error {
            case nilPath
        }
        
        do {
            let request = URLRequest.init(url: URL.init(string: url)!)
            webView.load(request)
        } catch LoadDemoPageError.nilPath {
            print(print("webView loadDemoPage error: pagePath is nil"))
        } catch let error {
            print("webView loadDemoPage error: \(error)")
        }
    }
}

extension StoreDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("webViewDidStartLoad")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webViewDidFinishLoad")
        self.navigationItem.title = self.webView.title
    }
}
