//
//  AboutTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/9/9.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class AboutTableViewCell: UITableViewCell {

    var logoImage: UIImageView!
    var versionLabel: YYLabel!
    var appName:YYLabel!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        logoImage = UIImageView.init()
        logoImage.image = UIImage.init(named: "about_logo")
        self.contentView.addSubview(logoImage)
        
        
        versionLabel = YYLabel.init()
        versionLabel.textAlignment = .center
        versionLabel.font = App_Theme_PinFan_R_14_Font
        versionLabel.textColor = App_Theme_999999_Color
        versionLabel.text = versionCheck()
        self.contentView.addSubview(versionLabel)
        
        appName = YYLabel.init()
        appName.textAlignment = .center
        appName.font = App_Theme_PinFan_R_15_Font
        appName.textColor = App_Theme_06070D_Color
        appName.text = "version: \(disPlayName())"
        self.contentView.addSubview(appName)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            
            logoImage.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView.snp.top).offset(31)
                make.centerX.equalToSuperview()
            }
            
            appName.snp.makeConstraints { (make) in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.top.equalTo(self.logoImage.snp.bottom).offset(16)
            }
            
            versionLabel.snp.makeConstraints { (make) in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.top.equalTo(self.appName.snp.bottom).offset(11)
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
