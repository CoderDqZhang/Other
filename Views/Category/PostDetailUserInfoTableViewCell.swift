//
//  PostDetailUserInfoTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

typealias PostDetailUserInfoClouse = (_ type:GloabelButtonType) ->Void

class PostDetailUserInfoTableViewCell: UITableViewCell {

    var avatarImage:UIImageView!
    var userName:YYLabel!
    var timeLabel:YYLabel!
    
    var followButton:UIButton!
    var postDetailUserInfoClouse:PostDetailUserInfoClouse!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        avatarImage = UIImageView.init()
        avatarImage.backgroundColor = UIColor.gray
        avatarImage.layer.cornerRadius = 17
        avatarImage.layer.masksToBounds = true
        self.addSubview(avatarImage)
        
        userName = YYLabel.init()
        userName.text = "name"
        userName.textColor = App_Theme_2A2F34_Color
        userName.font = App_Theme_PinFan_M_15_Font
        self.addSubview(userName)
        
        
        timeLabel = YYLabel.init()
        timeLabel.text = "category"
        timeLabel.textColor = App_Theme_B5B5B5_Color
        timeLabel.font = App_Theme_PinFan_R_12_Font
        self.addSubview(timeLabel)
        
        followButton = UIButton.init(type: .custom)
        followButton.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
        followButton.backgroundColor = App_Theme_FFCB00_Color
        followButton.titleLabel?.font = App_Theme_PinFan_R_12_Font
        followButton.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -6, bottom: 0, right: 0)
        followButton.setTitle("关注", for: .normal)
        followButton.layer.cornerRadius = 10
        followButton.layer.masksToBounds = true
        followButton.addAction({ (btn) in
            if self.postDetailUserInfoClouse != nil {
                self.changeFollowStatus(status: self.followButton.tag == 0 ? true : false)
                self.postDetailUserInfoClouse(GloabelButtonType.init(rawValue: self.followButton.tag)!)
            }
        }, for: .touchUpInside)
        followButton.setImage(UIImage.init(named: "follow"), for: .normal)
        self.addSubview(followButton)
        
        self.updateConstraints()
    }
    
    func cellSetData(clouse:@escaping PostDetailUserInfoClouse){
        self.postDetailUserInfoClouse = clouse
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeFollowStatus(status:Bool) {
        self.followButton.tag = status == true ? 1 : 0
        if status {
            self.followButton.backgroundColor = UIColor.clear
            self.followButton.setImage(nil, for: .normal)
            self.followButton.borderWidth = 1.0
            self.followButton.setTitleColor(App_Theme_FFA544_Color, for: .normal)
            self.followButton.borderColor = App_Theme_FFA544_Color
            self.followButton.setTitle("已关注", for: .normal)
            
        }else {
            self.followButton.backgroundColor = UIColor.clear
            self.followButton.setImage(nil, for: .normal)
            self.followButton.borderWidth = 0.0001
            self.followButton.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
            self.followButton.backgroundColor = App_Theme_FFCB00_Color
            self.followButton.setImage(UIImage.init(named: "follow"), for: .normal)
            self.followButton.setTitle("关注", for: .normal)
        }
        
    }
    
    func cellSetData(model:TipModel){
        UIImageViewManger.sd_imageView(url: model.user.img, imageView: avatarImage, placeholderImage: nil) { (image, error, cache, url) in
            if error == nil {
                self.avatarImage.image = image
            }
        }
        userName.text = model.user.nickname
        timeLabel.text = model.createTime
        self.changeFollowStatus(status: model.user.isFollow == 1 ? true : false)
    }
    
    override func updateConstraints() {
        if !didMakeConstraints {
            avatarImage.snp.makeConstraints { (make) in
                make.centerY.equalTo(self.snp.centerY).offset(1)
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.size.equalTo(CGSize.init(width: 34, height: 34))
            }
            
            userName.snp.makeConstraints { (make) in
                make.top.equalTo(self.snp.top).offset(18)
                make.left.equalTo(self.avatarImage.snp.right).offset(14)
            }
            
            timeLabel.snp.makeConstraints { (make) in
                make.top.equalTo(self.userName.snp.bottom).offset(5)
                make.left.equalTo(self.avatarImage.snp.right).offset(14)
            }
            
            followButton.snp.makeConstraints { (make) in
                make.centerY.equalTo(self.snp.centerY).offset(1)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.size.equalTo(CGSize.init(width: 56, height: 20))
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
