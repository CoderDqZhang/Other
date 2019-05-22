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
    var textView111:YYTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userInfo = CacheManager.getSharedInstance().getUserInfo()
        
        if #available(iOS 11.0, *) {
            gloableCommentView = CustomViewCommentTextField.init(frame: CGRect.init(x: 0, y:SCREENHEIGHT - 64 - 44 - 49 - 60, width: SCREENWIDTH, height: 44 + TABBAR_HEIGHT), placeholderString: "留下你的精彩评论...",isEdit:false, click: {
                NavigationPushView(self, toConroller: LoginViewController())
//                NavigaiontPresentView(self, toController: TargerUserViewController())
                
            }, senderClick: { str in
                print(str)
            })
        } else {
            gloableCommentView = CustomViewCommentTextField.init(frame: CGRect.init(x: 0, y: self.tableView.frame.maxY, width: SCREENWIDTH, height: 44), placeholderString: "留下你的精彩评论...",isEdit:false, click: {
                NavigationPushView(self, toConroller: TargerUserViewController())
            }, senderClick: { str in
                print(str)
            })
            // Fallback on earlier versions
        }
        gloableCommentView.backgroundColor = .white
        gloableCommentView.textView.isEditable = true
        self.view.addSubview(gloableCommentView)
        
        
        let textView = UITextView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 100))
        
        textView.font = App_Theme_PinFan_M_15_Font
        textView.backgroundColor = .red
        textView.textColor = App_Theme_06070D_Color
        //        textView.placeholderTextColor = App_Theme_B5B5B5_Color!
        //        textView.placeholderFont = App_Theme_PinFan_M_15_Font!
        self.view.addSubview(textView)
//
//        textView111 = YYTextView.init()
////        init(frame: CGRect.init(x: 0, y: 207, width: SCREENWIDTH , height: 30))
//        textView111.borderColor = App_Theme_B4B4B4_Color
//        textView111.delegate = self
//        textView111.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
//        textView111.isScrollEnabled = false
//        textView111.font = App_Theme_PinFan_R_14_Font
//        textView111.placeholderFont = App_Theme_PinFan_R_14_Font
//        textView111.placeholderTextColor = App_Theme_BBBBBB_Color
//        textView111.textColor = App_Theme_666666_Color
//        textView111.placeholderText = "placeholderString"
//        textView111.cornerRadius = 4
//        textView111.borderWidth = 1
//        textView111.backgroundColor = .red
//        self.view.addSubview(textView111)
//        textView111.snp.makeConstraints { (make) in
//            make.top.equalTo(self.view.snp.top).offset(100)
//            make.left.equalToSuperview()
//            make.right.equalToSuperview()
//            make.height.equalTo(40)
//        }
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

extension ScoreViewController : YYTextViewDelegate {
    func textViewDidEndEditing(_ textView: YYTextView) {
        textView.resignFirstResponder()
    }
    
     func textViewDidBeginEditing(_ textView: YYTextView) {
        textView.becomeFirstResponder()
    }
    
    func textView(_ textView: YYTextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func textViewDidChange(_ textView: YYTextView) {
        let fltTextHeight = textView.textLayout!.textBoundingSize.height;
        textView.isScrollEnabled = false //必须设置为NO
        
        //这里动画的作用是抵消，YYTextView 内部动画 防止视觉上的跳动。
        UIView.animate(withDuration: 0.25, animations: {
            textView.height = fltTextHeight
        }) { (finished) in
            
        }
    }
}
