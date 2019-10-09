//
//  BankTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class BankTableViewCell: UITableViewCell {

    var leftImage:UIImageView!
    var tittleLabel:YYLabel!
    var bankName:YYLabel!
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 15, y: 0, width: SCREENWIDTH - 30, height: 1))

    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
        self.setUpView()
    }
    
    func setUpView(){
        
        leftImage = UIImageView.init()
        self.contentView.addSubview(leftImage)
        
        tittleLabel = YYLabel.init()
        tittleLabel.textAlignment = .left
        tittleLabel.font = App_Theme_PinFan_M_14_Font
        tittleLabel.textColor = App_Theme_06070D_Color
        tittleLabel.text = ""
        self.contentView.addSubview(tittleLabel)
        
        bankName = YYLabel.init()
        bankName.textAlignment = .left
        bankName.font = App_Theme_PinFan_M_12_Font
        bankName.textColor = App_Theme_999999_Color
        bankName.text = ""
        self.contentView.addSubview(bankName)
        
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraints()
    }
    
    func cellSetData(model:BankModel){
        if model.type == "0" {
            tittleLabel.text = model.account
            bankName.text = model.bank
            leftImage.image = UIImage.init(named: "bank")
            tittleLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(self.contentView.snp.top).offset(13)
                make.left.equalTo(self.leftImage.snp.right).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            }
            
            bankName.snp.remakeConstraints { (make) in
                make.top.equalTo(self.tittleLabel.snp.bottom).offset(0)
                make.left.equalTo(self.leftImage.snp.right).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            }
            
        }else{
            leftImage.image = UIImage.init(named: "alipay")
            tittleLabel.text = model.account
            tittleLabel.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.leftImage.snp.right).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            }
            bankName.text = ""
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            leftImage.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.size.equalTo(CGSize.init(width: 25, height: 25))
            }
            
            lineLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
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
