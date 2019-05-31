//
//  CoinsDetailTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/27.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class CoinsDetailTableViewCell: UITableViewCell {

    var conisImageView:UIImageView!
    var titleLabel:YYLabel!
    var timeLabel:YYLabel!
    var numberLabel:YYLabel!

    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: SCREENWIDTH, height: 1)))


    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        conisImageView = UIImageView.init()
        conisImageView.image = UIImage.init(named: "coins")
        self.contentView.addSubview(conisImageView)
        
        
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .left
        titleLabel.font = App_Theme_PinFan_M_14_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = ""
        self.contentView.addSubview(titleLabel)
       
        timeLabel = YYLabel.init()
        timeLabel.textAlignment = .left
        timeLabel.font = App_Theme_PinFan_M_10_Font
        timeLabel.textColor = App_Theme_999999_Color
        timeLabel.text = ""
        self.contentView.addSubview(timeLabel)
        
        
        numberLabel = YYLabel.init()
        numberLabel.textAlignment = .center
        numberLabel.font = App_Theme_PinFan_R_21_Font
        numberLabel.textColor = App_Theme_06070D_Color
        numberLabel.text = ""
        self.contentView.addSubview(numberLabel)
        
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetData(model:CoinsDetailModel){
        titleLabel.text = model.descriptionField
        timeLabel.text = model.createTime
        numberLabel.text = "\((model.type == "0" ? "-" : "+")) \(model.coin.string)"
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            conisImageView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.size.equalTo(CGSize.init(width: 34, height: 34))
            }
            
            numberLabel.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.width.equalTo(70).priority(1000)
            }
            
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView.snp.top).offset(17)
                make.left.equalTo(self.conisImageView.snp.right).offset(11)
                make.right.equalTo(self.numberLabel.snp.left).offset(-15)
            }
            
            timeLabel.snp.makeConstraints { (make) in
                make.top.equalTo(self.titleLabel.snp.bottom).offset(1)
                make.left.equalTo(self.conisImageView.snp.right).offset(11)
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
