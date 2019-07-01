//
//  PostDetailContentTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import YYText
import SKPhotoBrowser

enum PostDetailContentTableViewCellButtonType {
    case like
    case collect
}
typealias PostDetailContentTableViewCellClouse = (_ type:PostDetailContentTableViewCellButtonType, _ status:ToolsStatus) -> Void
typealias PostDetailContentTableViewCellImageClickClouse = (_ tag:Int, _ photoBrowser:SKPhotoBrowser) ->Void

class PostDetailContentTableViewCell: UITableViewCell {

    var titleLabel:YYLabel!
    var contnetLabel:YYLabel!
    var likeButton:CustomViewButtonTopImageAndBottomLabel!
    var collectButton:CustomViewButtonTopImageAndBottomLabel!
    var likeButtonView:UIView!
    var collectButtonView:UIView!
    var imageContentView:UIView!
    
    var model:TipModel!
    
    var postDetailContentTableViewCellClouse:PostDetailContentTableViewCellClouse!
    var postDetailContentTableViewCellImageClickClouse:PostDetailContentTableViewCellImageClickClouse!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
    
        titleLabel = YYLabel.init()
        titleLabel.numberOfLines = 0
        titleLabel.textColor = App_Theme_2A2F34_Color
        titleLabel.font = App_Theme_PinFan_M_18_Font
        
        self.contentView.addSubview(titleLabel)
        
        contnetLabel = YYLabel.init()
        contnetLabel.numberOfLines = 0
        contnetLabel.textColor = App_Theme_2A2F34_Color
        contnetLabel.font = App_Theme_PinFan_M_15_Font
        
        self.contentView.addSubview(contnetLabel)
        
        imageContentView = UIView.init()
        self.contentView.addSubview(imageContentView)
        
        likeButtonView = UIView.init()
        self.contentView.addSubview(likeButtonView)
        
        collectButtonView = UIView.init()
        self.contentView.addSubview(collectButtonView)
        
        likeButton = CustomViewButtonTopImageAndBottomLabel.init( frame: CGRect.init(x: 0, y: 0, width: 34, height: 64), title: "666", image: UIImage.init(named: "post_detail_like")!, tag: 1, titleColor: App_Theme_B5B5B5_Color!, spacing: 7, font: App_Theme_PinFan_R_12_Font!, click: {
            if self.likeButton.imageView.image == UIImage.init(named: "post_detail_like_select") {
                self.likeButton.imageView.image = UIImage.init(named: "post_detail_like")
                self.likeButton.changeContent(str: (self.likeButton.label.text!.int! - 1).string, image: nil)
                self.postDetailContentTableViewCellClouse(.like, .delete)
            }else{
                self.likeButton.imageView.image = UIImage.init(named: "post_detail_like_select")
                self.likeButton.changeContent(str: (self.likeButton.label.text!.int! + 1).string, image: nil)
                self.postDetailContentTableViewCellClouse(.like, .add)
            }
        })
        
        likeButtonView.addSubview(likeButton)
        
        collectButton = CustomViewButtonTopImageAndBottomLabel.init(frame: CGRect.init(x: UIImage.init(named: "post_detail_like")!.size.width + 25, y: 0, width: 34, height: 74), title: "收藏", image: UIImage.init(named: "post_detail_collect")!, tag: 2, titleColor: App_Theme_B5B5B5_Color!, spacing: 7, font: App_Theme_PinFan_R_12_Font!, click: {
            if self.collectButton.imageView.image == UIImage.init(named: "post_detail_collect_select"){
                self.collectButton.imageView.image = UIImage.init(named: "post_detail_collect")
                self.postDetailContentTableViewCellClouse(.collect, .delete)
            }else{
                self.collectButton.imageView.image = UIImage.init(named: "post_detail_collect_select")
                self.postDetailContentTableViewCellClouse(.collect, .add)
            }
        })
        
        collectButtonView.addSubview(collectButton)
        
        self.updateConstraints()
    }
    
    func cellSetData(model:TipModel){
    
        _ = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_18_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: model.title, yyLabel: titleLabel)

        if model.content != "" {
            _ = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_15_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: model.content, yyLabel: contnetLabel)
        }

        let images = model.image.split(separator: ",")
        var browser:SKPhotoBrowser? = nil
        if images.count >= 1 {
            browser = SKPhotoBrowserManager.getSharedInstance().setUpBrowserWithUrl(urls: images, selectPageIndex: 0)
        }
        if images.count >= 1 {
            for index in 0...images.count - 1 {
                let imageView = UIImageView.init(frame: CGRect.init(x: 0 + CGFloat(index) * (contentImageWidth + 11), y: 0, width: contentImageWidth, height: contentImageHeight))
                imageView.sd_crope_imageView(url: String(images[index]), imageView: imageView, placeholderImage: nil) { (image, url, type, state, error) in
                    
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
            imageContentView.isHidden = false
            imageContentView.snp.makeConstraints{ (make) in
                make.height.equalTo(contentImageHeight)
            }
        }else{
            imageContentView.isHidden = true
            imageContentView.snp.makeConstraints{ (make) in
                make.height.equalTo(0.0001)
            }
        }

        if model.isFork == 1 {
            self.likeButton.imageView.image = UIImage.init(named: "post_detail_like_select")
            self.likeButton.changeContent(str: model.commentTotal.string, image: nil)
        }else{
            likeButton.changeContent(str: model.commentTotal.string, image: nil)
        }

        if model.isCollect == 1 {
            self.collectButton.imageView.image = UIImage.init(named: "post_detail_collect_select")
        }else{
            self.collectButton.imageView.image = UIImage.init(named: "post_detail_collect")
        }

        self.contentView.updateConstraintsIfNeeded()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.height.equalTo(0.0001)
            }

            contnetLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
                make.height.equalTo(0.0001)
            }

            imageContentView.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.contnetLabel.snp.bottom).offset(25)
            }

            likeButtonView.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.contentView.snp.centerX).offset(-35)
                make.top.equalTo(self.imageContentView.snp.bottom).offset(7)
                make.size.equalTo(CGSize.init(width: 43, height: 64))
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-12)
            }
            
            collectButtonView.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.contentView.snp.centerX).offset(35)
                make.top.equalTo(self.imageContentView.snp.bottom).offset(7)
                make.size.equalTo(CGSize.init(width: 43, height: 64))
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
