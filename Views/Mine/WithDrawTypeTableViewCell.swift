//
//  WithDrawTypeTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/30.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class WithDrawTypeTableViewCell: UITableViewCell {

    var titleLabel:YYLabel!
    var descLabel:YYLabel!
    var descImageView:UIImageView!
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 1))
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
        self.setUpView()
        self.accessoryType = .disclosureIndicator
    }
    
    func setUpView(){
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .left
        titleLabel.font = App_Theme_PinFan_M_15_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = "提现到："
        self.contentView.addSubview(titleLabel)
        
        descLabel = YYLabel.init()
        descLabel.textAlignment = .center
        descLabel.font = App_Theme_PinFan_R_12_Font
        descLabel.textColor = App_Theme_06070D_Color
        descLabel.text = ""
        self.contentView.addSubview(descLabel)
        
        descImageView  = UIImageView.init()
        descImageView.layer.masksToBounds = true
        self.contentView.addSubview(descImageView)
        
        self.contentView.addSubview(lineLabel)
        self.updateConstraints()
    }
    
    func cellSetData(model:BankModel?){
        if model == nil {
            descLabel.text = "添加提现账户"
        }else{
            if model?.type == "0" {
                descLabel.text = model?.account
                descImageView.image = UIImage.init(named: "bank")
            }else{
                descLabel.text = model?.account
                descImageView.image = UIImage.init(named: "alipay")
            }
            descLabel.snp.makeConstraints { (make) in
                make.width.equalTo((model?.account.nsString.width(with: App_Theme_PinFan_R_12_Font, constrainedToHeight: 15))!)
            }
        }
    }
    
    func updateDescFontAndColor(_ color:UIColor,_ font:UIFont){
        descLabel.textColor = color
        descLabel.font = font
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func lineLableHidden(){
        self.lineLabel.isHidden = true
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.width.equalTo(200)
                make.centerY.equalToSuperview()
            }
            
            descLabel.snp.makeConstraints { (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-9)
                make.centerY.equalToSuperview()
            }
            
            descImageView.snp.makeConstraints { (make) in
                make.right.equalTo(self.descLabel.snp.left).offset(-9)
                make.size.equalTo(CGSize.init(width: 25, height: 25))
                make.centerY.equalToSuperview()
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
