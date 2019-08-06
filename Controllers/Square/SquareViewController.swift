//
//  SquareViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class SquareViewController: BaseViewController {

    var inputContainerView: UIView!
    var inputContainerViewBottom: NSLayoutConstraint!
    var growingTextView: NextGrowingTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        inputContainerView = UIView.init()
        inputContainerView.backgroundColor = .red
        self.view.addSubview(inputContainerView)
        inputContainerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(self.view.snp.bottom).offset(-100)
            make.height.equalTo(50)
        }
        
        self.inputContainerViewBottom = NSLayoutConstraint.init()
        
        self.growingTextView = NextGrowingTextView.init()
        self.growingTextView.textView.textColor = .red
        inputContainerView.addSubview(growingTextView)
        self.growingTextView.snp.makeConstraints { (make) in
            make.left.equalTo(self.inputContainerView.snp.left).offset(8)
            make.right.equalTo(self.inputContainerView.snp.right).offset(-28)
            make.bottom.equalTo(self.inputContainerView.snp.bottom).offset(-6)
            make.top.equalTo(self.inputContainerView.snp.top).offset(6)
        }
        
        self.growingTextView.layer.cornerRadius = 4
        self.growingTextView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        self.growingTextView.placeholderAttributedText = NSAttributedString(
            string: "Placeholder text",
            attributes: [
                .font: self.growingTextView.textView.font!,
                .foregroundColor: UIColor.gray
            ]
        )
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func handleSendButton(_ sender: AnyObject) {
        self.growingTextView.textView.text = ""
        self.view.endEditing(true)
    }

    @objc func keyboardWillHide(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let _ = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                //key point 0,
                inputContainerView.snp.remakeConstraints { (make) in
                    make.left.equalToSuperview()
                    make.right.equalToSuperview()
                    make.bottom.equalTo(self.view.snp.bottom).offset(-100)
                    make.height.equalTo(50)
                }
                self.inputContainerViewBottom.constant =  0
                //textViewBottomConstraint.constant = keyboardHeight
                UIView.animate(withDuration: 0.25, animations: { () -> Void in self.view.layoutIfNeeded() })
            }
        }
    }
    @objc func keyboardWillShow(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                inputContainerView.snp.remakeConstraints { (make) in
                    make.left.equalToSuperview()
                    make.right.equalToSuperview()
                    make.bottom.equalTo(self.view.snp.bottom).offset(-keyboardHeight)
                    make.height.equalTo(50)
                }
                self.inputContainerViewBottom.constant = keyboardHeight
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
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
