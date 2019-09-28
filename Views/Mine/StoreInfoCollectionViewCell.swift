//
//  StoreInfoCollectionViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class StoreInfoCollectionViewCell: UICollectionViewCell {
    
    var imageView:UIImageView!
    var titleLabel:YYLabel!
    var storeLabel:YYLabel!
    var buttonLabel:YYLabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
        self.contentView.layer.cornerRadius = 4
        setMutiBorderRoundingCorners(self.contentView, corner: 10, byRoundingCorners: [UIRectCorner.topLeft,UIRectCorner.topRight,UIRectCorner.bottomRight,UIRectCorner.bottomLeft])
        self.setUpView()
    }
    
    func setUpView(){
        imageView = UIImageView.init()
        self.contentView.addSubview(imageView)
        
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .center
        titleLabel.font = App_Theme_PinFan_R_14_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = ""
        self.contentView.addSubview(titleLabel)
        
        storeLabel = YYLabel.init()
        storeLabel.textAlignment = .center
        storeLabel.font = App_Theme_PinFan_R_12_Font
        storeLabel.textColor = App_Theme_06070D_Color
        storeLabel.text = ""
        self.contentView.addSubview(storeLabel)
        
        
        buttonLabel = YYLabel.init()
        buttonLabel.cornerRadius = 14
        buttonLabel.backgroundColor = App_Theme_FFD512_Color
        buttonLabel.textAlignment = .center
        buttonLabel.font = App_Theme_PinFan_M_12_Font
        buttonLabel.textColor = App_Theme_FFFFFF_Color
        buttonLabel.text = "立即兑换"
        self.contentView.addSubview(buttonLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(8)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: self.frame.size.width - 16, height: (self.frame.size.width - 16) * 83 / 142 ))
        }
        
        buttonLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 70, height: 27))
        }
        
        storeLabel.snp.makeConstraints { (make) in
            
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.buttonLabel.snp.top).offset(0)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(self.storeLabel.snp.top).offset(0)
            
        }
        
    }
    
    func cellSetData(model:StoreInfoModel){
        imageView.sd_crope_imageView_withMaxWidth(url: model.image, imageSize: CGSize.init(width: 108, height: 75), placeholderImage: nil) { (image, error, cacheType, url) in
            if error == nil {
                let imageSize = UIImageMaxCroped.cropeImage(image: image!, imageViewSize:  CGSize.init(width: self.frame.size.width - 16, height: (self.frame.size.width - 16) * 83 / 142 ))
                self.imageView.image = imageSize
            }
        }
        titleLabel.text = model.title
        let nsStr = NSMutableAttributedString.init(string: "\(String(describing: model.price!))积分")
        nsStr.addAttributes([NSAttributedString.Key.font : App_Theme_PinFan_R_12_Font!,NSAttributedString.Key.foregroundColor:App_Theme_FF7800_Color!], range: NSRange.init(location: 0, length: nsStr.length - 2))
        nsStr.addAttributes([NSAttributedString.Key.font : App_Theme_PinFan_R_12_Font!,NSAttributedString.Key.foregroundColor:App_Theme_06070D_Color!], range: NSRange.init(location: nsStr.length - 2, length: 2))
        storeLabel.attributedText = nsStr
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
