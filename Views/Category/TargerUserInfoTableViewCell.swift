//
//  TargerUserInfoTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/15.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class TargerUserInfoTableViewCell: UITableViewCell {
    
    var tarInfoLabel:YYLabel!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        
        tarInfoLabel = YYLabel.init()
        tarInfoLabel.textAlignment = .left
        tarInfoLabel.font = App_Theme_PinFan_M_14_Font
        tarInfoLabel.textColor = App_Theme_999999_Color
        tarInfoLabel.text = ""
        self.contentView.addSubview(tarInfoLabel)
        
        self.updateConstraints()
    }
    
    func cellSetData(str:String) {
        tarInfoLabel.text = str
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            tarInfoLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
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
