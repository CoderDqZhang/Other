//
//  PostDetailCommentUserTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

typealias PostDetailCommentUserTableViewCellClouse = (_ indexPath:IndexPath) ->Void

class PostDetailCommentUserTableViewCell: UITableViewCell {

    var avatarImage:UIImageView!
    var userName:YYLabel!
    var timeLabel:YYLabel!
    var likeButton:CustomViewButtonTopImageAndBottomLabel!
    var indexPath:IndexPath!
    
    var postDetailCommentUserTableViewCellClouse:PostDetailCommentUserTableViewCellClouse!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        
        avatarImage = UIImageView.init()        
        avatarImage.layer.cornerRadius = 11
        avatarImage.layer.masksToBounds = true
        self.addSubview(avatarImage)
        
        userName = YYLabel.init()
        userName.text = "中超小迪"
        userName.textColor = App_Theme_666666_Color
        userName.font = App_Theme_PinFan_M_14_Font
        self.addSubview(userName)
        
        
        timeLabel = YYLabel.init()
        timeLabel.textColor = App_Theme_B5B5B5_Color
        timeLabel.font = App_Theme_PinFan_L_10_Font
        timeLabel.text = "2019-05-06 17:30"
        self.addSubview(timeLabel)
        
        likeButton = CustomViewButtonTopImageAndBottomLabel.init( frame: CGRect.init(x: 0, y: 0, width: 34, height: 64), title: "666", image: UIImage.init(named: "category_detail_like")!, tag: 1, titleColor: App_Theme_B5B5B5_Color!, spacing: 7, font: App_Theme_PinFan_R_12_Font!, click: {
            if UIImage.init(named: "loveinred") == self.likeButton.imageView.image {
                self.likeButton.imageView.image = UIImage.init(named: "category_detail_like")
                self.likeButton.changeContent(str: (self.likeButton.label.text!.int! - 1).string, image: nil)
            }else{
                self.likeButton.imageView.image = UIImage.init(named: "loveinred")
                self.likeButton.changeContent(str: (self.likeButton.label.text!.int! + 1).string, image: nil)
            }
            
            if self.postDetailCommentUserTableViewCellClouse != nil {
                self.postDetailCommentUserTableViewCellClouse(self.indexPath)
            }
        })
        
        self.contentView.addSubview(likeButton)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func changeLikeButtonStatus(status:Int) ->UIImage{
        if status == 0 {
            return UIImage.init(named: "category_detail_like")!
        }else{
            return UIImage.init(named: "loveinred")!
        }
    }
    
    func cellSetRepliy(model:ReplyList,indexPath:IndexPath){
        self.indexPath = indexPath
        avatarImage.sd_crope_imageView(url: model.img, imageView: avatarImage, placeholderImage: nil) { (image, url, type, state, error) in
            
        }
        userName.text = model.nickname
        timeLabel.text = model.createTime
        if model.status == "0"  {
            self.likeButton.isEnable(ret: true)
        }else{
            self.likeButton.isEnable(ret: false)
        }
        self.likeButton.changeContent(str: model.followNum.string, image: self.changeLikeButtonStatus(status: model.isFollow))
    }
    
    func cellSetData(model:CommentModel,indexPath:IndexPath){
        self.indexPath = indexPath
        avatarImage.sd_crope_imageView(url: model.user.img, imageView: avatarImage, placeholderImage: nil) { (image, url, type, state, error) in
            
        }
        userName.text = model.user.nickname
        timeLabel.text = model.createTime
        if model.status == "0"  {
            self.likeButton.isEnable(ret: true)
        }else{
            self.likeButton.isEnable(ret: false)
        }
        
        self.likeButton.changeContent(str: model.approveNum.string, image: self.changeLikeButtonStatus(status: model.isFollow))
    }
    
    override func updateConstraints() {
        if !didMakeConstraints {
            avatarImage.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.size.equalTo(CGSize.init(width: 22, height: 22))
            }
            
            userName.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView.snp.top).offset(14)
                make.left.equalTo(self.avatarImage.snp.right).offset(7)
            }
            
            timeLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.avatarImage.snp.right).offset(7)
                make.top.equalTo(self.userName.snp.bottom).offset(1)
            }
            
            likeButton.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.size.equalTo(CGSize.init(width: 30, height: 30))
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
