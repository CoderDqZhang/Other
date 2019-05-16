//
//  MineInfoTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/16.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit



class MineInfoTableViewCell: UITableViewCell {

    var backImageView:UIImageView!
    var avatarImageView:UIImageView!
    var vImageView:UIImageView!
    var userNameLabel:YYLabel!
    var descLabel:YYLabel!
    var followLabel:YYLabel!
    var attentionsLabel:YYLabel!
    var daylyButton:AnimationButton!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        backImageView = UIImageView.init()
        backImageView.backgroundColor = App_Theme_FFCB00_Color
        self.contentView.addSubview(backImageView)
        
        avatarImageView = UIImageView.init()
        avatarImageView.backgroundColor = .red
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
        followLabel.textAlignment = .left
        followLabel.font = App_Theme_PinFan_M_12_Font
        followLabel.textColor = App_Theme_06070D_Color
        followLabel.text = "关注   66"
        self.contentView.addSubview(followLabel)
        
        attentionsLabel = YYLabel.init()
        attentionsLabel.textAlignment = .left
        attentionsLabel.font = App_Theme_PinFan_M_12_Font
        attentionsLabel.textColor = App_Theme_06070D_Color
        attentionsLabel.text = "粉丝   666"
        self.contentView.addSubview(attentionsLabel)
        
        daylyButton = AnimationButton.init(type: .custom)
        daylyButton.setTitle("每日任务", for: .normal)
        daylyButton.addAction { (button) in
            
        }
        self.contentView.addSubview(daylyButton)
        
        self.updateConstraints()
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
                make.centerY.equalTo(self.contentView.snp.centerY).offset(23)
                make.size.equalTo(CGSize.init(width: 62, height: 62))
            }
            
            userNameLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.avatarImageView.snp.right).offset(18)
                make.top.equalTo(self.avatarImageView.snp.top)
            }
            
            descLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.avatarImageView.snp.right).offset(18)
                make.top.equalTo(self.userNameLabel.snp.bottom).offset(7)
            }
            
            followLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.avatarImageView.snp.right).offset(18)
                make.top.equalTo(self.descLabel.snp.bottom).offset(9)
            }
            
            attentionsLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.followLabel.snp.right).offset(24)
                make.top.equalTo(self.followLabel.snp.top)
            }
            
            daylyButton.snp.makeConstraints { (make) in
                make.right.equalToSuperview()
                make.centerY.equalTo(self.contentView.snp.centerY).offset(23)
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
