//
//  StoreInfoViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import MJRefresh

class StoreInfoViewController: BaseViewController {

    var storeInfoViewModel = StoreInfoViewModel.init()
    var collectionView:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "积分商城"
        self.setNavigationItemBack()
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: storeInfoViewModel, controller: self)
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: (SCREENWIDTH - 45) / 2, height: ((SCREENWIDTH - 45) / 2) * 180 / 165)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 7
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 15, left: 15, bottom: 7, right: 15)
        if #available(iOS 11.0, *) {
            collectionView = UICollectionView.init(frame: CGRect(x:0, y:0, width:SCREENWIDTH, height:SCREENHEIGHT - NAV_HEIGHT - 49), collectionViewLayout: layout)
        } else {
            collectionView = UICollectionView.init(frame: CGRect(x:0, y:0, width:SCREENWIDTH, height:SCREENHEIGHT - 49), collectionViewLayout: layout)
            // Fallback on earlier versions
        }
        
        collectionView?.backgroundColor = App_Theme_F6F6F6_Color
        collectionView.register(StoreInfoCollectionViewCell.self, forCellWithReuseIdentifier: StoreInfoCollectionViewCell.description())
        collectionView?.delegate = storeInfoViewModel
        collectionView?.dataSource = storeInfoViewModel
        self.view.addSubview(collectionView!)
        
        self.collectionView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.storeInfoViewModel.page = 0
            self.storeInfoViewModel.getStoreList()
        })
        
        self.setUpLoadMoreDataClouse = {
            self.collectionView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
                self.storeInfoViewModel.page = self.storeInfoViewModel.page + 1
                self.storeInfoViewModel.getStoreList()
            })
        }
        self.storeInfoViewModel.getStoreList()
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
