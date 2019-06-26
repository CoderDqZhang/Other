//
//  UserInfoTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/9.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class UserInfoView: UIView {
    
    var avatarImage:UIImageView!
    var userName:YYLabel!
    var VImageView:UIImageView!
    
    var categoryLabel:YYLabel!
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: 1, height: 11))
    var didMakeConstraints = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func createContent(avatar:String, name:String, category:String) {
        
        avatarImage = UIImageView.init()
        avatarImage.backgroundColor = UIColor.gray
        UIImageViewManger.sd_imageView(url: avatar, imageView: avatarImage, placeholderImage: nil) { (image, error, type, url) in
            if error == nil {
                self.avatarImage.image = UIImageMaxCroped.cropeImage(image: image!, imageViewSize: CGSize.init(width: 22, height: 22))
            }
        }
        avatarImage.layer.cornerRadius = 11
        avatarImage.layer.masksToBounds = true
        self.addSubview(avatarImage)
        
        VImageView = UIImageView.init()
        VImageView.backgroundColor = UIColor.gray
        VImageView.isHidden = true
        VImageView.image = UIImage.init(named: "vicon_")
        self.addSubview(VImageView)
        
        userName = YYLabel.init()
        userName.text = name
        userName.textColor = App_Theme_666666_Color
        userName.font = App_Theme_PinFan_M_14_Font
        self.addSubview(userName)
        
        
        categoryLabel = YYLabel.init()
        categoryLabel.text = category
        categoryLabel.textColor = App_Theme_999999_Color
        categoryLabel.font = App_Theme_PinFan_L_14_Font
        self.addSubview(categoryLabel)
        
        self.addSubview(lineLabel)
        
        self.updateConstraints()
    }
    
    func lineHidden(){
        lineLabel.isHidden = true
    }
    
    func vImageHidden(hidden:Bool) {
        VImageView.isHidden = hidden
    }
    
    override func updateConstraints() {
        if !didMakeConstraints {
            avatarImage.snp.makeConstraints { (make) in
                make.left.equalTo(self.snp.left).offset(15)
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize.init(width: 22, height: 22))
            }
            
            userName.snp.makeConstraints { (make) in
                make.left.equalTo(self.avatarImage.snp.right).offset(10)
                make.centerY.equalToSuperview()
            }
            
            categoryLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.userName.snp.right).offset(12)
                make.centerY.equalToSuperview()
            }
            
            lineLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.userName.snp.right).offset(5)
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize.init(width: 1, height: 11))
            }
            
            VImageView.snp.makeConstraints { (make) in
                make.left.equalTo(self.userName.snp.right).offset(0)
                make.top.equalTo(self.snp.top).offset(15)
                make.size.equalTo(CGSize.init(width: 11, height: 11))
            }
            
            didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UserInfoTableViewCell: UITableViewCell {
    
    var userView:UserInfoView!

    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        userView = UserInfoView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 52))
        self.contentView.addSubview(userView)
        

        self.updateConstraints()
    }
    
    func cellSetData(model:TipModel){
        if model.tribe != nil {
            userView.createContent(avatar: model.user.img, name: model.user.nickname, category: model.tribe.tribeName)
        }else {
            print(model)
        }
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
