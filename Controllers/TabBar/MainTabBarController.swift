//
//  MainTabBarController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    let scoreVC = ScoreSegementViewController()
    let newVC = NewsViewController()
    let segmentVC = SegmentViewController()
    let mineVC = MineViewController()
    var mineNavigaitonVC : UINavigationController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scoreNavigaitonVC = UINavigationController.init(rootViewController: scoreVC)
        self.setNavigationVC(vc: scoreNavigaitonVC, itemTitle: nil, normalImage: UIImage.init(named: "比分")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectImage: UIImage.init(named: "比分_select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), toobarTitle: "比分")
        let newNavigaitonVC = UINavigationController.init(rootViewController: newVC)
        self.setNavigationVC(vc: newNavigaitonVC, itemTitle: nil, normalImage: UIImage.init(named: "部落")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectImage: UIImage.init(named: "部落_select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), toobarTitle: "部落")
        let squareNavigaitonVC = UINavigationController.init(rootViewController: segmentVC)
        self.setNavigationVC(vc: squareNavigaitonVC, itemTitle: nil, normalImage: UIImage.init(named: "广场")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectImage: UIImage.init(named: "广场_select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), toobarTitle: "广场")
        
        mineNavigaitonVC = UINavigationController.init(rootViewController: mineVC)
        self.setNavigationVC(vc: mineNavigaitonVC, itemTitle: nil, normalImage: UIImage.init(named: "我的")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectImage: UIImage.init(named: "我的_select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), toobarTitle: "我的")
        
        
        
        mineNavigaitonVC.navigationBar.isHidden = true
        self.viewControllers = [scoreNavigaitonVC,newNavigaitonVC,squareNavigaitonVC,mineNavigaitonVC]
        
        AuthorityManager.setUpAuthorityManager(controller: scoreVC)
        
        
        //推送通知跳转详情
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: NOTIFICATIOINSPUSHCONTROLLER), object: nil, queue: OperationQueue.main) { (userInfo) in
            let model = NotificationModel.init(fromDictionary: userInfo.userInfo as! [String : Any])
            self.pushViewController(model: model)
        }
        
//        SocketManager.getSharedInstance().connect()
        // Do any additional setup after loading the view.
    }
    
    func setNavigationVC(vc:UINavigationController, itemTitle:String?,normalImage:UIImage?,selectImage:UIImage?, toobarTitle:String){
        vc.navigationItem.title = itemTitle
        vc.title = toobarTitle
        vc.tabBarItem =  UITabBarItem.init(title: toobarTitle, image: normalImage, selectedImage: selectImage)
    }
    
    
    func upateUnreadMessage(){
        if CacheManager.getSharedInstance().getUnreadModel() != nil {
            if CacheManager.getSharedInstance().getUnreadModel()!.allunread > 0 {
                mineNavigaitonVC.tabBarController?.tabBar.showBadgeOnItemIndex(index: 4)

            }
        }
    }
    
    func pushViewController(model:NotificationModel){
        if model.forword != nil {
            switch  PushServerType.init(rawValue: model.forword)! {
            case PushServerType.PushInServer:
                let detailModel = TypeModel.init(fromDictionary: model.param.toDictionary() as! [String : Any])
                switch  PushControllerType.init(rawValue: model.type)! {
                case .ArticleDetail:
                    self.tabBarController?.selectedIndex = 1
                    let postDetailVC = PostDetailViewController()
                    postDetailVC.postData = NSDictionary.init(dictionary: ["id":detailModel.id!.int!]) as NSDictionary
                    postDetailVC.postType = .Hot
                    NavigationPushView(MainTabBarController.current()!, toConroller: postDetailVC)
                    break
                case .System:
                    self.tabBarController?.selectedIndex = 4
                    NavigationPushView(MainTabBarController.current()!, toConroller: MessageSegementViewController())
                    break
                case .Scroce:
                    self.tabBarController?.selectedIndex = 0
                default:
                    NavigationPushView(MainTabBarController.current()!, toConroller: MessageSegementViewController())
                    break;
                }
            default:
                let webVC = BaseWebViewController.init()
                NavigationPushView(MainTabBarController.current()!, toConroller: webVC)
                break;
            }
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
