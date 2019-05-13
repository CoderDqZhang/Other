//
//  ScoreViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class ScoreViewController: BaseViewController {

    var gloableCommentView:CustomViewCommentTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            gloableCommentView = CustomViewCommentTextField.init(frame: CGRect.init(x: 0, y:SCREENHEIGHT - 64 - 44 - 49 - 60, width: SCREENWIDTH, height: 44 + TABBAR_HEIGHT), placeholderString: "留下你的精彩评论...", click: {
                let commentPost = UINavigationController.init(rootViewController: CommentPostViewController())
                NavigaiontPresentView(self, toController: commentPost)
            })
        } else {
            gloableCommentView = CustomViewCommentTextField.init(frame: CGRect.init(x: 0, y: self.tableView.frame.maxY, width: SCREENWIDTH, height: 44), placeholderString: "留下你的精彩评论...", click: {
                let commentPost = UINavigationController.init(rootViewController: CommentPostViewController())
                NavigaiontPresentView(self, toController: commentPost)
            })
            // Fallback on earlier versions
        }
        gloableCommentView.backgroundColor = .white
        self.view.addSubview(gloableCommentView)
        // Do any additional setup after loading the view.
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
