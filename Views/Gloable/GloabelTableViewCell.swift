
//
//  GloabelTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/16.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import Foundation

class TitleLableAndDetailLabelDescRight:UITableViewCell {
    
    
    var titleLabel:YYLabel!
    var descLabel:YYLabel!
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 1))
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
        self.accessoryType = .disclosureIndicator
    }
    
    func setUpView(){
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .left
        titleLabel.font = App_Theme_PinFan_M_15_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = ""
        self.contentView.addSubview(titleLabel)
        
        descLabel = YYLabel.init()
        descLabel.textAlignment = .right
        descLabel.font = App_Theme_PinFan_R_12_Font
        descLabel.textColor = App_Theme_FF7800_Color
        descLabel.text = ""
        self.contentView.addSubview(descLabel)
        
        self.contentView.addSubview(lineLabel)
        self.updateConstraints()
    }
    
    func cellSetData(title:String, desc:String, isDescHidden:Bool){
        titleLabel.text = title
        descLabel.text = desc
        self.descLabel.isHidden = isDescHidden
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
                make.width.equalTo(200)
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
