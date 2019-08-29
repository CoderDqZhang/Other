//
//  GloabelHeader.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/20.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

typealias GloabelHeaderClouse = (_ bool:Bool) ->Void

class GloabelHeader: UIView {

    var backImageView:UIImageView!
    var avatarImageView:UIImageView!
    var vImageView:UIImageView!
    var userNameLabel:YYLabel!
    var descLabel:YYLabel!
    var followLabel:YYLabel!
    var attentionsLabel:YYLabel!
    var lineLabel:YYLabel!
    
    var imageViewFrame:CGRect!
    
    var isSelect:Bool = false
    var followButton:AnimationButton!
    var mineInfoTableViewCellClouse:MineInfoTableViewCellClouse!
    var gloabelHeaderClouse:GloabelHeaderClouse!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backImageView = UIImageView.init()
        backImageView.backgroundColor = App_Theme_FFCB00_Color
        self.addSubview(backImageView)
        
        imageViewFrame = frame
        
        avatarImageView = UIImageView.init()
        avatarImageView.backgroundColor = .red
        avatarImageView.cornerRadius = 31
        avatarImageView.layer.masksToBounds = true
        self.addSubview(avatarImageView)
        
        vImageView = UIImageView.init()
        vImageView.image = UIImage.init(named: "vicon_")
        self.addSubview(vImageView)
        
        userNameLabel = YYLabel.init()
        userNameLabel.textAlignment = .left
        userNameLabel.font = App_Theme_PinFan_M_16_Font
        userNameLabel.textColor = App_Theme_06070D_Color
        userNameLabel.text = "中超小迪"
        self.addSubview(userNameLabel)
        
        descLabel = YYLabel.init()
        descLabel.textAlignment = .left
        descLabel.font = App_Theme_PinFan_M_12_Font
        descLabel.textColor = App_Theme_323442_Color
        descLabel.text = "这是简介这是简介这是简介"
        self.addSubview(descLabel)
        
        followLabel = YYLabel.init()
        followLabel.addTapGestureRecognizer(withDelegate: self) { (tag) in
            if self.mineInfoTableViewCellClouse != nil {
                self.mineInfoTableViewCellClouse(.fans)
            }
        }
        followLabel.textAlignment = .left
        followLabel.font = App_Theme_PinFan_M_12_Font
        followLabel.textColor = App_Theme_06070D_Color
        followLabel.text = "粉丝   66"
        self.addSubview(followLabel)
        
        lineLabel = YYLabel.init()
        lineLabel.backgroundColor = App_Theme_06070D_Color
        self.addSubview(lineLabel)
        
        attentionsLabel = YYLabel.init()
        attentionsLabel.textAlignment = .left
        attentionsLabel.font = App_Theme_PinFan_M_12_Font
        attentionsLabel.textColor = App_Theme_06070D_Color
        attentionsLabel.text = "关注   666"
        attentionsLabel.addTapGestureRecognizer(withDelegate: self) { (tag) in
            if self.mineInfoTableViewCellClouse != nil {
                self.mineInfoTableViewCellClouse(.follow)
            }
        }
        
        
        followButton = AnimationButton.init(type: .custom)
        followButton.cornerRadius = 14
        followButton.titleLabel?.font = App_Theme_PinFan_R_14_Font
        followButton.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
        followButton.addAction({ (button) in
            if self.gloabelHeaderClouse != nil {
                self.gloabelHeaderClouse(self.isSelect)
            }
        }, for: .touchUpInside)
        self.addSubview(followButton)
        
        
        self.addSubview(attentionsLabel)
        
