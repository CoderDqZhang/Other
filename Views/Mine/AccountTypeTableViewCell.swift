//
//  AccountTypeTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/30.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
enum AccountTypeTableViewCellType:Int {
    case bank = 0
    case aliPay = 1
}
typealias AccountTypeTableViewCellClouse = (_ type:AccountTypeTableViewCellType) ->Void

class AccountTypeTableViewCell: UITableViewCell {

    var titleLabel:YYLabel!
    
    var bankButton:AnimationButton!
    var aliPayButton:AnimationButton!
    var accountTypeTableViewCellClouse:AccountTypeTableViewCellClouse!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
        self.setUpView()
    }
    
    func setUpView(){
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .left
        titleLabel.font = App_Theme_PinFan_M_15_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = "绑定类型"
        self.contentView.addSubview(titleLabel)
        
        bankButton = AnimationButton.init(type: .custom)
        bankButton.setTitle("银行卡", for: .normal)
        bankButton.setTitleColor(App_Theme_06070D_Color, for: .normal)
        bankButton.titleLabel?.font = App_Theme_PinFan_M_15_Font
        bankButton.setImage(UIImage.init(named: "sege_select_"), for: .normal)
        bankButton.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -14)
        bankButton.reactive.controlEvents(.touchUpInside).observeValues { (button) in
            self.bankButton.setImage(UIImage.init(named: "sege_select_"), for: .normal)
            self.aliPayButton.setImage(UIImage.init(named: "sege_normal"), for: .normal)
            if self.accountTypeTableViewCellClouse != nil {
                self.accountTypeTableViewCellClouse(.bank)
            }
        }
        self.contentView.addSubview(bankButton)
        
        aliPayButton = AnimationButton.init(type: .custom)
        aliPayButton.setTitle("支付宝", for: .normal)
        aliPayButton.setTitleColor(App_Theme_06070D_Color, for: .normal)
        aliPayButton.titleLabel?.font = App_Theme_PinFan_M_15_Font
        aliPayButton.setImage(UIImage.init(named: "sege_normal"), for: .normal)
        aliPayButton.reactive.controlEvents(.touchUpInside).observeValues { (button) in
            self.aliPayButton.setImage(UIImage.init(named: "sege_select_"), for: .normal)
            self.bankButton.setImage(UIImage.init(named: "sege_normal"), for: .normal)
            if self.accountTypeTableViewCellClouse != nil {
                self.accountTypeTableViewCellClouse(.aliPay)
            }
        }
        aliPayButton.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -14)
        self.contentView.addSubview(aliPayButton)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            titleLabel.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.width.equalTo(85)
            }
            
            bankButton.snp.makeConstraints { (make) in
                make.left.equalTo(self.titleLabel.snp.right).offset(25)
                make.centerY.equalToSuperview()
                make.width.equalTo(75)
            }
            
            aliPayButton.snp.makeConstraints { (make) in
                make.left.equalTo(self.bankButton.snp.right).offset(25)
                make.centerY.equalToSuperview()
                make.width.equalTo(75)
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
