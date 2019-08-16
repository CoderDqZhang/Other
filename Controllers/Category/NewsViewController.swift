//
//  NewsViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import MJRefresh

class NewsViewController: BaseViewController {

    
    var categoryDetailClouse:CategoryDetailDataClouse!
    
    let newsViewModel = NewsViewModel.init()
    var newsPostView:AnimationButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: newsViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [CategoryTableViewCell.self,CategoryContentTableViewCell.self,HotDetailTableViewCell.self,CommentTableViewCell.self,UserInfoTableViewCell.self], controller: self)
        
        self.setUpNewsPostView()
        self.setUpRefreshData {
            self.newsViewModel.page = 0
            self.newsViewModel.getCategoryNet()
            self.newsViewModel.getTribeListNet()
        }
        
        self.setUpLoadMoreData {
            self.newsViewModel.getTribeListNet()
        }
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "最新"
    }
    
    func setUpNewsPostView(){
        if newsPostView == nil {
            newsPostView = AnimationButton.init(type: .custom)
            newsPostView.tag = 10000
            newsPostView.setImage(UIImage.init(named: "new_add"), for: .normal)
            newsPostView.reactive.controlEvents(.touchUpInside).observeValues { (button) in
                if CacheManager.getSharedInstance().isLogin() {
                    let postVC = PostViewController()
                    postVC.postViewControllerDataClouse = { dic in
                        self.newsViewModel.tipListArray.insert(dic, at: 0)
                        self.newsViewModel.reloadTableViewData()
                    }
                    let postNavigationController = UINavigationController.init(rootViewController: postVC)
                    NavigaiontPresentView(self, toController: postNavigationController)
                }else{
                    NavigationPushView(self, toConroller: LoginViewController())
                }
            }
            KWindow.addSubview(newsPostView)
            newsPostView.isHidden = false
            newsPostView.snp.makeConstraints { (make) in
                make.right.equalTo(KWindow.snp.right).offset(-15)
                make.bottom.equalTo(KWindow.snp.bottom).offset(-86)
                make.size.equalTo(CGSize.init(width: 44, height: 44))
            }
        }else{
            newsPostView.isHidden = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpNewsPostView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.removeNewsPostView()
    }
    
    func removeNewsPostView(){
        newsPostView.isHidden = true
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
