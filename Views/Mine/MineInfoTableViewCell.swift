//
//  MineInfoTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/16.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
let CentViewWidht:CGFloat = 123

enum TopUpViewClickType {
    case topUp
    case store
    case follow
    case fans
}

typealias TopUpViewTypeClouse = (_ type:TopUpViewClickType) ->Void

class TopUpView: UIView {
    
    var infoView:UIView!
    var storeView:UIView!
    
    var iconLabel:YYLabel!
    var numberLabel:YYLabel!
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: 2, height: 30))
    
    var topUpViewTypeClouse:TopUpViewTypeClouse!
    
    init(frame:CGRect, cion:String, number:String, clouse:@escaping TopUpViewTypeClouse) {
        super.init(frame: frame)
        self.topUpViewTypeClouse = clouse
        self.setUpInfoView(cion: cion)
        self.setUpStoreView(number: number)
        self.addSubview(lineLabel)
        lineLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 2, height: 30))
        }
     }
    
    func setUpInfoView(cion:String){
        infoView = UIView.init()
        self.addSubview(infoView)

        infoView.addTapGestureRecognizer(withDelegate: self) { (tag) in
            self.topUpViewTypeClouse(.topUp)
        }
        
        let centerView = UIView.init(frame: CGRect.init(x: CenterViewMarginLeft, y: 0, width: CentViewWidht, height: 63))
        infoView.addSubview(centerView)
        
        iconLabel = YYLabel.init()
        iconLabel.textAlignment = .center
        iconLabel.font = App_Theme_PinFan_R_19_Font
        iconLabel.textColor = App_Theme_06070D_Color
        centerView.addSubview(iconLabel)
        
        iconLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(centerView.snp.top).offset(16)
            make.width.equalTo(83)
        }
        
        let iconInfoLabel = YYLabel.init()
        iconInfoLabel.textAlignment = .center
        iconInfoLabel.font = App_Theme_PinFan_M_10_Font
        iconInfoLabel.textColor = App_Theme_999999_Color
        iconInfoLabel.text = "M币"
        centerView.addSubview(iconInfoLabel)
        
        iconInfoLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(iconLabel.snp.bottom).offset(1)
            make.width.equalTo(iconLabel.snp.width)
        }
        
        let topUpLabel = YYLabel.init()
        topUpLabel.textAlignment = .center
        topUpLabel.font = App_Theme_PinFan_M_14_Font
        topUpLabel.textColor = App_Theme_06070D_Color
        topUpLabel.text = "充值"
        centerView.addSubview(topUpLabel)
        
        topUpLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.left.equalTo(iconLabel.snp.right).offset(9)
            make.width.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        let backGroundLabel = YYLabel.init()
        backGroundLabel.backgroundColor = App_Theme_FFD512_Color
        centerView.addSubview(backGroundLabel)
        
        backGroundLabel.snp.makeConstraints { (make) in
            make.right.equalTo(centerView.snp.right).offset(2)
            make.left.equalTo(topUpLabel.snp.left).offset(0)
            make.top.equalTo(topUpLabel.snp.bottom).offset(0)
            make.size.equalTo(CGSize.init(width: 30, height: 3))
        }
        
        centerView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize.init(width: CentViewWidht, height: 63))
        }
        
        infoView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo((SCREENWIDTH - 30) / 2)
        }
        
    }
    
    func setUpStoreView(number:String){
        storeView = UIView.init()
        self.addSubview(storeView)
        
        storeView.addTapGestureRecognizer(withDelegate: self) { (tag) in
            self.topUpViewTypeClouse(.store)
        }
        
        let centerView = UIView.init(frame: CGRect.init(x: SCREENWIDTH / 2 + CenterViewMarginLeft, y: 0, width: CentViewWidht, height: 63))
        storeView.addSubview(centerView)
        
        numberLabel = YYLabel.init()
        numberLabel.textAlignment = .center
        numberLabel.font = App_Theme_PinFan_R_19_Font
        numberLabel.textColor = App_Theme_06070D_Color
        numberLabel.text = number
        centerView.addSubview(numberLabel)
        
        numberLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(centerView.snp.top).offset(16)
            make.width.equalTo(83)
        }
        
        let numberInfoLabel = YYLabel.init()
        numberInfoLabel.textAlignment = .center
        numberInfoLabel.font = App_Theme_PinFan_M_10_Font
        numberInfoLabel.textColor = App_Theme_999999_Color
        numberInfoLabel.text = "积分"
        centerView.addSubview(numberInfoLabel)
        
        numberInfoLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(numberLabel.snp.bottom).offset(1)
            make.width.equalTo(iconLabel.snp.width)
        }
        
        let storeLabel = YYLabel.init()
        storeLabel.textAlignment = .center
        storeLabel.font = App_Theme_PinFan_M_14_Font
        storeLabel.textColor = App_Theme_06070D_Color
        storeLabel.text = "商城"
        centerView.addSubview(storeLabel)
        
        storeLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.left.equalTo(numberLabel.snp.right).offset(9)
            make.width.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        let backGroundLabel1 = YYLabel.init()
        backGroundLabel1.backgroundColor = App_Theme_FFD512_Color
        centerView.addSubview(backGroundLabel1)
        
        backGroundLabel1.snp.makeConstraints { (make) in
            make.right.equalTo(centerView.snp.right).offset(2)
            make.left.equalTo(storeLabel.snp.left).offset(0)
            make.top.equalTo(storeLabel.snp.bottom).offset(0)
            make.size.equalTo(CGSize.init(width: 30, height: 3))
        }
        
        centerView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize.init(width: CentViewWidht, height: 63))
        }
        
        storeView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo((SCREENWIDTH - 30) / 2)
        }
    }
    
    func updateText(icon:String, number:String) {
        if icon.double()! > 10000 {
            iconLabel.text = icon.double()?.int.kFormatted
        }else{
            iconLabel.text = icon
        }
        if number.double()! > 10000 {
            numberLabel.text = number.double()?.int.kFormatted
        }else{
            numberLabel.text = number
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

let CenterViewMarginLeft = (((SCREENWIDTH - 30) / 2) - 111) / 2

typealias MineInfoTableViewCellClouse = (_ type:TopUpViewClickType) ->Void

class MineInfoTableViewCell: UITableViewCell {

    var backImageView:UIImageView!
    var avatarImageView:UIImageView!
    var vImageView:UIImageView!
    var userNameLabel:YYLabel!
    var descLabel:YYLabel!
    var followLabel:YYLabel!
    var attentionsLabel:YYLabel!
    var lineLabel:YYLabel!
    var daylyButton:AnimationButton!
    
    var toolsView:UIView!
    var topUpView:TopUpView!
    var storeView:TopUpView!
    
    var didMakeConstraints = false
    
    var mineInfoTableViewCellClouse:MineInfoTableViewCellClouse!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        backImageView = UIImageView.init()
        backImageView.backgroundColor = App_Theme_FFCB00_Color
        self.contentView.addSubview(backImageView)
        
        avatarImageView = UIImageView.init()
        avatarImageView.cornerRadius = 31
        avatarImageView.layer.masksToBounds = true
        self.contentView.addSubview(avatarImageView)
        
        vImageView = UIImageView.init()
        vImageView.image = UIImage.init(named: "vicon_")
        self.contentView.addSubview(vImageView)
        
        userNameLabel = YYLabel.init()
        userNameLabel.textAlignment = .left
        userNameLabel.font = App_Theme_PinFan_M_16_Font
        userNameLabel.textColor = App_Theme_06070D_Color
        userNameLabel.text = "中超小迪"
        self.contentView.addSubview(userNameLabel)
        
        descLabel = YYLabel.init()
        descLabel.textAlignment = .left
        descLabel.font = App_Theme_PinFan_M_12_Font
        descLabel.textColor = App_Theme_323442_Color
        descLabel.text = "这是简介这是简介这是简介"
        self.contentView.addSubview(descLabel)
        
        followLabel = YYLabel.init()
        followLabel.addTapGestureRecognizer(withDelegate: self) { (tag) in
            self.mineInfoTableViewCellClouse(.fans)
        }
        followLabel.textAlignment = .left
        followLabel.font = App_Theme_PinFan_M_12_Font
        followLabel.textColor = App_Theme_06070D_Color
        followLabel.text = "粉丝   66"
        self.contentView.addSubview(followLabel)
        
        lineLabel = YYLabel.init()
        lineLabel.backgroundColor = App_Theme_06070D_Color
        self.contentView.addSubview(lineLabel)
        
        attentionsLabel = YYLabel.init()
        attentionsLabel.textAlignment = .left
        attentionsLabel.font = App_Theme_PinFan_M_12_Font
        attentionsLabel.textColor = App_Theme_06070D_Color
        attentionsLabel.text = "关注   666"
        attentionsLabel.addTapGestureRecognizer(withDelegate: self) { (tag) in
            self.mineInfoTableViewCellClouse(.follow)
        }
        self.contentView.addSubview(attentionsLabel)
        
        daylyButton = AnimationButton.init(type: .custom)
        daylyButton.titleLabel?.font = App_Theme_PinFan_M_12_Font
        daylyButton.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
        daylyButton.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 3, bottom: 0, right: 0)
        daylyButton.setBackgroundImage(UIImage.init(named: "dayliy"), for: .normal)
        daylyButton.setTitle("每日任务", for: .normal)
        daylyButton.addAction { (button) in
            
        }
        self.contentView.addSubview(daylyButton)
        
        
        topUpView = TopUpView.init(frame: CGRect.init(x: 0, y: 0, width: (SCREENWIDTH - 30) / 2, height: 63), cion: "66", number: "66666", clouse: { type in
            if self.mineInfoTableViewCellClouse != nil {
                self.mineInfoTableViewCellClouse(type)
            }
        })
        topUpView.backgroundColor = .red
        topUpView.cornerRadius = 15
        topUpView.backgroundColor = App_Theme_FFFFFF_Color
        topUpView.setShadowWithCornerRadius(corners: 10, shadowColor: App_Theme_B5B5B5_Color!, shadowOffset: CGSize.init(width: 2, height: 2), shadowOpacity: 1)
        self.contentView.addSubview(topUpView)
        
        self.updateConstraints()
    }
    
    func cellSetData(model:UserInfoModel?,acount:AccountInfoModel?){
        if model != nil {
            userNameLabel.text = model!.nickname
            if model!.fansNum > 1000 {
                followLabel.text = "粉丝 \(model!.fansNum.kFormatted)"
            }else{
                followLabel.text = "粉丝 \(model!.fansNum.string)"
            }
            if model!.followNum > 1000 {
                attentionsLabel.text = "关注 \(String(describing: model?.followNum.kFormatted))"
            }else{
                attentionsLabel.text = "关注 \(model!.followNum.string)"
            }
            descLabel.text = model!.descriptionField == "" ? "还没有个人简介" : model!.descriptionField
            UIImageViewManger.sd_imageView(url: model!.img, imageView: avatarImageView, placeholderImage: nil) { (image, error, cacheType, url) in
                self.avatarImageView.image = image
            }
            vImageView.isHidden = model!.isMaster == "1" ? false : true
        }
        if acount?.integral != nil {
            topUpView.updateText(icon: acount!.chargeCoin.string, number: acount!.integral.string)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !didMakeConstraints {
            backImageView.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.right.equalToSuperview()
                make.left.equalToSuperview()
                make.height.equalTo(SCREENWIDTH * 167 / 375)
            }
            
            avatarImageView.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(-3)
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
            
            daylyButton.snp.makeConstraints { (make) in
                make.right.equalToSuperview()
                make.centerY.equalTo(self.contentView.snp.centerY).offset(-3)
                make.size.equalTo(CGSize.init(width: 80, height: 24))
            }
            
            topUpView.snp.makeConstraints { (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-8)
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.height.equalTo(63)
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
