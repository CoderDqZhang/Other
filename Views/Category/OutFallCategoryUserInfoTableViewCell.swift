//
//  OutFallCategoryUserInfoTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/9.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class OutFallUserInfoView: UIView {
    
    var avatarImage:UIImageView!
    var userName:YYLabel!
    var translateLabel:YYLabel!
    var shareButton:UIButton!
    
    var likeButton:UIButton!
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
    
    var didMakeConstraints = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func createContent(avatar:String, name:String, translate:String) {
        
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
        
        userName = YYLabel.init()
        userName.text = name
        userName.textColor = App_Theme_666666_Color
        userName.font = App_Theme_PinFan_M_14_Font
        self.addSubview(userName)
        
        
        translateLabel = YYLabel.init()
        translateLabel.text = translate
        translateLabel.textColor = App_Theme_999999_Color
        translateLabel.font = App_Theme_PinFan_L_14_Font
        self.addSubview(translateLabel)
        
        shareButton = UIButton.init(type: .custom)
        shareButton.setImage(UIImage.init(named: "share"), for: .normal)
        self.addSubview(shareButton)
        
        self.addSubview(lineLabel)
        
        self.updateConstraints()
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
            
            translateLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.userName.snp.right).offset(12)
                make.centerY.equalToSuperview()
            }
            
            lineLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.userName.snp.right).offset(6)
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize.init(width: 1, height: 1))
            }
            
            didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class OutFallCategoryUserInfoTableViewCell: UITableViewCell {

    var userView:OutFallUserInfoView!
    
    var isCategoryDetail:Bool = false
    var likeButton:UIButton!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        userView = OutFallUserInfoView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 52))
        self.contentView.addSubview(userView)
        
        userView.createContent(avatar: "", name: "Leiao Messi", translate: "里奥梅西")
        
        
        
        self.updateConstraints()
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
