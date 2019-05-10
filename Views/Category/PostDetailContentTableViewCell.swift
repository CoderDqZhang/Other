//
//  PostDetailContentTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
enum PostDetailContentTableViewCellButtonType {
    case like
    case collect
}
typealias PostDetailContentTableViewCellClouse = (_ type:PostDetailContentTableViewCellButtonType) -> Void
class PostDetailContentTableViewCell: UITableViewCell {

    var titleLabel:UILabel!
    var contnetLabel:UILabel!
    var likeButton:CustomViewButtonTopImageAndBottomLabel!
    var collectButton:CustomViewButtonTopImageAndBottomLabel!
    var likeButtonView:UIView!
    var collectButtonView:UIView!
    var imageContentView:UIView!
    
    var postDetailContentTableViewCellClouse:PostDetailContentTableViewCellClouse!
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        
        titleLabel = UILabel.init()
        titleLabel.numberOfLines = 0
        titleLabel.textColor = App_Theme_2A2F34_Color
        titleLabel.font = App_Theme_PinFan_M_18_Font
        
        self.contentView.addSubview(titleLabel)
        
        contnetLabel = UILabel.init()
        contnetLabel.numberOfLines = 0
        contnetLabel.textColor = App_Theme_2A2F34_Color
        contnetLabel.font = App_Theme_PinFan_M_15_Font
        
        self.contentView.addSubview(contnetLabel)
        
        imageContentView = UIView.init()
        self.contentView.addSubview(imageContentView)
        
        likeButtonView = UIView.init()
        self.contentView.addSubview(likeButtonView)
        
        collectButtonView = UIView.init()
        self.contentView.addSubview(collectButtonView)
        
        likeButton = CustomViewButtonTopImageAndBottomLabel.init( frame: CGRect.init(x: 0, y: 0, width: 34, height: 34), title: "666", image: UIImage.init(named: "post_detail_like")!, tag: 1, titleColor: App_Theme_B5B5B5_Color!, spacing: 7, font: App_Theme_PinFan_R_12_Font!, click: {
            self.likeButton.imageView.image = UIImage.init(named: "post_detail_like_select")
            self.postDetailContentTableViewCellClouse(.like)
        })
        
        likeButtonView.addSubview(likeButton)
        
        collectButton = CustomViewButtonTopImageAndBottomLabel.init(frame: CGRect.init(x: UIImage.init(named: "post_detail_like")!.size.width + 25, y: 0, width: 34, height: 34), title: "喜欢", image: UIImage.init(named: "post_detail_collect")!, tag: 2, titleColor: App_Theme_B5B5B5_Color!, spacing: 7, font: App_Theme_PinFan_R_12_Font!, click: {
            self.collectButton.imageView.image = UIImage.init(named: "post_detail_collect_select")
            self.postDetailContentTableViewCellClouse(.collect)
        })
        
        collectButtonView.addSubview(collectButton)
        
        
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.top.equalTo(self.contentView.snp.top).offset(0)
            make.size.height.equalTo(18)
        }
        
        contnetLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(25)
            make.size.height.equalTo(15)
        }
        
        imageContentView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.top.equalTo(self.contnetLabel.snp.bottom).offset(25)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-82)
            make.size.height.equalTo(0.001)
        }
        
        likeButtonView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView.snp.centerX).offset(-35)
            make.top.equalTo(self.imageContentView.snp.bottom).offset(17)
            make.size.equalTo(CGSize.init(width: 43, height: 63))
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-12)
        }
        
        collectButtonView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView.snp.centerX).offset(35)
            make.top.equalTo(self.imageContentView.snp.bottom).offset(17)
            make.size.equalTo(CGSize.init(width: 43, height: 63))
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-12)
        }
        
       
        self.updateConstraints()
    }
    
    func cellSetData(title:String,content:String, images:[String]){
        
        let titleHeight = title.nsString.height(with: App_Theme_PinFan_M_18_Font, constrainedToWidth: SCREENWIDTH - 30)
        titleLabel.snp.updateConstraints { (make) in
            make.size.height.equalTo(titleHeight)
        }
        titleLabel.text = title
        
        let contentHeight = content.nsString.height(with: App_Theme_PinFan_M_15_Font, constrainedToWidth: SCREENWIDTH - 30)
        contnetLabel.snp.updateConstraints { (make) in
            make.size.height.equalTo(contentHeight)
        }
        contnetLabel.text = content
        
        if images.count > 1 {
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
            imageContentView.snp.updateConstraints{ (make) in
                make.height.equalTo(0.0001)
            }
        }
        
        likeButton.snp.updateConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 47, height: 47))
        }
        
        collectButton.snp.updateConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 47, height: 47))
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
