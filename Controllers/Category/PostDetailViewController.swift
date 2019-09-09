//
//  PostDetailViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

enum ToatalNumber {
    case comment
    case like
}

enum ToolsStatus {
    case add
    case delete
    case loginadd
    case logincollect
}

enum PostDetaiGoToType {
    case comment
    case detail
}

typealias ChangeFansFollowButtonStatusClouse = (_ status:Bool) ->Void

typealias ChangeAllCommentAndLikeNumberClouse = (_ type:ToatalNumber, _ status:ToolsStatus) ->Void

typealias DeleteArticleClouse = () ->Void


class PostDetailViewController: BaseViewController {

    var postType:PostType!
    var gotoType:PostDetaiGoToType!
    
    var postData:NSDictionary!
    var postDetailViewModel = PostDetailViewModel.init()
    
    var gloableCommentView:CustomViewCommentTextField!
    
    var changeFansFollowButtonStatusClouse:ChangeFansFollowButtonStatusClouse!
    var changeAllCommentAndLikeNumberClouse:ChangeAllCommentAndLikeNumberClouse!
    
    var deleteArticleClouse:DeleteArticleClouse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: postDetailViewModel, controller: self)
        self.postDetailViewModel.postType = self.postType
        self.setUpTableView(style: .grouped, cells: [PostDetailUserInfoTableViewCell.self,PostDetailCommentTableViewCell.self,PostDetailCommentUserTableViewCell.self,PostDetailContentTableViewCell.self,HotDetailTableViewCell.self], controller: self)

        self.updateTableViewConstraints()

        self.setUpLoadMoreDataClouse = {
            self.setUpLoadMoreData {
                self.postDetailViewModel.getComments(id: (self.postData.object(forKey: "id") as! Int).string)
            }
        }
        
        if #available(iOS 11.0, *) {
            gloableCommentView = CustomViewCommentTextField.init(frame: CGRect.init(x: 0, y:SCREENHEIGHT - 44 - TABBAR_HEIGHT, width: SCREENWIDTH, height: 44 + TABBAR_HEIGHT), placeholderString: "留下你的精彩评论...",isEdit:false, click: {
                if CacheManager.getSharedInstance().isLogin() {
                    self.clickComentVC()
                }else{
                    let loginVC = LoginViewController.init()
                    loginVC.loginDoneClouse = {
                        self.clickComentVC()
                    }
                    NavigationPushView(self, toConroller: loginVC)
                }
            }, senderClick: { str in
                
            })
        } else {
            gloableCommentView = CustomViewCommentTextField.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 44, width: SCREENWIDTH, height: 44), placeholderString: "留下你的精彩评论...",isEdit:false, click: {
                if CacheManager.getSharedInstance().isLogin() {
                    self.clickComentVC()
                }else{
                    let loginVC = LoginViewController.init()
                    loginVC.loginDoneClouse = {
                        self.clickComentVC()
                    }
                    NavigationPushView(self, toConroller: loginVC)
                }
            }, senderClick: { str in
                
            })
            
            // Fallback on earlier versions
        }
        self.view.addSubview(gloableCommentView)

        gloableCommentView.textView.isEditable = false
        gloableCommentView.backgroundColor = .white
        gloableCommentView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.height.equalTo(44 + TABBAR_HEIGHT)
            } else {
                make.height.equalTo(44)
                // Fallback on earlier versions
            }
            make.bottom.equalToSuperview()
        }
    }

    //评论文章界面
    func clickComentVC(){
        let commentVC = CommentPostViewController()
        let commentPost = UINavigationController.init(rootViewController: commentVC)
        commentVC.postData = self.postData
        commentVC.commentPostViewControllerDataClouse = { dic in
            self.postDetailViewModel.tipDetailModel.commentTotal = self.postDetailViewModel.tipDetailModel.commentTotal + 1
            self.postDetailViewModel.commentListArray.insert(dic, at: 0)
            self.postDetailViewModel.reloadTableViewData()
            
            if self.changeAllCommentAndLikeNumberClouse != nil {
                self.changeAllCommentAndLikeNumberClouse(.comment, .add)
            }
        }
        NavigaiontPresentView(self, toController: commentPost)
    }
    
    func refreshData(){
        self.postDetailViewModel.page = 0
        self.postDetailViewModel.tipDetailModel.commentTotal = self.postDetailViewModel.tipDetailModel.commentTotal + 1
        self.postDetailViewModel.getComments(id: (self.postData.object(forKey: "id") as! Int).string)
    }
    
    func updateTableViewConstraints() {
        self.tableView.snp.updateConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(-44)
        }
    }
    
    override func bindViewModelLogic() {
        self.postDetailViewModel.getTipDetail(id: (self.postData.object(forKey: "id") as! Int).string)
        self.postDetailViewModel.getComments(id: (self.postData.object(forKey: "id") as! Int).string)
        
    }
    
    override func setUpViewNavigationItem() {
        self.setNavigationItemBack()
        let shareItem = UIBarButtonItem.init(image: UIImage.init(named: "post_detail_share")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.rightBarItemClick(_:)))
        var deleteItem:UIBarButtonItem?
        if CacheManager.getSharedInstance().isLogin() {
            if self.postData.object(forKey: "user") != nil {
                if ((self.postData.object(forKey: "user") as! NSDictionary).object(forKey: "id") as! Int).string == CacheManager.getSharedInstance().getUserId() {
                    deleteItem = UIBarButtonItem.init(image: UIImage.init(named: "delete")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.deleteBarItemClick(_:)))
                }else{
                    deleteItem = UIBarButtonItem.init(image: UIImage.init(named: "report")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.reportBarItemClick(_:)))
                }
            }
            if deleteItem != nil {
                self.navigationItem.rightBarButtonItems = ([shareItem,deleteItem] as! [UIBarButtonItem])
            }else{
                self.navigationItem.rightBarButtonItems = [shareItem]
            }
        }else{
            self.navigationItem.rightBarButtonItems = [shareItem]
        }
        
    }
    
    @objc func rightBarItemClick(_ sender:UIBarButtonItem) {
        UMengUI.getSharedInstance().createPlatForm(block: { platform,userInfo in
            switch platform {
            case .dingDing:
                UMengManager.getSharedInstance().sharePlatformImage(type: platform, thumImage: UIImage.init(named: "category_post")!, image_url: "", controller: self, completion: { (ret, error) in
                    
                })
            default:
                UMengManager.getSharedInstance().sharePlatformWeb(type: platform, title: self.postDetailViewModel.tipDetailModel.content, descr: self.postDetailViewModel.tipDetailModel.title, thumImage: UIImage.init(named: "logo1024")!, web_url: "\(ShareUrl)?tipId=\(String(describing: self.postDetailViewModel.tipDetailModel.id!))", controller: self, completion: { (ret, error) in
                    
                })
            }
        })
    }
    
    @objc func deleteBarItemClick(_ sender:UIBarButtonItem) {
        UIAlertController.showAlertControl(self, style: .alert, title: "确定删除该篇文章?", message: nil, cancel: "取消", doneTitle: "确定", cancelAction: {
            
        }, doneAction: {
            self.postDetailViewModel.deleteArticle(tipId:  (self.postData.object(forKey: "id") as! Int).string, model: self.postDetailViewModel.tipDetailModel)
        })
    }
    
    @objc func reportBarItemClick(_ sender:UIBarButtonItem) {
        UIAlertController.showAlertControl(self, style: .alert, title: "确定举报该篇文章?", message: nil, cancel: "取消", doneTitle: "确定", cancelAction: {
            
        }, doneAction: {
            self.postDetailViewModel.reportAritcleNet(tipId:  (self.postData.object(forKey: "id") as! Int).string, model: self.postDetailViewModel.tipDetailModel)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
