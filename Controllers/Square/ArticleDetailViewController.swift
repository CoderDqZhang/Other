//
//  ArticleDetailViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class ArticleDetailViewController: BaseViewController {

    var articleData:NSDictionary!
    var articleDetailViewModel = ArticleDetailViewModel.init()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpView() {
        
        self.bindViewModel(viewModel: articleDetailViewModel, controller: self)
        self.setUpTableView(style: UITableView.Style.grouped, cells: [ArticleDetailContentTableViewCell.self, HotDetailTableViewCell.self, SquareTableViewCell.self], controller: self)
    }
    
    override func bindViewModelLogic() {
        self.articleDetailViewModel.articleId = (self.articleData.object(forKey: "id") as! Int).string
        self.articleDetailViewModel.getArticleNet()
    }
    
    override func setUpViewNavigationItem() {
        self.setNavigationItemBack()
        self.navigationItem.title = (articleData.object(forKey: "title") as! String)
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