        self.updateConstraints()
    }
    
    
    func changeToolsButtonType(followed:Bool) {
        isSelect = followed
        if followed {
            followButton.setTitle("已关注", for: .normal)
            followButton.borderColor = App_Theme_FFAC1B_Color
            followButton.backgroundColor = UIColor.clear
            followButton.setTitleColor(App_Theme_FFAC1B_Color, for: .normal)
            followButton.borderWidth = 1
        }else {
            followButton.setTitle("关注", for: .normal)
            followButton.borderColor = App_Theme_FFAC1B_Color
            followButton.backgroundColor = App_Theme_FFAC1B_Color
            followButton.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
            followButton.borderWidth = 1
        }
        
    }
    
    func cellSetData(model:UserInfoModel){
        avatarImageView.sd_crope_imageView(url: model.img, imageView: avatarImageView, placeholderImage: nil) { (image, url, type, state, error) in
            
            
        }
        
        userNameLabel.text = model.nickname
        descLabel.text = model.descriptionField
        if model.fansNum > 1000 {
            followLabel.text = "粉丝 \(model.fansNum.kFormatted)"
        }else{
            followLabel.text = "粉丝 \(model.fansNum.string)"
        }
        if model.followNum > 1000 {
            attentionsLabel.text = "关注 \(String(describing: model.followNum.kFormatted))"
        }else{
            attentionsLabel.text = "关注 \(model.followNum.string)"
        }
        descLabel.text = model.descriptionField == "" ? "还没有个人简介" : model.descriptionField
        vImageView.isHidden = model.isMaster == "1" ? false : true
        self.changeToolsButtonType(followed: model.isFollow == 0 ? false : true)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        backImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        avatarImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.bottom.equalTo(self.snp.bottom).offset(-12)
            make.size.equalTo(CGSize.init(width: 62, height: 62))
        }
        
        vImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 17, height: 17))
            make.left.equalTo(self.avatarImageView.snp.left).offset(44)
            make.top.equalTo(self.avatarImageView.snp.top).offset(45)
        }
        
        userNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView.snp.right).offset(18)
            make.top.equalTo(self.avatarImageView.snp.top)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView.snp.right).offset(18)
            make.top.equalTo(self.userNameLabel.snp.bottom).offset(0)
        }
        
        attentionsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView.snp.right).offset(18)
            make.top.equalTo(self.descLabel.snp.bottom).offset(2)
        }
        
        lineLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.attentionsLabel.snp.right).offset(12)
            make.top.equalTo(self.descLabel.snp.bottom).offset(5)
            make.size.equalTo(CGSize.init(width: 1, height: 11))
            make.width.equalTo(1)
        }
        
        followLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.lineLabel.snp.right).offset(12)
            make.top.equalTo(self.attentionsLabel.snp.top)
        }
        
        followButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-15)
            make.bottom.equalTo(self.snp.bottom).offset(-25)
            make.size.equalTo(CGSize.init(width: 61, height: 27))
        }
    }
    
    func scrollViewDidScroll(contentOffsetY: CGFloat) {
        var frame = imageViewFrame!
        frame.size.height -= contentOffsetY
        frame.origin.y = contentOffsetY
        backImageView.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


typealias StoreViewClouse = () ->Void

class StoreView: UIView {
    var storeLabel:YYLabel!
    var storeInfoLabel:YYLabel!
    var storeImageView:UIImageView!
    var backImageView:UIView!
    var centerView:UIView!
    
    var imageViewFrame:CGRect!
    
    var button:CustomViewButtonTopImageAndBottomLabel!
    
    var storeViewClouse:StoreViewClouse!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()

    }
    
    func setUpView(){
        backImageView = UIView.init()
        if #available(iOS 11.0, *) {
            backImageView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 94 + NAV_HEIGHT))
        } else {
            backImageView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 94))
            // Fallback on earlier versions
        }
        backImageView.backgroundColor = App_Theme_FFCB00_Color
        imageViewFrame = backImageView.frame

        self.addSubview(backImageView)
        if #available(iOS 11.0, *) {
            centerView = UIView.init(frame: CGRect.init(x: 18, y: 64 + NAV_HEIGHT / 2, width: SCREENWIDTH - 36, height: 80))
        } else {
            centerView = UIView.init(frame: CGRect.init(x: 18, y: 64, width: SCREENWIDTH - 36, height: 80))
            // Fallback on earlier versions
        }
        centerView.backgroundColor = .red
        self.addSubview(centerView)
        centerView.backgroundColor = App_Theme_FFFFFF_Color
        centerView.setShadowWithCornerRadius(corners: 8, shadowColor: App_Theme_8E8E8E_Color!, shadowOffset: CGSize.init(width: 2, height: 2), shadowOpacity: 1)
        
        storeLabel = YYLabel.init()
        storeLabel.textAlignment = .left
        storeLabel.font = App_Theme_PinFan_R_12_Font
        storeLabel.textColor = App_Theme_666666_Color
        storeLabel.text = "当前积分"
        centerView.addSubview(storeLabel)
        
        storeImageView = UIImageView.init()
        storeImageView.image = UIImage.init(named: "store_info")
        centerView.addSubview(storeImageView)
        
        storeInfoLabel = YYLabel.init()
        storeInfoLabel.textAlignment = .left
        storeInfoLabel.font = App_Theme_PinFan_M_28_Font
        storeInfoLabel.textColor = App_Theme_06070D_Color
        storeInfoLabel.text = "66666"
        centerView.addSubview(storeInfoLabel)
        
        let buttonView = UIView.init(frame:  CGRect.init(x: SCREENWIDTH - 120, y: 14, width: 100, height: 60))
        buttonView.isUserInteractionEnabled = true
        
        let button = CustomViewButtonTopImageAndBottomLabel.init(frame: CGRect.init(x: SCREENWIDTH - 150, y: 0, width: 100, height: 60), title: "商城", image: UIImage.init(named: "store")!, tag: 0, titleColor: App_Theme_999999_Color!, spacing: 10, font: App_Theme_PinFan_M_12_Font!) {
            if self.storeViewClouse != nil {
                self.storeViewClouse()
            }
        }
        button.isUserInteractionEnabled = true
        buttonView.addSubview(button)
        centerView.addSubview(buttonView)
        
        
        storeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.centerView.snp.left).offset(14)
            make.top.equalTo(self.centerView.snp.top).offset(18)
        }
        
        storeImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.storeLabel.snp.right).offset(2)
            make.top.equalTo(self.centerView.snp.top).offset(18)
        }
        
        storeInfoLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.centerView.snp.left).offset(14)
            make.bottom.equalTo(self.centerView.snp.bottom).offset(-18)
        }
        
    }
    
    func scrollViewDidScroll(contentOffsetY: CGFloat) {
        var frame = imageViewFrame!
        frame.size.height -= contentOffsetY
        frame.origin.y = contentOffsetY
        backImageView.frame = frame
    }
    
    func storeViewChangeText(_ text:String) {
        storeLabel.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
