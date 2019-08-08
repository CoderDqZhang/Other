//
//  BaseWebViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/16.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import WebKit
import ReactiveCocoa
import ReactiveSwift
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

    // wkWebView
    lazy var wkWebView = WKWebView()
    // 进度条
    lazy var progressView = UIProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = App_Theme_F6F6F6_Color
        self.setNavigationItemBack()
        self.setUpView()
        // Do any additional setup after loading the view.
    }
    
    
    func setUpView() -> () {
        
        self.wkWebView.frame = CGRect(x: 0
            , y: 0
            , width: SCREENWIDTH
            , height: SCREENHEIGHT)
        
        wkWebView.navigationDelegate = self
        self.view.addSubview(self.wkWebView)
        self.wkWebView.reactive.signal(forKeyPath: "estimatedProgress").observeValues { (str) in
            self.progressView.progress = Float(str as! Double)
        }
        
        
        
        self.progressView.frame = CGRect(x: 0
            , y: 0
            , width: SCREENWIDTH
            , height: 2)
        progressView.progressTintColor = UIColor.red
        progressView.trackTintColor = UIColor.clear
        self.view.addSubview(self.progressView)
    }
    
    func loadRequest(url:String){
        let request = URLRequest.init(url: URL.init(string: url)!)
        self.setUpView()
        wkWebView.load(request)
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

extension BaseWebViewController : WKNavigationDelegate {
    /*! @abstract Decides whether to allow or cancel a navigation.
     @param webView The web view invoking the delegate method.
     @param navigationAction Descriptive information about the action
     triggering the navigation request.
     @param decisionHandler The decision handler to call to allow or cancel the
     navigation. The argument is one of the constants of the enumerated type WKNavigationActionPolicy.
     @discussion If you do not implement this method, the web view will load the request or, if appropriate, forward it to another application.
     */
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void){
        if (webView.url?.absoluteString.hasPrefix("https://itunes.apple.com"))! {
            SHARE_APPLICATION.openURL(navigationAction.request.url!)
        }else{
            decisionHandler(WKNavigationActionPolicy.allow)
        }
    }
    
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        Log4jMessage(message: "开始加载...")
    }
    
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
//        Log4jMessage(message: "当内容开始返回...")
    }
    
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
//        Log4jMessage(message: "页面加载完成...")
        /// 获取网页title
        self.title = self.wkWebView.title
        
        UIView.animate(withDuration: 0.5) {
            self.progressView.isHidden = true
        }
    }
    
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
//        Log4jMessage(message: "页面加载失败...")
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = 0.0
            self.progressView.isHidden = true
        }
        /// 弹出提示框点击确定返回
        let alertView = UIAlertController.init(title: "提示", message: "加载失败", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title:"确定", style: .default) { okAction in
            _=self.navigationController?.popViewController(animated: true)
        }
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
}

