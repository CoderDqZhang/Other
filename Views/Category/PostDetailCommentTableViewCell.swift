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

let SecondeContentHeight:CGFloat = 18
let SecondeContentWidth:CGFloat = SCREENWIDTH - 66

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
        self.backgroundColor = .red
    }
    
    func setUpView(){
        
        contentLabel = UILabel.init()
        contentLabel.numberOfLines = 3
        contentLabel.text = "鲁尼也是一代红魔传说"
        contentLabel.textAlignment = .left
        contentLabel.font = App_Theme_PinFan_M_14_Font
        contentLabel.textColor = App_Theme_06070D_Color
        self.contentView.addSubview(contentLabel)
        
        secondeContent = UIView.init()
        secondeContent.backgroundColor = App_Theme_F6F6F6_Color
        self.contentView.addSubview(secondeContent)
        
        
        imageContentView = UIView.init()
        self.contentView.addSubview(imageContentView)
        
        allCommentLabel = UILabel.init()
        allCommentLabel.text = "查看全部11条回复"
        allCommentLabel.textColor = App_Theme_666666_Color
        allCommentLabel.font = App_Theme_PinFan_M_10_Font
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
            make.left.equalTo(secondeContent.snp.left).offset(0)
            make.right.equalTo(secondeContent.snp.right).offset(0)
            make.bottom.equalTo(secondeContent.snp.bottom).offset(-9)
        }
        
        imageContentView.isHidden = true
        secondeContent.isHidden = true
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
            secondeContent.snp.remakeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(44)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.contentLabel.snp.bottom).offset(8)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-17)
                make.size.height.equalTo(0.001)
            }
        }
        
        switch secondeContents.count {
            
            case 0:
                secondeContent.isHidden = true
                secondeContent.snp.updateConstraints{ (make) in
                    make.height.equalTo(0.0001)
                }
            case 1:
                secondeContent.isHidden = false
                let detailContent = self.createSecondeContentLabel(index: 0, username: secondeContents[0].userNameStr, content: secondeContents[0].contentStr)
                secondeContent.addSubview(detailContent)
                secondeContent.snp.updateConstraints{ (make) in
                    make.height.equalTo(SecondeContentHeight + 10)
                }
            case 2:
                secondeContent.isHidden = false
                for index in 0...secondeContents.count - 1 {
                    let detailContent = self.createSecondeContentLabel(index: index, username: secondeContents[index].userNameStr, content: secondeContents[index].userNameStr)
                    secondeContent.addSubview(detailContent)
                }
                secondeContent.snp.updateConstraints{ (make) in
                    make.height.equalTo(2 * SecondeContentHeight + 10)
                }
            default:
                secondeContent.isHidden = false
                for index in 0...1 {
                    let detailContent = self.createSecondeContentLabel(index: index, username: secondeContents[index].userNameStr, content: secondeContents[index].userNameStr)
                    secondeContent.addSubview(detailContent)
                }
                secondeContent.snp.updateConstraints{ (make) in
                    make.height.equalTo(3 * SecondeContentHeight + 10)
                }
                
                allCommentLabel.isHidden = false
        }
        
        self.contentView.updateConstraintsIfNeeded()
    }
    
    func createSecondeContentLabel(index:Int, username:String,content:String) -> UIView{
        let contentView = UIView.init(frame: CGRect.init(x: 0, y: 5 + CGFloat(index) * SecondeContentHeight, width: SecondeContentWidth, height: SecondeContentHeight))
        
        let userName  = UILabel.init()
        userName.text = "\(username):"
        userName.textAlignment = .left
        userName.font = App_Theme_PinFan_M_10_Font
        userName.textColor = App_Theme_999999_Color
        contentView.addSubview(userName)
        
        let contentName  = UILabel.init()
        contentName.text = content
        contentName.textAlignment = .left
        contentName.font = App_Theme_PinFan_M_10_Font
        contentName.textColor = App_Theme_666666_Color
        contentView.addSubview(contentName)
        
        
        userName.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(0)
            make.top.equalTo(contentView.snp.top).offset(0)
            make.bottom.equalTo(contentView.snp.bottom).offset(0)
        }
        
        
        contentName.snp.makeConstraints { (make) in
            make.left.equalTo(userName.snp.right).offset(9)
            make.right.lessThanOrEqualTo(contentView.snp.right).offset(0)
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
