//
//  PostDetailCommentUserTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

typealias PostDetailCommentUserTableViewCellClouse = () ->Void

class PostDetailCommentUserTableViewCell: UITableViewCell {

    var avatarImage:UIImageView!
    var userName:YYLabel!
    var timeLabel:YYLabel!
    var likeButton:CustomViewButtonTopImageAndBottomLabel!
    
    var postDetailCommentUserTableViewCellClouse:PostDetailCommentUserTableViewCellClouse!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        
        avatarImage = UIImageView.init()
        avatarImage.backgroundColor = UIColor.gray
        
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
            
            self.postDetailCommentUserTableViewCellClouse()
        })
        
        self.contentView.addSubview(likeButton)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func changeLikeButtonStatus(status:Int) ->UIImage{
        if status == 0{
            return UIImage.init(named: "category_detail_like")!
        }else{
            return UIImage.init(named: "category_detail_like")!
        }
    }
    
    func cellSetData(model:CommentModel){
        UIImageViewManger.sd_imageView(url: model.img, imageView: avatarImage, placeholderImage: nil) { (image, error, cache, url) in
            if error == nil {
                self.avatarImage.image = image
            }
        }
        userName.text = model.user.nickname
        timeLabel.text = model.createTime
        self.likeButton.changeContent(str: model.replyNum.string, image: self.changeLikeButtonStatus(status: model.isFollow))
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
