//
//  MainTabBarController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class MainTabBarController: UITabBarController {

    let scoreVC = ScoreViewController()
    let segmentVC = SegmentViewController()
    let squareVC = SquareViewController()
    let mineVC = MineViewController()
    var mineNavigaitonVC : UINavigationController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let str = "api_v=v1&c_time=1541709593&imei=359355041886388&os=1&os_v=12"
        let lock = NSString.aes128Encrypt(str, key:"6Z*d02wRE43IRNJ^")
        print(lock)
        
        let scoreNavigaitonVC = UINavigationController.init(rootViewController: scoreVC)
        self.setNavigationVC(vc: scoreNavigaitonVC, itemTitle: nil, normalImage: UIImage.init(named: "比分")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectImage: UIImage.init(named: "比分_select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), toobarTitle: "比分")
        let categoryNavigaitonVC = UINavigationController.init(rootViewController: segmentVC)
        self.setNavigationVC(vc: categoryNavigaitonVC, itemTitle: nil, normalImage: UIImage.init(named: "部落")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectImage: UIImage.init(named: "部落_select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), toobarTitle: "部落")
        let squareNavigaitonVC = UINavigationController.init(rootViewController: squareVC)
        self.setNavigationVC(vc: squareNavigaitonVC, itemTitle: nil, normalImage: UIImage.init(named: "广场")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectImage: UIImage.init(named: "广场_select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), toobarTitle: "广场")
        
        mineNavigaitonVC = UINavigationController.init(rootViewController: mineVC)
        self.setNavigationVC(vc: mineNavigaitonVC, itemTitle: nil, normalImage: UIImage.init(named: "我的")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectImage: UIImage.init(named: "我的_select")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), toobarTitle: "我的")
        

        
        mineNavigaitonVC.navigationBar.isHidden = true
        self.viewControllers = [scoreNavigaitonVC,categoryNavigaitonVC,squareNavigaitonVC,mineNavigaitonVC]
        
        AuthorityManager.setUpAuthorityManager(controller: scoreVC)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
