//
//  PostDetailCommentTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/10.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class SecondeModel: NSObject {
    
    var userNameStr:String!
    var contentStr:String!
    init(name:String, content:String) {
        userNameStr = name
        contentStr = content
    }
}

class PostDetailCommentTableViewCell: UITableViewCell {

    var contentLabel:UILabel!
    var imageContentView:UIView!
    var secondeContent:UIView!
    
    var allCommentLabel:UILabel!
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: SCREENWIDTH, height: 1)))
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        
        contentLabel = UILabel.init()
        contentLabel.numberOfLines = 3
        contentLabel.text = "鲁尼也是一代红魔传说"
        contentLabel.textAlignment = .center
        contentLabel.font = App_Theme_PinFan_M_14_Font
        contentLabel.textColor = App_Theme_06070D_Color
        self.contentView.addSubview(contentLabel)
        
        secondeContent = UIView.init()
        secondeContent.backgroundColor = App_Theme_F6F6F6_Color
        self.contentView.addSubview(secondeContent)
        
        
        imageContentView = UIView.init()
        self.contentView.addSubview(imageContentView)
        
        allCommentLabel = UILabel.init()
        allCommentLabel.font = App_Theme_PinFan_M_10_Font
        allCommentLabel.backgroundColor = App_Theme_666666_Color
        secondeContent.addSubview(allCommentLabel)
        
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(45)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.top.equalTo(self.contentView.snp.top).offset(0)
            make.size.height.equalTo(20)
        }
        
        imageContentView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(44)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.top.equalTo(self.contentLabel.snp.bottom).offset(8)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-12)
            make.size.height.equalTo(0.001)
        }
        
        secondeContent.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(44)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.top.equalTo(self.imageContentView.snp.bottom).offset(8)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-17)
            make.size.height.equalTo(0.001)
        }
        
        allCommentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(secondeContent.snp.left).offset(9)
            make.right.equalTo(secondeContent.snp.right).offset(-9)
            make.top.equalTo(secondeContent.snp.bottom).offset(9)
            make.bottom.equalTo(secondeContent.snp.bottom).offset(-9)
        }
        
        allCommentLabel.isHidden = true
        
        self.updateConstraints()
    }
    
    func cellSetData(images:[String],secondeContents:[SecondeModel],content:String){
        let stringHeight = content.nsString.height(with: App_Theme_PinFan_M_14_Font, constrainedToWidth: SCREENWIDTH - 70)
        contentLabel.snp.updateConstraints { (make) in
            make.size.height.equalTo(stringHeight)
        }
        contentLabel.text = content
        
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
        
        switch secondeContents.count {
            case 0:
                secondeContent.snp.updateConstraints{ (make) in
                    make.height.equalTo(0.0001)
                }
        case 1:
            let detailContent = self.createSecondeContentLabel(username: secondeContents[0].userNameStr, content: secondeContents[0].contentStr)
            secondeContent.addSubview(detailContent)
            secondeContent.snp.updateConstraints{ (make) in
                make.height.equalTo(28)
            }
        case 2:
            let detailContent = self.createSecondeContentLabel(username: secondeContents[0].userNameStr, content: secondeContents[0].contentStr)
            secondeContent.addSubview(detailContent)
            secondeContent.snp.updateConstraints{ (make) in
                make.height.equalTo(46)
            }
        default:
            for model in secondeContents {
                let detailContent = self.createSecondeContentLabel(username: model.userNameStr, content: model.contentStr)
                secondeContent.addSubview(detailContent)
            }
            secondeContent.snp.updateConstraints{ (make) in
                make.height.equalTo(52)
            }
            allCommentLabel.isHidden = false
        }
        
        self.contentView.updateConstraintsIfNeeded()
    }
    
    func createSecondeContentLabel(username:String,content:String) -> UIView{
        let contentView = UIView.init()
        
        let userName  = UILabel.init()
        userName.text = username
        userName.textAlignment = .center
        userName.font = App_Theme_PinFan_M_10_Font
        userName.textColor = App_Theme_999999_Color
        contentView.addSubview(userName)
        
        let contentName  = UILabel.init()
        contentName.text = content
        contentName.textAlignment = .center
        contentName.font = App_Theme_PinFan_M_10_Font
        contentName.textColor = App_Theme_666666_Color
        contentView.addSubview(contentName)
        
        
        userName.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(0)
            make.top.equalTo(contentView.snp.top).offset(0)
            make.bottom.equalTo(contentView.snp.bottom).offset(0)
        }
        
        
        contentName.snp.makeConstraints { (make) in
            make.left.equalTo(userName.snp.left).offset(9)
            make.right.equalTo(contentView.snp.right).offset(0)
            make.top.equalTo(contentView.snp.top).offset(0)
            make.bottom.equalTo(contentView.snp.bottom).offset(0)
        }
        return contentView
        
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
