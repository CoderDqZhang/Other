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
    var imageContentView:UIView!
    
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
        
        imageContentView = UIView.init()
        self.contentView.addSubview(imageContentView)
        
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.top.equalTo(self.contentView.snp.top).offset(0)
            make.size.height.equalTo(20)
        }
        
        imageContentView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.top.equalTo(self.detailLabel.snp.bottom).offset(8)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-12)
            make.size.height.equalTo(0.001)
        }
        
        self.contentView.addSubview(lineLabel)
       
        lineLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-1)
            make.size.height.equalTo(1)
        }
        
        self.updateConstraints()
    }
    
    func cellSetData(tipmodel:TipModel){
        let stringHeight = tipmodel.title.nsString.height(with: App_Theme_PinFan_M_14_Font, constrainedToWidth: SCREENWIDTH - 30)
        detailLabel.snp.updateConstraints { (make) in
            make.size.height.equalTo(stringHeight)
        }
        detailLabel.text = tipmodel.title
        let images = tipmodel.image.split(separator: ",")

        if images.count > 1 {
            for index in 0...images.count - 1 {
                let imageView = UIImageView.init(frame: CGRect.init(x: 0 + CGFloat(index) * (contentImageWidth + 11), y: 0, width: contentImageWidth, height: contentImageHeight))
                UIImageViewManger.sd_imageView(url: String(images[index]), imageView: imageView, placeholderImage: nil) { (image, error, cache, url) in
                    if error == nil {
                        imageView.image = image
                    }
                }
                imageView.layer.cornerRadius = 5
                imageView.layer.masksToBounds = true
                self.imageContentView.addSubview(imageView)
            }
            imageContentView.snp.updateConstraints{ (make) in
                make.height.equalTo(contentImageHeight)
            }
        }else{
            imageContentView.snp.updateConstraints{ (make) in
                make.height.equalTo(0.0001)
            }
        }
        
        

        self.contentView.updateConstraintsIfNeeded()

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
