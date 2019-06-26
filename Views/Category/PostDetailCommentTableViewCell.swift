//
//  PostDetailCommentTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import SKPhotoBrowser

let commentImageWidth:CGFloat = (SCREENWIDTH - 60 - 8 * 2) / 3
let commentImageHeight:CGFloat = commentImageWidth
let SecondeContentHeight:CGFloat = 18
let SecondeContentWidth:CGFloat = SCREENWIDTH - 66

class PostDetailCommentTableViewCell: UITableViewCell {

    var contentLabel:YYLabel!
    var imageContentView:UIView!
    var secondeContent:UIView!
    
    var allCommentLabel:YYLabel!
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: SCREENWIDTH, height: 1)))
    var didMakeConstraints = false
    
    var postDetailContentTableViewCellImageClickClouse:PostDetailContentTableViewCellImageClickClouse!

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
        
        secondeContent = UIView.init()
        secondeContent.backgroundColor = App_Theme_F6F6F6_Color
        self.contentView.addSubview(secondeContent)
        
        
        imageContentView = UIView.init()
        self.contentView.addSubview(imageContentView)
        
        allCommentLabel = YYLabel.init()
        allCommentLabel.text = "查看全部11条回复"
        allCommentLabel.textColor = App_Theme_666666_Color
        allCommentLabel.font = App_Theme_PinFan_M_10_Font
        secondeContent.addSubview(allCommentLabel)
        
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(45)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.top.equalTo(self.contentView.snp.top).offset(0)
        }
        
        imageContentView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(44)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.top.equalTo(self.contentLabel.snp.bottom).offset(8)
            make.height.equalTo(contentImageHeight)
        }
        
        secondeContent.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(44)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.top.equalTo(self.imageContentView.snp.bottom).offset(8)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-17)
        }
        
        allCommentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(secondeContent.snp.left).offset(0)
            make.right.equalTo(secondeContent.snp.right).offset(0)
            make.bottom.equalTo(secondeContent.snp.bottom).offset(-9)
        }
        
        imageContentView.isHidden = true
        secondeContent.isHidden = true
        allCommentLabel.isHidden = true
        
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraints()
    }
    
    func cellSetData(model:CommentModel, isCommentDetail:Bool, isShowRepli:Bool){
        
        _ = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_14_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: model.content, yyLabel: contentLabel)
        
        let images:[String] = model.img.nsString.components(separatedBy: ",")
        self.setImageContentView(images,isCommentDetail)
        
        if isShowRepli {
            self.setSecondeCotent(secondeContents: model.replyList)
        }
        
        lineLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-1)
            make.size.equalTo(CGSize.init(width: SCREENWIDTH, height: 1))
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        self.contentView.updateConstraintsIfNeeded()
    }
    
    func cellSetRepliy(model:ReplyList) {
        
        _ = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_14_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: model.content, yyLabel: contentLabel)

        imageContentView.snp.updateConstraints{ (make) in
            make.height.equalTo(0.0001)
        }
        lineLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-1)
            make.size.equalTo(CGSize.init(width: SCREENWIDTH, height: 1))
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        self.contentView.updateConstraintsIfNeeded()
    }
    
    func setSecondeCotent(secondeContents:[ReplyList]){
        allCommentLabel.text = "查看全部\(secondeContents.count)回复"
        secondeContent.removeSubviews()
        secondeContent.addSubview(allCommentLabel)
        allCommentLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(secondeContent.snp.left).offset(0)
            make.right.equalTo(secondeContent.snp.right).offset(0)
            make.bottom.equalTo(secondeContent.snp.bottom).offset(-9)
        }
        allCommentLabel.isHidden = true

        switch secondeContents.count {
        case 0:
            secondeContent.isHidden = true
            secondeContent.snp.updateConstraints{ (make) in
                make.height.equalTo(0.0001)
            }
        case 1:
            secondeContent.isHidden = false
            
            let detailContent = self.createSecondeContentLabel(index: 0, username: secondeContents[0].nickname, content: secondeContents[0].content)
            detailContent.tag = 10000
            secondeContent.addSubview(detailContent)
            secondeContent.snp.updateConstraints{ (make) in
                make.height.equalTo(SecondeContentHeight + 10)
            }
        case 2:
            secondeContent.isHidden = false
            for index in 0...secondeContents.count - 1 {
                let detailContent = self.createSecondeContentLabel(index: index, username: secondeContents[index].nickname, content: secondeContents[index].content)
                detailContent.tag = index + 10000
                secondeContent.addSubview(detailContent)
            }
            secondeContent.snp.updateConstraints{ (make) in
                make.height.equalTo(2 * SecondeContentHeight + 10)
            }
            
        default:
            secondeContent.isHidden = false
            for index in 0...1 {
                let detailContent = self.createSecondeContentLabel(index: index, username: secondeContents[index].nickname, content: secondeContents[index].content)
                detailContent.tag = index + 10000
                secondeContent.addSubview(detailContent)
            }
            secondeContent.snp.updateConstraints{ (make) in
                make.height.equalTo(3 * SecondeContentHeight + 10)
            }
            allCommentLabel.isHidden = false
        }
    }
    
    func setImageContentView(_ images:[String], _ isCommentDetail:Bool){
        if images.count > 1 {
            if isCommentDetail {
                var imageContentHeight:CGFloat = 0
                for index in 0...images.count - 1 {
                    let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
                    imageView.tag = index + 10000
                    UIImageViewManger.sd_imageView(url: images[index], imageView: imageView, placeholderImage: nil) { (image, error, cache, url) in
//                        let view = self.imageContentView.viewWithTag(index + 10000)
                        imageView.frame = CGRect.init(x: 0, y:imageContentHeight, width: SCREENWIDTH - 64, height: (SCREENWIDTH - 64) * (image?.size.height)! / (image?.size.width)!)
                        imageView.backgroundColor = .red
                        if error == nil {
                            imageView.image = image
                        }
                        if index == images.count - 1 {
                            self.imageContentView.snp.updateConstraints{ (make) in
                                make.height.equalTo(imageView.frame.maxY)
                            }
                        }else{
                            imageContentHeight = imageContentHeight + (SCREENWIDTH - 64) * (image?.size.height)! / (image?.size.width)! + 8
                        }
                    }
                    self.imageContentView.addSubview(imageView)
                }
                
            }else{
                var browser:SKPhotoBrowser? = nil
                if images.count > 1 {
                    browser = SKPhotoBrowserManager.getSharedInstance().setUpBrowserWithStrUrl(urls: images, selectPageIndex: 0)
                }
                for index in 0...images.count - 1 {
                    let imageView = UIImageView.init(frame: CGRect.init(x: 0 + CGFloat(index) * (commentImageWidth + 11), y: 0, width: commentImageWidth, height: commentImageHeight))
                    UIImageViewManger.sd_imageView(url: images[index], imageView: imageView, placeholderImage: nil) { (image, error, cache, url) in
                        if error == nil {
                            imageView.image = image
                        }
                    }
                    imageView.tag = index + 1000
                    imageView.isUserInteractionEnabled = true
                    _ = imageView.newTapGesture { (gesture) in
                        gesture.numberOfTapsRequired = 1
                        gesture.numberOfTouchesRequired = 1
                        }.whenTaped(handler: { (tap) in
                            if self.postDetailContentTableViewCellImageClickClouse != nil {
                                if browser != nil {
                                    self.postDetailContentTableViewCellImageClickClouse(tap.view!.tag,browser!)
                                }
                            }
                        })
                    imageView.layer.cornerRadius = 5
                    imageView.layer.masksToBounds = true
                    self.imageContentView.addSubview(imageView)
                }
                imageContentView.snp.updateConstraints{ (make) in
                    make.height.equalTo(commentImageHeight)
                }
            }
            
            imageContentView.isHidden = false
            secondeContent.snp.remakeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(44)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.imageContentView.snp.bottom).offset(8)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-17)
                make.size.height.equalTo(0.001)
            }
        }else{
            imageContentView.isHidden = true
            imageContentView.snp.updateConstraints{ (make) in
                make.height.equalTo(0.0001)
            }
            secondeContent.snp.remakeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(44)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.imageContentView.snp.bottom).offset(8)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-17)
                make.size.height.equalTo(0.001)
            }
        }
    }
    
    func createSecondeContentLabel(index:Int, username:String,content:String) -> UIView{
        let contentView = UIView.init(frame: CGRect.init(x: 0, y: 5 + CGFloat(index) * SecondeContentHeight, width: SecondeContentWidth, height: SecondeContentHeight))
        let userName  = YYLabel.init()
        userName.text = "\(username):"
        userName.textAlignment = .left
        userName.font = App_Theme_PinFan_M_10_Font
        userName.textColor = App_Theme_999999_Color
        contentView.addSubview(userName)
        
        let contentName  = YYLabel.init()
        contentName.text = content
        contentName.textAlignment = .left
        contentName.font = App_Theme_PinFan_M_10_Font
        contentName.textColor = App_Theme_666666_Color
        contentView.addSubview(contentName)
        
        
        userName.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(0)
            make.top.equalTo(contentView.snp.top).offset(0)
            make.bottom.equalTo(contentView.snp.bottom).offset(0)
        }
        
        
        contentName.snp.makeConstraints { (make) in
            make.left.equalTo(userName.snp.right).offset(9)
            make.right.lessThanOrEqualTo(contentView.snp.right).offset(0)
            make.top.equalTo(contentView.snp.top).offset(0)
            make.bottom.equalTo(contentView.snp.bottom).offset(0)
        }
        return contentView
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            
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
