//
//  TagerUserTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/15.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class TagerUserTableViewCell: UITableViewCell {

    var avatarImageView:UIImageView!
    var userNameLabel:YYLabel!
    var descLabel:YYLabel!
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 1))
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        
        avatarImageView = UIImageView.init()
        avatarImageView.backgroundColor = .gray
        avatarImageView.cornerRadius = 17
        avatarImageView.layer.masksToBounds = true
        self.contentView.addSubview(avatarImageView)
        
        userNameLabel = YYLabel.init()
        userNameLabel.textAlignment = .left
        userNameLabel.font = App_Theme_PinFan_M_14_Font
        userNameLabel.textColor = App_Theme_06070D_Color
        userNameLabel.text = "德国朱艺"
        self.contentView.addSubview(userNameLabel)
        
        descLabel = YYLabel.init()
        descLabel.textAlignment = .left
        descLabel.font = App_Theme_PinFan_M_12_Font
        descLabel.numberOfLines = 1
        descLabel.textColor = App_Theme_999999_Color
        descLabel.text = "用户个性签名用户个性签名"
        self.contentView.addSubview(descLabel)
        
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            avatarImageView.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.size.equalTo(CGSize.init(width: 34, height: 34))
                make.centerY.equalToSuperview()
            }
            
            userNameLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.avatarImageView.snp.right).offset(11)
                make.top.equalTo(self.contentView.snp.top).offset(12)
            }
            
            descLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.avatarImageView.snp.right).offset(11)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.userNameLabel.snp.bottom).offset(0)
            }
            
            lineLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(0)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-1)
                make.size.height.equalTo(1)
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
