//
//  OutFallCategoryContentTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/9.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import ReactiveSwift

typealias TransButtonClickClouse = (_ indexPath:IndexPath) -> Void


class OutFallCategoryContentTableViewCell: UITableViewCell {

    var detailLabel:UILabel!
    var translateDetailLabel:UILabel!
    var translateButton:UIButton!
    var imageContentView:UIView!
    var indexPath:IndexPath!
    var transButtonClickClouse:TransButtonClickClouse!
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 15, y: 0, width: SCREENWIDTH - 30, height: 1))
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
        self.setUpView()
    }
    
    func setUpView(){
        
        detailLabel = UILabel.init()
        detailLabel.numberOfLines = 0
        detailLabel.textColor = App_Theme_666666_Color
        detailLabel.font = App_Theme_PinFan_M_14_Font
        
        self.contentView.addSubview(detailLabel)
        
        translateDetailLabel = UILabel.init()
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
        
        
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.top.equalTo(self.contentView.snp.top).offset(0)
            make.size.height.equalTo(20)
        }
        
        translateButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.top.equalTo(self.detailLabel.snp.bottom).offset(8)
        }
        
        translateDetailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.top.equalTo(self.translateButton.snp.bottom).offset(9)
            make.size.height.equalTo(0.0001)
        }
        
        imageContentView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.top.equalTo(self.translateDetailLabel.snp.bottom).offset(9)
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
    
    func cellSetData(content:String, translate:String, images:[String], isTrans:Bool, indexPath:IndexPath, transButtonClicks:@escaping TransButtonClickClouse){
        
        let stringHeight = content.nsString.height(with: App_Theme_PinFan_M_14_Font, constrainedToWidth: SCREENWIDTH - 30)
        detailLabel.snp.updateConstraints { (make) in
            make.size.height.equalTo(stringHeight)
        }
        detailLabel.text = content
        self.indexPath = indexPath
        translateDetailLabel.text = translate
        
        self.transButtonClickClouse = transButtonClicks
        
        if images.count > 1 {
            imageContentView.isHidden = false
            for index in 0...images.count - 1 {
                let image = UIImageView.init(frame: CGRect.init(x: 0 + CGFloat(index) * (contentImageWidth + 11), y: 0, width: contentImageWidth, height: contentImageHeight))
                UIImageViewManger.sd_imageView(url: images[index], imageView: image, placeholderImage: nil) { (image, error, cache, url) in
                    
                }
                image.layer.cornerRadius = 5
                image.layer.masksToBounds = true
                self.imageContentView.addSubview(image)
            }
            imageContentView.snp.updateConstraints{ (make) in
                make.height.equalTo(contentImageHeight)
            }
        }else{
            imageContentView.isHidden = true
            imageContentView.snp.updateConstraints{ (make) in
                make.height.equalTo(0.0001)
            }
            
        }
        
        if isTrans {
            let stringHeight = self.translateDetailLabel.text!.height(with: App_Theme_PinFan_M_14_Font, constrainedToWidth: SCREENWIDTH - 30)
            translateDetailLabel.snp.updateConstraints { (make) in
                make.size.height.equalTo(stringHeight)
            }
            translateButton.isEnabled = false
            translateButton.setTitle("已翻译", for: .normal)
            translateButton.setTitleColor(App_Theme_999999_Color, for: .normal)
        }else{
            translateDetailLabel.snp.updateConstraints { (make) in
                make.size.height.equalTo(0.0001)
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
