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
    var contentSize:CGSize!
    var webView:WKWebView!
    
    var contentHeight:CGFloat = 0
    
    override init() {
        super.init()
    }
    
    
    func tableViewArticleDetailContentTableViewCellSetData(_ indexPath:IndexPath, cell:ArticleDetailContentTableViewCell) {
        if articleModel != nil {
            cell.cellSetData(model: articleModel)
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
        //        let dicData = NSDictionary.init(dictionary: ["contentStrs":contentStrs[indexPath.section],"translateStrs":translateStrs[indexPath.section],"images":images[indexPath.section]], copyItems: true)
        //        (self.controller! as! OutFallViewController).postDetailDataClouse(dicData,.OutFall)
    }
    
    func calculateWebHeight(html:String) {
        var htmlString = html
        if htmlString.contains("<img") {
            htmlString = htmlString.replacingOccurrences(of: "<img", with: "<img style='max-width: 100%; vertical-align:middle;'")
        }
        // 注意：这里webView高度不能为0，如果设置为0webView在加载完成后使用sizeToFit()得不到真实高度
        webView = WKWebView.init(frame: CGRect.init(x: 10, y: 0, width: SCREENWIDTH - 20, height: 1))
        webView.navigationDelegate = self
        webView.sizeToFit()
        webView.backgroundColor = UIColor.clear
        webView.isOpaque = false
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.isUserInteractionEnabled = false
        webView.loadHTMLString(htmlString, baseURL: nil)
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
            return contentHeight
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
            return articleListArray.count
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
        webView.sizeToFit()
        self.webView.evaluateJavaScript("document.body.scrollHeight") { (dic, error) in
            print(dic)
            let titleSize = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_18_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: self.articleModel.title, yyLabel: YYLabel.init())
            self.contentHeight = (dic as! Int).cgFloat + titleSize.textBoundingSize.height
            self.reloadTableViewData()
        }
        
    }
}



