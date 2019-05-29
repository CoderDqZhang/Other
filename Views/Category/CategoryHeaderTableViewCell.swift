//
//  CategoryHeaderTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class CategoryHeaderTableViewCell: UITableViewCell {

    var backImageView:UIImageView!
    var logoImageView:UIImageView!
    var categoryName:YYLabel!
    var categoryDetailLabel:YYLabel!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        backImageView = UIImageView.init()
        self.contentView.addSubview(backImageView)
        
        logoImageView = UIImageView.init()
        logoImageView.layer.cornerRadius = 26
        logoImageView.borderColor = App_Theme_F6F6F6_Color
        logoImageView.borderWidth = 2
        logoImageView.layer.masksToBounds = true
        self.contentView.addSubview(logoImageView)
        
        categoryName = YYLabel.init(frame: CGRect.init(x: 0, y: ImageHeith, width: CategoryViewWidth, height: CategoryViewHeight - ImageHeith))
        categoryName.text = "皇家马德里"
        categoryName.textAlignment = .center
        categoryName.font = App_Theme_PinFan_R_18_Font
        categoryName.textColor = App_Theme_FFFFFF_Color
        self.addSubview(categoryName)
        
        
        categoryDetailLabel = YYLabel.init(frame: CGRect.init(x: 0, y: ImageHeith, width: CategoryViewWidth, height: CategoryViewHeight - ImageHeith))
        categoryDetailLabel.text = "皇家马德里皇家马德里"
        categoryDetailLabel.textAlignment = .center
        categoryDetailLabel.font = App_Theme_PinFan_R_14_Font
        categoryDetailLabel.textColor = App_Theme_FFFFFF_Color
        self.addSubview(categoryDetailLabel)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetData(model:CategoryModel){
        
        UIImageViewManger.sd_imageView(url: model.tribeImg.nsString.replacingOccurrences(of: " ", with: ""), imageView: logoImageView, placeholderImage: nil) { (image, error, cache, url) in
            if error == nil {
                self.logoImageView.image = image
                self.backImageView.image = image
                self.backImageView.blur(withStyle: UIBlurEffect.Style.light)
            }
        }
        categoryName.text = model.tribeName
        categoryDetailLabel.text = model.descriptionField
    }
    
    override func updateConstraints() {
        if !didMakeConstraints {
            backImageView.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.left.equalToSuperview()
                make.right.equalToSuperview()
            }
            
            logoImageView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                if #available(iOS 11.0, *) {
                    make.centerY.equalTo(self.contentView.snp.centerY).offset(NAV_HEIGHT / 2)
                } else {
                    make.centerY.equalToSuperview()
                    // Fallback on earlier versions
                }
                make.size.equalTo(CGSize.init(width: 56, height: 56))
            }
            
            categoryName.snp.makeConstraints { (make) in
                make.top.equalTo(self.logoImageView.snp.bottom).offset(9)
                make.centerX.equalToSuperview()
                make.left.equalToSuperview()
                make.right.equalToSuperview()
            }
            
            categoryDetailLabel.snp.makeConstraints { (make) in
                make.top.equalTo(self.categoryName.snp.bottom).offset(6)
                make.centerX.equalToSuperview()
                make.left.equalToSuperview()
                make.right.equalToSuperview()
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
