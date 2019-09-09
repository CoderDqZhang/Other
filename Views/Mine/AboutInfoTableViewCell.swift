//
//  AboutInfoTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/9/9.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class AboutInfoTableViewCell: UITableViewCell {

    var companyNameZh:YYLabel!
    var companyNameEn:YYLabel!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        companyNameZh = YYLabel.init()
        companyNameZh.textAlignment = .center
        companyNameZh.font = App_Theme_PinFan_M_11_Font
        companyNameZh.textColor = App_Theme_999999_Color
        companyNameZh.text = "投球（厦门）网络科技有限公司"
        self.contentView.addSubview(companyNameZh)
        
        companyNameEn = YYLabel.init()
        companyNameEn.textAlignment = .center
        companyNameEn.font = App_Theme_PinFan_M_11_Font
        companyNameEn.textColor = App_Theme_999999_Color
        companyNameEn.text = "TouQiu (XiaMen) Web Science and Technology CO . , LTD ."
        self.contentView.addSubview(companyNameEn)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            companyNameZh.snp.makeConstraints { (make) in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalTo(companyNameEn.snp.top).offset(-7)
            }
            
            companyNameEn.snp.makeConstraints { (make) in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-27)
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
