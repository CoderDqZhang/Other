//
//  CommentPostViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/13.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class CommentPostViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(self.leftButtonClick(_:)))
        self.navigationItem.title = "发表评论"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "发表", style: .plain, target: self, action: #selector(self.rightButtonClick(_:)))
    }

    
    @objc func leftButtonClick(_ sender:UIBarButtonItem) {
        
    }
    
    @objc func rightButtonClick(_ sender:UIBarButtonItem) {
        
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
