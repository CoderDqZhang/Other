
//
//  ShieldTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/11/18.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

typealias UITableViewCellClouse = ( _ indexPath:IndexPath) ->Void

class ShieldTableViewCell: UITableViewCell {

    var titleLabel:YYLabel!
    var descLabel:YYLabel!
    var avatarImageView:UIImageView!
    var vImageView:UIImageView!
    
    var indexPath:IndexPath!
    
    var toolsButton:AnimationButton!
    
    var tableViewCellClouse:UITableViewCellClouse!
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 1))
    var didMakeConstraints = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
        self.setUpView()
    }
    
    func setUpView(){
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .left
        titleLabel.font = App_Theme_PinFan_M_14_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = "德国朱艺"
        self.contentView.addSubview(titleLabel)
        
        descLabel = YYLabel.init()
        descLabel.textAlignment = .left
        descLabel.font = App_Theme_PinFan_M_12_Font
        descLabel.textColor = App_Theme_999999_Color
        descLabel.text = "用户个性签名用户个性签名"
        self.contentView.addSubview(descLabel)
        
        avatarImageView  = UIImageView.init()
        avatarImageView.backgroundColor = .gray
        avatarImageView.cornerRadius = 17
        avatarImageView.layer.masksToBounds = true
        self.contentView.addSubview(avatarImageView)
        
        vImageView  = UIImageView.init()
        vImageView.image = UIImage.init(named: "vicon_")
        vImageView.layer.masksToBounds = true
        self.contentView.addSubview(vImageView)
        
        self.contentView.addSubview(lineLabel)
        
        toolsButton = AnimationButton.init(type: .custom)
        toolsButton.cornerRadius = 14
        toolsButton.titleLabel?.font = App_Theme_PinFan_R_14_Font
        toolsButton.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
        toolsButton.addAction({ (button) in
            if self.tableViewCellClouse != nil {
                self.tableViewCellClouse(self.indexPath)
            }
        }, for: .touchUpInside)
        toolsButton.setTitle("取消屏蔽", for: .normal)
        toolsButton.borderColor = App_Theme_FFAC1B_Color
        toolsButton.backgroundColor = App_Theme_FFAC1B_Color
        toolsButton.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
        toolsButton.borderWidth = 1
        self.contentView.addSubview(toolsButton)
        self.updateConstraints()
    }
    
    func cellSetData(model:FansFlowwerModel, indexPath:IndexPath){
        titleLabel.text = model.nickname
        self.indexPath = indexPath
        avatarImageView.sd_crope_imageView(url: model.img, imageView: avatarImageView, placeholderImage: nil) { (image, url, type, state, error) in
            
        }
        descLabel.text = model.descriptionField
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func lineLableHidden(ret:Bool){
        self.lineLabel.isHidden = ret
    }

    override func updateConstraints() {
        if !didMakeConstraints {
            avatarImageView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.size.equalTo(CGSize.init(width: 34, height: 34))
            }
            
            titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.avatarImageView.snp.right).offset(11)
                make.right.equalTo(self.toolsButton.snp.left).offset(-11)
                make.top.equalTo(self.avatarImageView.snp.top).offset(0)
            }
            
            descLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.avatarImageView.snp.right).offset(11)
                make.right.equalTo(self.toolsButton.snp.left).offset(-11)
                make.top.equalTo(self.titleLabel.snp.bottom).offset(1)
            }
            
            toolsButton.snp.makeConstraints { (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize.init(width: 81, height: 27))
            }
            
            vImageView.snp.makeConstraints { (make) in
                make.right.equalTo(self.avatarImageView.snp.right).offset(0)
                make.bottom.equalTo(self.avatarImageView.snp.bottom).offset(0)
                make.size.equalTo(CGSize.init(width: 11, height: 11))
            }
            
            lineLabel.snp.makeConstraints { (make) in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-1)
                make.height.equalTo(1)
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
