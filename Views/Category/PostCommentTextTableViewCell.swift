//
//  PostCommentTextTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/14.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

let MaxTextViewCount = 250
class PostCommentTextTableViewCell: UITableViewCell {

    var textView:YYTextView!
    var textCountLabel:YYLabel!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        textView = YYTextView.init()
        textView.delegate = self
        textView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        textView.isScrollEnabled = false
        textView.font = App_Theme_PinFan_R_14_Font
        textView.placeholderFont = App_Theme_PinFan_M_14_Font
        textView.placeholderTextColor = App_Theme_999999_Color
        textView.textColor = App_Theme_06070D_Color
        textView.placeholderText = "在这里发表你的想法..."
        textView.keyboardType = .default
        textView.returnKeyType = .send
        self.contentView.addSubview(textView)
        
        textCountLabel = YYLabel.init()
        textCountLabel.font = App_Theme_PinFan_M_14_Font
        textCountLabel.textColor = App_Theme_999999_Color
        textCountLabel.text = "0/250"
        self.contentView.addSubview(textCountLabel)
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            textView.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView.snp.top).offset(15)
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
            }
            textCountLabel.snp.makeConstraints { (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-12)
            }
            didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    func senderClick(){
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension PostCommentTextTableViewCell : YYTextViewDelegate {
    func textView(_ textView: YYTextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n")
        {
            self.senderClick()
            textView.text = ""
            return false
        }
        if (textView.text.count > MaxTextViewCount) {
            textView.text = textView.text.nsString.substring(to: MaxTextViewCount)
        }
        return true
    }
    
    func textViewDidChange(_ textView: YYTextView) {
        textCountLabel.text = "\(textView.text.count)/250"
        if (textView.text.count > MaxTextViewCount) {
            textView.text = textView.text.nsString.substring(to: MaxTextViewCount)
        }
        self.updateConstraintsIfNeeded()
    }
    
    func textViewDidBeginEditing(_ textView: YYTextView) {
//        let fltTextHeight = textView.textLayout!.textBoundingSize.height;
//        textView.isScrollEnabled = false //必须设置为NO
//        textViewOriginFrame = textView.frame
//        //这里动画的作用是抵消，YYTextView 内部动画 防止视觉上的跳动。
//        UIView.animate(withDuration: 0.25, animations: {
//            textView.height = fltTextHeight
//        }) { (finished) in
//
//        }
//        self.height = textView.frame.size.height + 14
//        textView.snp.remakeConstraints { (make) in
//            make.top.equalTo(self.snp.top).offset(7)
//            make.left.equalTo(self.snp.left).offset(15)
//            make.right.equalTo(self.snp.right).offset(-15)
//            make.bottom.equalTo(self.snp.bottom).offset(-7)
//        }
//        keybordFrame = self.frame
    }
    
    func textViewDidEndEditing(_ textView: YYTextView) {
//        textView.snp.remakeConstraints { (make) in
//            make.top.equalTo(self.snp.top).offset(7)
//            make.left.equalTo(self.snp.left).offset(15)
//            make.right.equalTo(self.snp.right).offset(-15)
//            make.height.equalTo(30)
//        }
//        self.frame = originFrame
    }
    
}

