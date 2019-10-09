//
//  ConfirmProtocolTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/21.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

typealias ConfirmProtocolTableViewCellClouse = () ->Void

class ConfirmProtocolTableViewCell: UITableViewCell {

    var checkBox:UIButton!
    var titleLabel:YYLabel!
    var detailLabel:YYLabel!
    
    var confirmProtocolTableViewCellClouse:ConfirmProtocolTableViewCellClouse!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
        self.setUpView()
    }
    
    func setUpView(){
        checkBox = UIButton.init(type: .custom)
        checkBox.layer.masksToBounds = true
        checkBox.cornerRadius = 8.5
        checkBox.tag = 100
        checkBox.setBackgroundImage(UIImage.init(named: "check_normal"), for: .normal)
        
        self.contentView.addSubview(checkBox)
        
        detailLabel = YYLabel.init()
        detailLabel.textAlignment = .left
        detailLabel.font = App_Theme_PinFan_M_12_Font
        detailLabel.textColor = App_Theme_FFAC1B_Color
        detailLabel.text = "《隐私用户条款约定》"
        detailLabel.isUserInteractionEnabled = true
        _ = detailLabel.newTapGesture { (config) in
            config.numberOfTapsRequired = 1
            config.numberOfTouchesRequired = 1
            }.whenTaped { (gesture) in
                if self.confirmProtocolTableViewCellClouse != nil {
                    self.confirmProtocolTableViewCellClouse()
                }
        }
        self.contentView.addSubview(detailLabel)
        
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .left
        titleLabel.font = App_Theme_PinFan_M_12_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = "同意"
        self.contentView.addSubview(titleLabel)
        
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            checkBox.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.contentView.snp.centerX).offset(-70)
                make.centerY.equalToSuperview()
            }
            
            detailLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.titleLabel.snp.right).offset(5)
                make.centerY.equalToSuperview()
            }
            
            titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.checkBox.snp.right).offset(9)
                make.centerY.equalToSuperview()
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
