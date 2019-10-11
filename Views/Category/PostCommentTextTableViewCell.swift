//
//  PostCommentTextTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/14.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

let MaxTextViewCount = 250
typealias PostCommentTextTableViewCellTextClouse = (_ str:String) ->Void
typealias PostCommentTextTableViewCellClick = () ->Void
typealias PostCommentTextTableViewCellDeleteTage = (_ str:String) ->Void
class PostCommentTextTableViewCell: UITableViewCell {

    var textView:YYTextView!
    var textCountLabel:YYLabel!
    var textToolbar = KeyboardToobar.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 50))
    var postCommentTextTableViewCellTextClouse:PostCommentTextTableViewCellTextClouse!
    var keyboardToobarClouse:KeyboardToobarClouse!
    var didMakeConstraints = false
    var postCommentTextTableViewCellClick:PostCommentTextTableViewCellClick!
    var postCommentTextTableViewCellDeleteTage:PostCommentTextTableViewCellDeleteTage!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
        self.setUpView()
    }
    
    func setUpView(){
        
        let item = IQBarButtonItemConfiguration.init(image: UIImage.init(named: "@")!, action: #selector(self.leftClick))
        textView = YYTextView.init()
        let toolbar = IQToolbar.init()
        toolbar.items = [UIBarButtonItem.init(image: UIImage.init(named: "@")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(leftClick))]
        textView.inputAccessoryView = toolbar
        textView.inputAccessoryView?.addKeyboardToolbarWithTarget(target: self, titleText: nil, rightBarButtonConfiguration: nil, previousBarButtonConfiguration: item, nextBarButtonConfiguration: nil)
        textView.delegate = self
        textView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        textView.isScrollEnabled = false
        textView.textParser = YYTextBindManager.init()
        textView.font = App_Theme_PinFan_M_15_Font
        textView.placeholderTextColor = App_Theme_B5B5B5_Color!
        textView.placeholderFont = App_Theme_PinFan_R_14_Font!
        textView.textColor = App_Theme_06070D_Color
        textView.placeholderText = "在这里发表你的想法..."
        textView.keyboardType = .default
        textView.returnKeyType = .send
        textToolbar.keyboardToobarClouse = { type in
            if self.keyboardToobarClouse != nil {
                self.keyboardToobarClouse(type)
            }
        }
        self.contentView.addSubview(textView)
        
        textCountLabel = YYLabel.init()
        textCountLabel.font = App_Theme_PinFan_M_14_Font
        textCountLabel.textColor = App_Theme_999999_Color
        textCountLabel.text = "0/250"
        self.contentView.addSubview(textCountLabel)
        self.updateConstraints()
    }
    
    @objc func leftClick(){
        if postCommentTextTableViewCellClick != nil {
            self.postCommentTextTableViewCellClick()
        }
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
        
        if textView.text.count > MaxTextViewCount {
            textView.text = textView.text.nsString.substring(to: MaxTextViewCount)
            return true
        }
        if self.postCommentTextTableViewCellTextClouse != nil {
            var temp_rang = range
            //删除Tag而
            if range.length > 1 && range.location != 0 {
                let nickname = textView.text.nsString.substring(with: temp_rang)
                if postCommentTextTableViewCellDeleteTage != nil {
                    self.postCommentTextTableViewCellDeleteTage(nickname)
                }
            }
            if range.length > MaxTextViewCount {
                temp_rang = NSRange.init(location: 0, length: MaxTextViewCount)
            }
            let str = "\(String(describing: textView.text.nsString.replacingCharacters(in: temp_rang, with: "")))\(text)"
            self.postCommentTextTableViewCellTextClouse(str)
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
    
    func textViewDidEndEditing(_ textView: YYTextView) {
        
    }
    
}

