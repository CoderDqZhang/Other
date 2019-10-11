//
//  ArticleDetailViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/23.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import WebKit

class ArticleDetailViewModel: BaseViewModel {

    var page:Int = 0
    var articleListArray = NSMutableArray.init()
    var articleId:String!

    var articleModel:ArticleInfoModel!
    var numberCount:Int = 0
    var webView:WKWebView!
    
    var contentHeight:CGFloat = 0
    
    override init() {
        super.init()
    }
    
    
    func tableViewArticleDetailContentTableViewCellSetData(_ indexPath:IndexPath, cell:ArticleDetailContentTableViewCell) {
        if articleModel != nil {
            cell.cellSetData(model: articleModel, webView: webView)
        }
    }
    
    func tableViewHotDetailTableViewCellSetData(_ indexPath:IndexPath, cell:HotDetailTableViewCell){
        cell.cellSetData(detail: "相关资讯", number: "")
    }
    
    func tableViewSquareTableViewCellSetData(_ indexPath:IndexPath, cell:SquareTableViewCell){
        if articleListArray.count > 0 {
            cell.cellSetData(model: ArticleInfoModel.init(fromDictionary: self.articleListArray[indexPath.row] as! [String : Any]))
        }
    }
    
    override func tapViewNoneData() {
        self.page = 0
        self.getArticleNet()
    }
    
    func tableViewDidSelect(tableView:UITableView, indexPath:IndexPath){
       let controllerVC = ArticleDetailViewController.init()
        controllerVC.articleData = (self.articleListArray[indexPath.row] as! NSDictionary)
       NavigationPushView(self.controller!, toConroller: controllerVC)
    }
    
    func calculateWebHeight(html:String) {
        //创建网页配置对象
        let config = WKWebViewConfiguration.init()
        let preference = WKPreferences.init()
        config.preferences = preference
        
        webView = WKWebView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH - 30, height: SCREENHEIGHT), configuration: config)
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = false
        let resutl_str = self.converHtml(str: html)
        webView.loadHTMLString("<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>\(resutl_str)", baseURL: nil)
        webView.scrollView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            numberCount = numberCount + 1
            print(self.webView.scrollView.contentSize.height)
            if self.contentHeight != self.webView.scrollView.contentSize.height {
                self.contentHeight = self.webView.scrollView.contentSize.height
                self.reloadTableViewData()
            }
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
    
    
    func getArticleNet(){
        let parameters = ["articleId":self.articleId!] as [String : Any]
        BaseNetWorke.getSharedInstance().postUrlWithString(ArticleInfoUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.articleModel = ArticleInfoModel.init(fromDictionary: resultDic.value as! [String : Any])
                self.calculateWebHeight(html: self.articleModel.descriptionField)
            }
        }
    }
    
    func getNetWorkData(type:String){
        page = page + 1
        let parameters = ["page":page.string, "limit":LIMITNUMBER, "type":type] as [String : Any]
        BaseNetWorke.getSharedInstance().getUrlWithString(ArticleListUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if self.page != 1 {
                    self.articleListArray.addObjects(from: NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array) as! [Any])
                }else{
                    self.articleListArray = NSMutableArray.init(array: (resultDic.value as! NSDictionary).object(forKey: "records") as! Array)
                }
                self.reloadTableViewData()
                self.hiddenMJLoadMoreData(resultData: resultDic.value ?? [])
            }
        }
    }
}


extension ArticleDetailViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return self.contentHeight + 100
        case 1:
            return 32
        default:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 300
        case 1:
            return 32
        default:
            return 100
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension ArticleDetailViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0,1:
            return articleModel == nil ? 0 : 1
        default:
            return self.contentHeight == 0 ? 0 : articleListArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ArticleDetailContentTableViewCell.description(), for: indexPath)
            self.tableViewArticleDetailContentTableViewCellSetData(indexPath, cell: cell as! ArticleDetailContentTableViewCell)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: HotDetailTableViewCell.description(), for: indexPath)
            self.tableViewHotDetailTableViewCellSetData(indexPath, cell: cell as! HotDetailTableViewCell)
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: SquareTableViewCell.description(), for: indexPath)
            self.tableViewSquareTableViewCellSetData(indexPath, cell: cell as! SquareTableViewCell)
            cell.selectionStyle = .none
            return cell
        }
        
    }
}

extension ArticleDetailViewModel : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
}



