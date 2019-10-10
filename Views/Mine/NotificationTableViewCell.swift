//
//  NotificationTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

typealias NotificationTableViewCellClouse = (_ indexPath:IndexPath) ->Void

class NotificationTableViewCell: UITableViewCell {

    var conisImageView:UIImageView!
    var titleLabel:YYLabel!
    var timeLabel:YYLabel!
    var descLabel:YYLabel!
    var indexPath:IndexPath!
    
    var isUnread:YYLabel!
    
    var notificationTableViewCellClouse:NotificationTableViewCellClouse!
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: SCREENWIDTH, height: 1)))

    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
        self.setUpView()
    }
    
    func setUpView(){
        conisImageView = UIImageView.init()
        conisImageView.cornerRadius = 17
        conisImageView.layer.borderColor = App_Theme_F6F6F6_Color!.cgColor
        conisImageView.borderWidth = 1
        conisImageView.layer.masksToBounds = true
        conisImageView.image = UIImage.init(named: "norification")
        self.contentView.addSubview(conisImageView)
        
        
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .left
        titleLabel.font = App_Theme_PinFan_M_14_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = ""
        self.contentView.addSubview(titleLabel)
        
        descLabel = YYLabel.init()
        descLabel.textAlignment = .left
        descLabel.font = App_Theme_PinFan_M_10_Font
        descLabel.textColor = App_Theme_999999_Color
        descLabel.text = ""
        self.contentView.addSubview(descLabel)
        
        isUnread = YYLabel.init()
        isUnread.backgroundColor = App_Theme_FF584F_Color
        isUnread.cornerRadius = 4
        isUnread.layer.masksToBounds = true
        self.contentView.addSubview(isUnread)
        
        timeLabel = YYLabel.init()
        timeLabel.textAlignment = .center
        timeLabel.font = App_Theme_PinFan_M_10_Font
        timeLabel.textColor = App_Theme_999999_Color
        timeLabel.text = ""
        self.contentView.addSubview(timeLabel)
        
        self.contentView.addSubview(lineLabel)
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetData(model:NotificaitonModel, type:NotificationType, indexPath:IndexPath){
        _ = self.newLongpressGesture().whenBegan { (re) in
            print("长按点击")
            }.whenEnded { (re) in
                if self.notificationTableViewCellClouse != nil {
                    self.notificationTableViewCellClouse(indexPath)
                }
        }
        self.indexPath = indexPath
        if type == .system {
            if model.user != nil && model.type != "0" {
                titleLabel.text = "\(String(describing: model.user.nickname!))\(String(describing: model.title!))"
                if model.user.img != nil {
                    conisImageView.sd_crope_imageView(url:  model.user.img, imageView: conisImageView, placeholderImage: nil) { (image, url, tyoe, statge, error) in
                        
                    }
                }else{
                    conisImageView.image = UIImage.init(named: "norification")
                }
            }else{
                titleLabel.text = model.title
            }
            
            
            descLabel.text = model.descriptionField
        }else{
            titleLabel.text = model.descriptionField
            descLabel.text = model.title
        }
        
        timeLabel.text = model.createTime
        isUnread.isHidden = model.status == "1" ? true : false
    }
    
    func hiddenLineLabel(ret:Bool){
        lineLabel.isHidden = ret
    }
    
    override func updateConstraints() {
        if !didMakeConstraints {
            conisImageView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.size.equalTo(CGSize.init(width: 34, height: 34))
            }
            
            timeLabel.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView.snp.top).offset(18)
                make.left.equalTo(titleLabel.snp.right).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            }
            
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView.snp.top).offset(17)
                make.left.equalTo(self.conisImageView.snp.right).offset(11)
                make.right.equalTo(self.contentView.snp.right).offset(-150)
            }
            
            descLabel.snp.makeConstraints { (make) in
                make.top.equalTo(self.titleLabel.snp.bottom).offset(1)
                make.left.equalTo(self.conisImageView.snp.right).offset(11)
                make.right.lessThanOrEqualTo(self.contentView.snp.centerX).offset(0)
            }
            
            isUnread.snp.makeConstraints { (make) in
                make.top.top.equalTo(self.contentView.snp.top).offset(11)
                make.left.equalTo(self.conisImageView.snp.right).offset(8)
                make.size.equalTo(CGSize.init(width: 8, height: 8))
            }
            
            lineLabel.snp.makeConstraints { (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-1)
                make.size.equalTo(CGSize.init(width: SCREENWIDTH, height: 1))
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
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
