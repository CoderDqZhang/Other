//
//  SquareTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/15.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import YYImage

class SquareTableViewCell: UITableViewCell {

    var postImageView:UIImageView!
    var titleLabel:YYLabel!
    var descLabel:YYLabel!
    var hotImageView:UIImageView!
    var readNumberLabel:YYLabel!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        postImageView = UIImageView.init()
        postImageView.layer.cornerRadius = 5
        postImageView.layer.masksToBounds = true
        self.contentView.addSubview(postImageView)
        
        hotImageView = UIImageView.init()
        hotImageView.image = UIImage.init(named: "hot")
        self.contentView.addSubview(hotImageView)
        
        titleLabel = YYLabel.init()
        titleLabel.font = App_Theme_PinFan_M_15_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.numberOfLines = 2
        titleLabel.text = "巴塞罗那今晚必定夺冠，巴塞罗那\n今晚必定夺冠"
        self.contentView.addSubview(titleLabel)
        
        descLabel = YYLabel.init()
        descLabel.textAlignment = .left
        descLabel.font = App_Theme_PinFan_R_12_Font
        descLabel.textColor = App_Theme_999999_Color
        descLabel.text = "国内足球"
        self.contentView.addSubview(descLabel)
        
        readNumberLabel = YYLabel.init()
        readNumberLabel.textAlignment = .left
        readNumberLabel.font = App_Theme_PinFan_M_10_Font
        readNumberLabel.textColor = App_Theme_FB5D5D_Color
        readNumberLabel.text = "12.9k"
        self.contentView.addSubview(readNumberLabel)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetData(model:ArticleInfoModel){
        
        postImageView.sd_crope_imageView_withMaxWidth(url: model.image, imageSize: CGSize.init(width: 108, height: 75), placeholderImage: nil) { (image, error, cacheType, url) in
            if error == nil {
                let resultImage = UIImageMaxCroped.cropeImage(image: image!, imageViewSize:  CGSize.init(width: 108, height: 75))
                self.postImageView.image = resultImage
            }
        }
    
        _ = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_15_Font!, size: CGSize.init(width: SCREENWIDTH - 153, height: 1000), str: model.title, yyLabel: titleLabel)
        
        descLabel.text = model.origin
        if model.clickNum < 10000 {
            readNumberLabel.text = "\(String(describing: model.clickNum!))"
        }else{
            readNumberLabel.text = "\(model.clickNum.kFormatted)"
        }
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            postImageView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.size.equalTo(CGSize.init(width: 108, height: 75))
            }
            
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView.snp.top).offset(15)
                make.height.equalTo(1)
                make.left.equalTo(self.postImageView.snp.right).offset(14)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            }
            
            descLabel.snp.makeConstraints { (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-15)
                make.left.equalTo(self.postImageView.snp.right).offset(14)
                make.right.equalTo(self.contentView.snp.right).offset(-75)
            }
            
            readNumberLabel.snp.makeConstraints { (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-13)
            }
            
            hotImageView.snp.makeConstraints { (make) in
                make.right.equalTo(self.readNumberLabel.snp.left).offset(-5)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-15)
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