extension BaseWebViewController : WKUIDelegate {
    /*! @abstract Creates a new web view.
     @param webView The web view invoking the delegate method.
     @param configuration The configuration to use when creating the new web
     view. This configuration is a copy of webView.configuration.
     @param navigationAction The navigation action causing the new web view to
     be created.
     @param windowFeatures Window features requested by the webpage.
     @result A new web view or nil.
     @discussion The web view returned must be created with the specified configuration. WebKit will load the request in the returned web view.
     
     If you do not implement this method, the web view will cancel the navigation.
     */
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView?{
        return WKWebView.init()
    }
    
    
    /*! @abstract Notifies your app that the DOM window object's close() method completed successfully.
     @param webView The web view invoking the delegate method.
     @discussion Your app should remove the web view from the view hierarchy and update
     the UI as needed, such as by closing the containing browser tab or window.
     */
    func webViewDidClose(_ webView: WKWebView){
        
    }
    
    
    /*! @abstract Displays a JavaScript alert panel.
     @param webView The web view invoking the delegate method.
     @param message The message to display.
     @param frame Information about the frame whose JavaScript initiated this
     call.
     @param completionHandler The completion handler to call after the alert
     panel has been dismissed.
     @discussion For user security, your app should call attention to the fact
     that a specific website controls the content in this panel. A simple forumla
     for identifying the controlling website is frame.request.URL.host.
     The panel should have a single OK button.
     
     If you do not implement this method, the web view will behave as if the user selected the OK button.
     */
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void){
        
    }
    
    
    /*! @abstract Displays a JavaScript confirm panel.
     @param webView The web view invoking the delegate method.
     @param message The message to display.
     @param frame Information about the frame whose JavaScript initiated this call.
     @param completionHandler The completion handler to call after the confirm
     panel has been dismissed. Pass YES if the user chose OK, NO if the user
     chose Cancel.
     @discussion For user security, your app should call attention to the fact
     that a specific website controls the content in this panel. A simple forumla
     for identifying the controlling website is frame.request.URL.host.
     The panel should have two buttons, such as OK and Cancel.
     
     If you do not implement this method, the web view will behave as if the user selected the Cancel button.
     */
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void){
        
    }
    
    
    /*! @abstract Displays a JavaScript text input panel.
     @param webView The web view invoking the delegate method.
     @param prompt The prompt to display.
     @param defaultText The initial text to display in the text entry field.
     @param frame Information about the frame whose JavaScript initiated this call.
     @param completionHandler The completion handler to call after the text
     input panel has been dismissed. Pass the entered text if the user chose
     OK, otherwise nil.
     @discussion For user security, your app should call attention to the fact
     that a specific website controls the content in this panel. A simple forumla
     for identifying the controlling website is frame.request.URL.host.
     The panel should have two buttons, such as OK and Cancel, and a field in
     which to enter text.
     
     If you do not implement this method, the web view will behave as if the user selected the Cancel button.
     */
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void){
        
    }
    
    
    /*! @abstract Allows your app to determine whether or not the given element should show a preview.
     @param webView The web view invoking the delegate method.
     @param elementInfo The elementInfo for the element the user has started touching.
     @discussion To disable previews entirely for the given element, return NO. Returning NO will prevent
     webView:previewingViewControllerForElement:defaultActions: and webView:commitPreviewingViewController:
     from being invoked.
     
     This method will only be invoked for elements that have default preview in WebKit, which is
     limited to links. In the future, it could be invoked for additional elements.
     */
    func webView(_ webView: WKWebView, shouldPreviewElement elementInfo: WKPreviewElementInfo) -> Bool{
        return false
    }
    
    
    /*! @abstract Allows your app to provide a custom view controller to show when the given element is peeked.
     @param webView The web view invoking the delegate method.
     @param elementInfo The elementInfo for the element the user is peeking.
     @param defaultActions An array of the actions that WebKit would use as previewActionItems for this element by
     default. These actions would be used if allowsLinkPreview is YES but these delegate methods have not been
     implemented, or if this delegate method returns nil.
     @discussion Returning a view controller will result in that view controller being displayed as a peek preview.
     To use the defaultActions, your app is responsible for returning whichever of those actions it wants in your
     view controller's implementation of -previewActionItems.
     
     Returning nil will result in WebKit's default preview behavior. webView:commitPreviewingViewController: will only be invoked
     if a non-nil view controller was returned.
     */
//    func webView(_ webView: WKWebView, previewingViewControllerForElement elementInfo: WKPreviewElementInfo, defaultActions previewActions: [WKPreviewActionItem]) -> UIViewController?{
//
//    }
    
    
    /*! @abstract Allows your app to pop to the view controller it created.
     @param webView The web view invoking the delegate method.
     @param previewingViewController The view controller that is being popped.
     */
    func webView(_ webView: WKWebView, commitPreviewingViewController previewingViewController: UIViewController){
        
    }
}
