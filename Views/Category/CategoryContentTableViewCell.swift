//
//  CategoryContentTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import SKPhotoBrowser

// 108 / 77
let contentWidth:CGFloat = SCREENWIDTH - 30
let contentImageWidth:CGFloat = (SCREENWIDTH - 30 - 11 * 2) / 3
let contentImageHeight:CGFloat = contentImageWidth * 77 / 108

class CategoryContentTableViewCell: UITableViewCell {

    var detailLabel:YYLabel!
    var deleteLabel:YYLabel!
    
    var imageContentView:UIView!
    var model:TipModel!
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 15, y: 0, width: SCREENWIDTH - 30, height: 1))
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
        self.setUpView()
    }
    
    func setUpView(){
        
        detailLabel = YYLabel.init()
        detailLabel.numberOfLines = 0
        detailLabel.textColor = App_Theme_666666_Color
        detailLabel.font = App_Theme_PinFan_M_14_Font
        
        self.contentView.addSubview(detailLabel)
        
        deleteLabel = YYLabel.init()
        deleteLabel.numberOfLines = 0
        deleteLabel.textColor = App_Theme_666666_Color
        deleteLabel.font = App_Theme_PinFan_M_12_Font
        
        self.contentView.addSubview(deleteLabel)
        
        imageContentView = UIView.init()
        self.contentView.addSubview(imageContentView)
        self.contentView.addSubview(lineLabel)
        self.updateConstraints()
    }
    
    func cellSetData(tipmodel:TipModel){
        deleteLabel.isHidden = true
        _ = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_14_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: tipmodel.title, yyLabel: detailLabel)
        
        let images = tipmodel.image.split(separator: ",")

        if images.count >= 1 {
            imageContentView.removeSubviews()
            for index in 0...images.count - 1 {
                let imageView = UIImageView.init(frame: CGRect.init(x: 0 + CGFloat(index) * (contentImageWidth + 11), y: 0, width: contentImageWidth, height: contentImageHeight))
                
//                imageView.sd_crope_imageView_withMaxWidth(url: String(images[index]).nsString.replacingOccurrences(of: " ", with: ""), imageSize: CGSize.init(width: contentImageWidth, height: contentImageHeight), placeholderImage: nil) { (image, error, cacheType, url) in
//                    if error == nil {
//                        let imageSize = UIImageMaxCroped.cropeImage(image: image!, imageViewSize:  CGSize.init(width: contentImageWidth, height: contentImageHeight))
//                        imageView.image = imageSize
//                    }
//                }
                imageView.sd_crope_imageView(url: String(images[index]).nsString.replacingOccurrences(of: " ", with: ""), imageView: imageView, placeholderImage: nil) { (image, url, type, state, error) in
                }
                imageView.tag = index + 1000
                imageView.layer.cornerRadius = 5
                imageView.layer.masksToBounds = true
                self.imageContentView.addSubview(imageView)
            }
            imageContentView.isHidden = false
            imageContentView.snp.updateConstraints{ (make) in
                make.height.equalTo(contentImageHeight)
            }
        }else{
            imageContentView.isHidden = true
            imageContentView.snp.updateConstraints{ (make) in
                make.height.equalTo(0.0001)
            }
        }
        self.contentView.updateConstraintsIfNeeded()
    
    }
    
    func deleteCellData(tipmodel:TipModel){
         deleteLabel.isHidden = false
        _ = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_14_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: tipmodel.title, yyLabel: detailLabel)
        imageContentView.isHidden = true
        detailLabel.textColor = App_Theme_999999_Color
        imageContentView.snp.updateConstraints{ (make) in
            make.height.equalTo(20)
        }
        
        _ = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_12_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: "-该帖因不符合平台管理规定，已被管理员删除。", yyLabel: deleteLabel)
        self.contentView.addSubview(deleteLabel)
        deleteLabel.textColor = App_Theme_FB5D5D_Color
        deleteLabel.snp.makeConstraints { (make) in
            make.top.equalTo(detailLabel.snp.bottom).offset(6)
            make.left.equalTo(detailLabel.snp.left).offset(0)
        }
        self.contentView.updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            detailLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.height.equalTo(0.0001)
            }
            
            imageContentView.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.detailLabel.snp.bottom).offset(8)
                make.height.equalTo(0.0001)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-12)
            }
            
            
            lineLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
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
