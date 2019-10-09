//
//  TopUpTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/29.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class CoinsCountView: UIView {
    var backImageView:UIImageView!
    var titleLabel:YYLabel!
    var coinsLabel:YYLabel!
    var allCoinsLabel:YYLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backImageView = UIImageView.init()
        backImageView.image = UIImage.init(named: "coins_back")
        self.addSubview(backImageView)
        
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .center
        titleLabel.font = App_Theme_PinFan_R_14_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = "当前余额(M币)"
        self.addSubview(titleLabel)
        
        coinsLabel = YYLabel.init()
        coinsLabel.textAlignment = .center
        coinsLabel.font = App_Theme_PinFan_M_24_Font
        coinsLabel.textColor = App_Theme_06070D_Color
        coinsLabel.text = "666.66"
        self.addSubview(coinsLabel)
        
        allCoinsLabel = YYLabel.init()
        allCoinsLabel.textAlignment = .center
        allCoinsLabel.font = App_Theme_PinFan_R_14_Font
        allCoinsLabel.textColor = App_Theme_06070D_Color
        self.addSubview(allCoinsLabel)
        
        self.updateConstraints()
    }
    
    func viewSetData(model:AccountInfoModel){
        let coins = (model.inviteCoin + model.recomCoin)
        let allCoins = (model.chargeCoin + model.inviteCoin + model.recomCoin)
        coinsLabel.text =  String(format: "%.2f", coins)
        allCoinsLabel.text = "总余额为\(String(format: "%.2f", allCoins))M币"
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        backImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        coinsLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.allCoinsLabel.snp.top).offset(-5)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(coinsLabel.snp.top).offset(0)
        }
        
        allCoinsLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class CoinsView: UIView {
    var backImageView:UIImageView!
    var titleLabel:YYLabel!
    var coinsLabel:YYLabel!
    var withDrawButton:AnimationButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backImageView = UIImageView.init()
        backImageView.image = UIImage.init(named: "coins_back")
        self.addSubview(backImageView)
        
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .center
        titleLabel.font = App_Theme_PinFan_R_14_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = "当前余额(M币)"
        self.addSubview(titleLabel)
        
        coinsLabel = YYLabel.init()
        coinsLabel.textAlignment = .center
        coinsLabel.font = App_Theme_PinFan_M_24_Font
        coinsLabel.textColor = App_Theme_06070D_Color
        coinsLabel.text = "666.66"
        self.addSubview(coinsLabel)
        
        withDrawButton = AnimationButton.init(type: .custom)
        withDrawButton.setTitle("提现", for: .normal)
        withDrawButton.cornerRadius = 11
        withDrawButton.layer.masksToBounds = true
        withDrawButton.titleLabel?.font = App_Theme_PinFan_M_14_Font
        withDrawButton.backgroundColor = App_Theme_FFAC1B_Color
        
        self.addSubview(withDrawButton)
        
        self.updateConstraints()
    }
    
    func viewSetData(model:AccountInfoModel){
        coinsLabel.text = String(format: "%.2f", (model.chargeCoin + model.inviteCoin + model.recomCoin))
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        backImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        coinsLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.centerY.equalTo(self.snp.centerY).offset(24)
            } else {
                make.centerY.equalTo(self.snp.centerY).offset(0)
                // Fallback on earlier versions
            }
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(coinsLabel.snp.top).offset(0)
        }
        
        withDrawButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(coinsLabel.snp.bottom).offset(0)
            make.size.equalTo(CGSize.init(width: 85, height: 23))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias TopUpTableViewCellClouse = () ->Void

class TopUpTableViewCell: UITableViewCell {

    var coinsView:CoinsView!
    var coinsallCountView:CoinsCountView!
    
    var topUpTableViewCellClouse:TopUpTableViewCellClouse!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
        self.setUpView()
    }
    
    func setUpView(){
        self.updateConstraints()
    }
    
    func cellSetData(model:AccountInfoModel){
        if coinsView == nil {
            coinsView = CoinsView.init(frame: CGRect.init(x: 0, y: 0 , width: SCREENWIDTH, height: 189))
            coinsView.withDrawButton.addAction({ (button) in
                if self.topUpTableViewCellClouse != nil {
                    self.topUpTableViewCellClouse()
                }
            }, for: .touchUpInside)
            self.contentView.addSubview(coinsView)

        }
        coinsView.viewSetData(model: model)
        
    }
    
    func cellSetsData(model:AccountInfoModel){
        if coinsallCountView == nil {
            coinsallCountView = CoinsCountView.init(frame: CGRect.init(x: 0, y: 0 , width: SCREENWIDTH, height: 189))
            self.contentView.addSubview(coinsallCountView)
        }
        coinsallCountView.viewSetData(model: model)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            
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
