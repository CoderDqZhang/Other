//
//  ReplyContentTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/27.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class ReplyContentTableViewCell: UITableViewCell {

    var contentLabel:YYLabel!
    var imageContentView:UIView!
    var secondeContent:UIView!
    
    var allCommentLabel:YYLabel!
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: SCREENWIDTH, height: 1)))
    var didMakeConstraints = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        contentLabel = YYLabel.init()
        contentLabel.numberOfLines = 3
        contentLabel.text = "鲁尼也是一代红魔传说"
        contentLabel.textAlignment = .left
        contentLabel.font = App_Theme_PinFan_M_14_Font
        contentLabel.textColor = App_Theme_06070D_Color
        self.contentView.addSubview(contentLabel)
        
        
        
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraints()
    }
    
    
    func cellSetRepliy(model:ReplyList, isReplyComment:Bool) {
        
        if isReplyComment {
            _ = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_14_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: model.content!, yyLabel: contentLabel)
        }else{
            let str = "回复\(String(describing: model.toNickname!)):\(model.content!)"
            let attributedStr = NSMutableAttributedString.init(string: str)
            attributedStr.addAttribute(NSAttributedString.Key.font, value: App_Theme_PinFan_M_14_Font!, range: NSRange.init(location: 0, length: str.count))
            attributedStr.addAttributes([NSAttributedString.Key.foregroundColor : App_Theme_06070D_Color!], range: NSRange.init(location: 0, length: 2))
            attributedStr.addAttributes([NSAttributedString.Key.foregroundColor : App_Theme_FFAC1B_Color!], range: NSRange.init(location: 2, length: String(describing: model.toNickname!).count))
            attributedStr.addAttributes([NSAttributedString.Key.foregroundColor : App_Theme_06070D_Color!], range: NSRange.init(location: String(describing: model.toNickname!).count + 2, length: str.count - String(describing: model.toNickname!).count - 2))
            _ = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextAttributedBound(font: App_Theme_PinFan_M_14_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: attributedStr, yyLabel: contentLabel)
        }
        
        lineLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-1)
            make.size.equalTo(CGSize.init(width: SCREENWIDTH, height: 1))
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        self.contentView.updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            contentLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(45)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.height.equalTo(0.0001)
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
