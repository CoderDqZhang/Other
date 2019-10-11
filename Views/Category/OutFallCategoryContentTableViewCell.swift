//
//  OutFallCategoryContentTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/9.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import ReactiveSwift
import SKPhotoBrowser

typealias TransButtonClickClouse = (_ indexPath:IndexPath) -> Void
typealias OutFallCategoryContentImageClick  = (_ tag:Int, _ photoBrowser:SKPhotoBrowser) ->Void


class OutFallCategoryContentTableViewCell: UITableViewCell {

    var detailLabel:YYLabel!
    var translateDetailLabel:YYLabel!
    var translateButton:UIButton!
    var imageContentView:UIView!
    var indexPath:IndexPath!
    var transButtonClickClouse:TransButtonClickClouse!
    
    var outFallCategoryContentImageClick:OutFallCategoryContentImageClick!
//    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 15, y: 0, width: SCREENWIDTH - 30, height: 1))
    
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
        
        translateDetailLabel = YYLabel.init()
        translateDetailLabel.numberOfLines = 0
        translateDetailLabel.textColor = App_Theme_666666_Color
        translateDetailLabel.font = App_Theme_PinFan_M_14_Font
        self.contentView.addSubview(translateDetailLabel)
        
        
        translateButton = UIButton.init(type: .custom)
        translateButton.setTitle("查看翻译", for: .normal)
        translateButton.setTitleColor(App_Theme_5AA7FE_Color, for: .normal)
        translateButton.addTarget(self, action: #selector(translateButtonClick), for: .touchUpInside)
        translateButton.titleLabel?.font = App_Theme_PinFan_M_12_Font
        self.contentView.addSubview(translateButton)
        
        imageContentView = UIView.init()
        self.contentView.addSubview(imageContentView)
        
//        self.contentView.addSubview(lineLabel)
        
        self.updateConstraints()
    }
    
    func cellSetData(model:OutFallModel, isTrans:Bool, indexPath:IndexPath, transButtonClicks:@escaping TransButtonClickClouse){
        
         _ = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_14_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: model.content, yyLabel: detailLabel)
        
        if model.cnContent != nil {
            _ = YYLaoutTextGloabelManager.getSharedInstance().setYYLabelTextBound(font: App_Theme_PinFan_M_14_Font!, size: CGSize.init(width: SCREENWIDTH - 30, height: 1000), str: model.cnContent, yyLabel: translateDetailLabel)
        }
        if isTrans {
            translateButton.isEnabled = false
            translateDetailLabel.isHidden = false
            translateButton.setTitle("已翻译", for: .normal)
            translateButton.setTitleColor(App_Theme_999999_Color, for: .normal)
        }else{
            translateDetailLabel.isHidden = true
            translateButton.isEnabled = true
            translateButton.setTitle("查看翻译", for: .normal)
            translateButton.setTitleColor(App_Theme_5AA7FE_Color, for: .normal)

        }
        
        
        self.indexPath = indexPath
        
        self.transButtonClickClouse = transButtonClicks
        let images = model.image.split(separator: ",")
        if images.count >= 1 {
            imageContentView.isHidden = false
            imageContentView.removeSubviews()
            for index in 0...images.count - 1 {
                let imageView = UIImageView.init(frame: CGRect.init(x: 0 + CGFloat(index % 3) * (contentImageWidth + 11), y: 0 + (contentImageHeight + 10) * CGFloat((index / 3)), width: contentImageWidth, height: contentImageHeight))
                imageView.sd_crope_imageView(url: String(images[index]), imageView: imageView, placeholderImage: nil) { (image, url, type, state, error) in
                    
                }
                imageView.layer.cornerRadius = 5
                imageView.layer.masksToBounds = true
                imageView.tag = index + 1000
                imageView.isUserInteractionEnabled = true
                _ = imageView.newTapGesture { (gesture) in
                    gesture.numberOfTapsRequired = 1
                    gesture.numberOfTouchesRequired = 1
                    }.whenTaped(handler: { (tap) in
                        if self.outFallCategoryContentImageClick != nil {
                            self.outFallCategoryContentImageClick(tap.view!.tag,SKPhotoBrowserManager.getSharedInstance().setUpBrowserWithUrl(urls: images, selectPageIndex: tap.view!.tag - 1000))
                        }
                    })
                self.imageContentView.addSubview(imageView)
            }
            imageContentView.snp.updateConstraints{ (make) in
                make.height.equalTo(contentImageHeight + (contentImageHeight + 10) * CGFloat((images.count / 4)))
            }
        }else{
            imageContentView.isHidden = true
            imageContentView.snp.updateConstraints{ (make) in
                make.height.equalTo(0.0001)
            }
            
        }
        self.contentView.updateConstraintsIfNeeded()
        
    }
    
    @objc func translateButtonClick(){
        self.transButtonClickClouse(self.indexPath)
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
            
            translateButton.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.top.equalTo(self.detailLabel.snp.bottom).offset(8)
            }
            
            translateDetailLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.translateButton.snp.bottom).offset(9)
                make.height.equalTo(0.0001)
            }
            
            imageContentView.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-12)
                make.height.equalTo(0.001)
            }
            
//            lineLabel.snp.makeConstraints { (make) in
//                make.left.equalTo(self.contentView.snp.left).offset(15)
//                make.right.equalTo(self.contentView.snp.right).offset(-15)
//                make.bottom.equalTo(self.contentView.snp.bottom).offset(-1)
//                make.height.equalTo(1)
//            }
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
