//
//  MyCommentTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/28.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class MyCommentTableViewCell: UITableViewCell {

    var commentTitle:YYLabel!
    var tipContent:YYLabel!
    var deleteLabel:YYLabel!
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 15, y: 0, width: SCREENWIDTH - 30, height: 1))

    var imageContentView:UIView!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        
        commentTitle = YYLabel.init()
        commentTitle.numberOfLines = 0
        commentTitle.textColor = App_Theme_666666_Color
        commentTitle.font = App_Theme_PinFan_M_14_Font
        
        self.contentView.addSubview(commentTitle)
        
        deleteLabel = YYLabel.init()
        deleteLabel.numberOfLines = 0
        deleteLabel.textColor = App_Theme_666666_Color
        deleteLabel.font = App_Theme_PinFan_M_12_Font
        
        self.contentView.addSubview(deleteLabel)
        
        tipContent = YYLabel.init()
        tipContent.numberOfLines = 0
        tipContent.textColor = App_Theme_06070D_Color
        tipContent.font = App_Theme_PinFan_M_15_Font
        
        self.contentView.addSubview(tipContent)
        
        imageContentView = UIView.init()
        self.contentView.addSubview(imageContentView)
        
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func cellSetData(model:CommentModel) {
        deleteLabel.isHidden = true
        let str = "回复\(String(describing: model.tipDetail.user.nickname!))的帖子"
        _ = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_14_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: str, yyLabel: commentTitle)
        commentTitle.textColor = App_Theme_666666_Color
        
        _ = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_15_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: model.tipDetail.content, yyLabel: tipContent)
        
        let images = model.tipDetail.image.split(separator: ",")
        
        if images.count >= 1 {
            for index in 0...images.count - 1 {
                let imageView = UIImageView.init(frame: CGRect.init(x: 0 + CGFloat(index) * (contentImageWidth + 11), y: 0, width: contentImageWidth, height: contentImageHeight))
                imageView.sd_crope_imageView(url: String(images[index]).nsString.replacingOccurrences(of: " ", with: ""), imageView: imageView, placeholderImage: nil) { (image, url, type, state, error) in
                    
                }
                imageView.tag = index + 1000
                imageView.layer.cornerRadius = 5
                imageView.layer.masksToBounds = true
                self.imageContentView.addSubview(imageView)
            }
            imageContentView.isHidden = false
            imageContentView.snp.updateConstraints{ (make) in
                make.height.equalTo(contentImageHeight)
            }
        }else{
            imageContentView.isHidden = true
            imageContentView.snp.updateConstraints{ (make) in
                make.height.equalTo(0.0001)
            }
        }
        self.contentView.updateConstraintsIfNeeded()
    }
    
    func deleteCellData(model:CommentModel) {
        var str = ""
        if model.tipDetail.status == "1" {
            deleteLabel.isHidden = true
            str = "回复\(String(describing: model.tipDetail.user.nickname!))的帖子 -该帖已删除"
            let attribute = NSMutableAttributedString.init(string: str)
            attribute.addAttributes([NSAttributedString.Key.foregroundColor : App_Theme_666666_Color!], range: NSRange.init(location: 0, length: str.count - 7))
            attribute.addAttributes([NSAttributedString.Key.foregroundColor : App_Theme_FB5D5D_Color!], range: NSRange.init(location: str.count - 7, length: 7))
            _ = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextAttributedBound(font: App_Theme_PinFan_M_14_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: attribute, yyLabel: commentTitle)
            commentTitle.attributedText = attribute
        }else{
            deleteLabel.isHidden = false
            str = "回复\(String(describing: model.tipDetail.user.nickname!))的帖子"
            _ = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_14_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: str, yyLabel: commentTitle)
            commentTitle.textColor = App_Theme_666666_Color
            
            
            _ = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_12_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: "-该帖因不符合平台管理规定，已被管理员删除。", yyLabel: deleteLabel)
            self.contentView.addSubview(deleteLabel)
            deleteLabel.textColor = App_Theme_FB5D5D_Color
            
        }
        
        _ = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_15_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: model.tipDetail.content, yyLabel: tipContent)
        
        let images = model.tipDetail.image.split(separator: ",")
        
        if images.count >= 1 {
            for index in 0...images.count - 1 {
                let imageView = UIImageView.init(frame: CGRect.init(x: 0 + CGFloat(index) * (contentImageWidth + 11), y: 0, width: contentImageWidth, height: contentImageHeight))
                imageView.sd_crope_imageView(url: String(images[index]).nsString.replacingOccurrences(of: " ", with: ""), imageView: imageView, placeholderImage: nil) { (image, url, type, state, error) in
                    
                }
                imageView.tag = index + 1000
                imageView.layer.cornerRadius = 5
                imageView.layer.masksToBounds = true
                self.imageContentView.addSubview(imageView)
            }
            imageContentView.isHidden = false
            if model.tipDetail.status == "1" {
                imageContentView.snp.updateConstraints{ (make) in
                    make.height.equalTo(contentImageHeight)
                }
            }else{
                imageContentView.snp.updateConstraints{ (make) in
                    make.height.equalTo(contentImageHeight + 20)
                }
            }
            
            deleteLabel.snp.makeConstraints { (make) in
                make.top.equalTo(imageContentView.snp.bottom).offset(6)
                make.left.equalTo(commentTitle.snp.left).offset(0)
            }
            
        }else{
            imageContentView.isHidden = true
            if model.tipDetail.status == "1" {
                imageContentView.snp.updateConstraints{ (make) in
                    make.height.equalTo(0.0001)
                }
            }else{
                imageContentView.snp.updateConstraints{ (make) in
                    make.height.equalTo(20)
                }
            }
            
            deleteLabel.snp.makeConstraints { (make) in
                make.top.equalTo(tipContent.snp.bottom).offset(6)
                make.left.equalTo(tipContent.snp.left).offset(0)
            }
            
        }
        self.contentView.updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        if !didMakeConstraints {
            commentTitle.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.contentView.snp.top).offset(15)
                make.height.equalTo(0.0001)
            }
            
            tipContent.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.commentTitle.snp.bottom).offset(9)
                make.height.equalTo(0.0001)
            }
            
            imageContentView.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.tipContent.snp.bottom).offset(8)
                make.height.equalTo(0.0001)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-12)
            }
            
            
            lineLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-1)
                make.height.equalTo(1)
            }
            
            deleteLabel.snp.makeConstraints { (make) in
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
