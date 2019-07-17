//
//  BaseWebViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/16.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class BaseWebViewController: UIViewController {

    var url:String = ""
    var webView:UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = App_Theme_F6F6F6_Color
        // Do any additional setup after loading the view.
    }
    
    func setUpView(){
        webView = UIWebView.init()
        self.view.addSubview(webView)
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
