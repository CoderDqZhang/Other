//
//  CategoryDetailViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class CategoryDetailViewController: BaseViewController {

    var categoryData:NSDictionary!
    var categoryType:CategoryType!
    
    var gloableNavigationBar:GLoabelNavigaitonBar!
    var categoryViewModel = CategoryDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        if #available(iOS 11.0, *) {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: -NAV_HEIGHT/2, width: SCREENWIDTH, height: 64 + NAV_HEIGHT), title: categoryData.object(forKey: "tribeName") as! String, rightButton: nil, click: { (type) in
                if type == .backBtn {
                    self.navigationController?.popViewController()
                }
            })
        } else {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 64), title: categoryData.object(forKey: "tribeName") as! String, rightButton: nil, click: { (type) in
                if type == .backBtn {
                    self.navigationController?.popViewController()
                }
            })
            // Fallback on earlier versions
        }
        self.view.addSubview(gloableNavigationBar)
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: categoryViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [CategoryContentTableViewCell.self,CommentTableViewCell.self,CategoryHeaderTableViewCell.self,UserInfoTableViewCell.self], controller: self)
        self.updateTableViewConstraints()
        
        self.setUpLoadMoreDataClouse = {
            self.setUpLoadMoreData {
                self.categoryViewModel.getCategoryNet()
            }
        }
    }
    
    override func bindViewModelLogic() {
        self.categoryViewModel.categoryData = CategoryModel.init(fromDictionary: self.categoryData as! [String : Any])
        self.categoryViewModel.getCategoryNet()
    }
    
    func updateTableViewConstraints() {
        self.tableView.snp.updateConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.snp.top).offset(-NAV_HEIGHT/2)
            } else {
                make.top.equalTo(self.view.snp.top).offset(0)
                // Fallback on earlier versions
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.setUpCategoryPostView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.removeCategoryPostView()
    }
    
    func removeCategoryPostView(){
        KWindow.viewWithTag(10000)?.removeFromSuperview()
    }
    
    
    func setUpCategoryPostView(){
        let categoryPostView = AnimationButton.init(type: .custom)
        categoryPostView.tag = 10000
        categoryPostView.setImage(UIImage.init(named: "category_post"), for: .normal)
        categoryPostView.reactive.controlEvents(.touchUpInside).observeValues { (button) in
            let categoryVC = PostViewController()
            categoryVC.bindCategoryModel(tribe: CategoryModel.init(fromDictionary: self.categoryData as! [String : Any]))
            NavigaiontPresentView(self, toController: UINavigationController.init(rootViewController: categoryVC))
        }
        KWindow.addSubview(categoryPostView)
        
        categoryPostView.snp.makeConstraints { (make) in
            make.right.equalTo(KWindow.snp.right).offset(-15)
            make.bottom.equalTo(KWindow.snp.bottom).offset(-86)
            make.size.equalTo(CGSize.init(width: 44, height: 44))
        }
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
