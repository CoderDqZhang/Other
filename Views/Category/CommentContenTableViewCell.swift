//
//  CommentContenTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/9/2.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class CommentContenTableViewCell: UITableViewCell {

    var contnetLabel:YYLabel!
    var imageContentView:UIView!
    
    var model:TipModel!
    
    var postDetailContentTableViewCellClouse:PostDetailContentTableViewCellClouse!
    var postDetailContentTableViewCellImageClickClouse:PostDetailContentTableViewCellImageClickClouse!
    
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        
        contnetLabel = YYLabel.init()
        contnetLabel.numberOfLines = 0
        contnetLabel.textColor = App_Theme_2A2F34_Color
        contnetLabel.font = App_Theme_PinFan_M_15_Font
        
        self.contentView.addSubview(contnetLabel)
        
        imageContentView = UIView.init()
        self.contentView.addSubview(imageContentView)
        
        self.updateConstraints()
    }
    
    func cellSetData(model:CommentModel){
       
        if model.content != "" {
            _ = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_15_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: model.content, yyLabel: contnetLabel)
        }else{
            imageContentView.snp.remakeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.contentView.snp.top).offset(5)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-5)
            }
        }
        
        var tempImges:[String] = model.img.components(separatedBy: ",")
        let images = tempImges.removeAll("")
        if images.count >= 1 {
            var imageHeight:CGFloat = 0
            var count = 0
            //图片存在缓存问题是
            imageContentView.removeSubviews()
            for index in 0...images.count - 1 {
                let imageView = UIImageView.init()
                imageView.sd_downImageTools(url: String(images[index]), imageSize: nil, placeholderImage: nil) { (image, data, error, ret) in
                    if image != nil {
                        let size = image!.size
                        if size.width > SCREENWIDTH - 30 {
                            let height = size.height * (SCREENWIDTH - 30) / size.width
                            count = count + 1
                            imageView.frame = CGRect.init(origin: CGPoint.init(x: 0, y: imageHeight), size: CGSize.init(width: SCREENWIDTH - 30, height: height))
                            imageHeight = height + imageHeight + 10
                            imageView.image = image
                        }else{
                            count = count + 1
                            imageView.frame = CGRect.init(origin: CGPoint.init(x: (SCREENWIDTH - 30 - size.width) / 2, y: imageHeight), size: size)
                            imageHeight = size.height + imageHeight + 10
                            imageView.image = image
                        }
                    }
                }
                
                imageView.tag = index + 1000
                imageView.isUserInteractionEnabled = true
                _ = imageView.newTapGesture { (gesture) in
                    gesture.numberOfTapsRequired = 1
                    gesture.numberOfTouchesRequired = 1
                    }.whenTaped(handler: { (tap) in
                        if self.postDetailContentTableViewCellImageClickClouse != nil {
                            self.postDetailContentTableViewCellImageClickClouse(tap.view!.tag,SKPhotoBrowserManager.getSharedInstance().setUpBrowserWithStrUrl(urls: images, selectPageIndex: tap.view!.tag - 1000))
                        }
                    })
                imageView.layer.masksToBounds = true
                self.imageContentView.addSubview(imageView)
            }
        }else{
            imageContentView.isHidden = true
            imageContentView.snp.makeConstraints{ (make) in
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
            
            contnetLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.contentView.snp.top).offset(15)
                make.height.equalTo(0.0001)
            }
            
            imageContentView.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.contnetLabel.snp.bottom).offset(25)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-5)
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
