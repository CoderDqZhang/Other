//
//  ArticleDetailContentTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/23.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import WebKit
typealias ReloadWebViewContentSize = (_ size:CGSize) ->Void

class ArticleDetailContentTableViewCell: UITableViewCell {

    var titleLabel:YYLabel!
    var originLabel:YYLabel!
    var timeInfoLabel:YYLabel!
    var webView:WKWebView!
    
    var reloadWebViewContentSize:ReloadWebViewContentSize!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .left
        titleLabel.font = App_Theme_PinFan_M_18_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = ""
        titleLabel.numberOfLines = 0
        self.contentView.addSubview(titleLabel)
        
        timeInfoLabel = YYLabel.init()
        timeInfoLabel.textAlignment = .left
        timeInfoLabel.font = App_Theme_PinFan_M_12_Font
        timeInfoLabel.textColor = App_Theme_999999_Color
        timeInfoLabel.text = ""
        self.contentView.addSubview(timeInfoLabel)
        
        originLabel = YYLabel.init()
        originLabel.textAlignment = .left
        originLabel.font = App_Theme_PinFan_M_12_Font
        originLabel.textColor = App_Theme_06070D_Color
        originLabel.text = ""
        self.contentView.addSubview(originLabel)
        
        
        //创建网页配置对象
        let config = WKWebViewConfiguration.init()
        let preference = WKPreferences.init()
        preference.minimumFontSize = 40
        config.preferences = preference
        
        webView = WKWebView.init(frame: CGRect.zero, configuration: config)
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = false
        self.contentView.addSubview(webView)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetData(model:ArticleInfoModel){
        titleLabel.text = model.title
        originLabel.text = "来源:\(String(describing: model.origin!))"
        timeInfoLabel.text = model.createTime
        let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header> + \(String(describing: model.descriptionField!))";

        webView.loadHTMLString(headerString, baseURL: nil)
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.contentView.snp.top).offset(20)
            }
            
            originLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.titleLabel.snp.left).offset(0)
                make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            }
            
            timeInfoLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.originLabel.snp.right).offset(15)
                make.top.equalTo(self.originLabel.snp.top).offset(0)
            }
            
            webView.snp.makeConstraints { (make) in
                make.top.equalTo(self.originLabel.snp.bottom).offset(20)
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
            }
            didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}

extension ArticleDetailContentTableViewCell : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        webView.evaluateJavaScript("var script = document.createElement('script');''document.body.style.fontSize=28.0;'//设置字体大小
//            'script.type = 'text/javascript';'
//            'script.text = \'function ResizeImages() { '
//            'var myimg,oldwidth;'
//            'var maxwidth = window.innerWidth;' // UIWebView中显示的图片宽度
//            'for(i=1;i <document.images.length;i++){'
//            'myimg = document.images[i];'
//            'oldwidth = myimg.width;'
//            'myimg.width = maxwidth;'
//            '}'
//            '}\';'
//        "document.getElementsByTagName('head')[0].appendChild(script);ResizeImages();") { (ret, error) in
//            
//        }
        
    }
}


