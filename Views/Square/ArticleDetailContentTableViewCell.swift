//
//  ArticleDetailContentTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/23.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore

typealias ReloadWebViewContentSize = (_ size:CGSize) ->Void

class ArticleDetailContentTableViewCell: UITableViewCell {

    var titleLabel:YYLabel!
    var originLabel:YYLabel!
    var timeInfoLabel:YYLabel!
//    var webView:WKWebView!
    var model:ArticleInfoModel!
    var webViewDone:Bool = false
    
    var reloadWebViewContentSize:ReloadWebViewContentSize!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
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
//        let config = WKWebViewConfiguration.init()
//        let preference = WKPreferences.init()
////        preference.minimumFontSize = 33
//        config.preferences = preference
//
//        webView = WKWebView.init(frame: CGRect.zero, configuration: config)
//        webView.navigationDelegate = self
//        webView.scrollView.isScrollEnabled = false
//        self.contentView.addSubview(webView)
        
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetData(model:ArticleInfoModel, webView:WKWebView){
        titleLabel.text = model.title
        originLabel.text = "来源:\(String(describing: model.origin!))"
        timeInfoLabel.text = model.createTime
        self.contentView.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.top.equalTo(self.originLabel.snp.bottom).offset(20)
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
        }
    }
    
    func converHtml(str:String) ->String{
        let temp_str = NSString.init(string: str)
        let left_width = temp_str.components(separatedBy: "width:")
        if left_width.count > 1 {
            let width = left_width[1].components(separatedBy: "p")[0]
            let left_height = temp_str.components(separatedBy: "height:")
            let right_str = left_height[1].components(separatedBy: "x;")[1]
            let height = left_height[1].components(separatedBy: "p")[0]
            var result_height:CGFloat = 0
            if width.cgFloat()! > SCREENWIDTH {
                result_height = SCREENWIDTH * height.cgFloat()! / width.cgFloat()!
            }
            return "\(left_width[0])width:\(SCREENWIDTH);height:\(result_height);\(right_str)"
        }else{
            return str
        }
        
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
        webViewDone = true
    }
}


