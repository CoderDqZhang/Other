//
//  CategoryTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

// height 62 / 26
// 62 + 26 = 88 / 83

let CategoryViewWidth:CGFloat = (SCREENWIDTH - 20 - 24) / 4
var CategoryViewHeight:CGFloat = CategoryViewWidth * 88 / 83
let ImageHeith:CGFloat = CategoryViewHeight * (62 / 88)

typealias CategoryViewClouseClick = (_ tag:Int) ->Void

class CategoryView:UIView {
    
    var imageView:UIImageView!
    var titleLabel:YYLabel!
    var categoryViewClouseClick:CategoryViewClouseClick!
    
    init(imageUrl:String, title:String, tag:Int, clouse:@escaping CategoryViewClouseClick){
        super.init(frame: CGRect.init(x: 0, y: 0, width: CategoryViewWidth, height: CategoryViewHeight))
        self.categoryViewClouseClick = clouse
        self.setShadowWithCornerRadius(corners: 10, shadowColor: App_Theme_B5B5B5_Color!, shadowOffset: CGSize.init(width: 2, height: 2), shadowOpacity: 1)
        
        imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: CategoryViewWidth, height: ImageHeith))
        setMutiBorderRoundingCorners(imageView, corner: 10, byRoundingCorners: [UIRectCorner.topLeft,UIRectCorner.topRight])
        imageView.backgroundColor = .gray
        UIImageViewManger.sd_downImage(url: imageUrl, placeholderImage: nil) { (image, date, error, ret) in
            
        }
        
        self.addSubview(imageView)
        titleLabel = YYLabel.init(frame: CGRect.init(x: 0, y: ImageHeith, width: CategoryViewWidth, height: CategoryViewHeight - ImageHeith))
        setMutiBorderRoundingCorners(titleLabel, corner: 10, byRoundingCorners: [UIRectCorner.bottomLeft,UIRectCorner.bottomRight])
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = App_Theme_PinFan_M_12_Font
        titleLabel.backgroundColor = App_Theme_FFFFFF_Color
        titleLabel.textColor = App_Theme_333333_Color
        self.addSubview(titleLabel)
        
        self.isUserInteractionEnabled = true
        
        let singleTap = UITapGestureRecognizerManager.shareInstance.initTapGestureRecognizer {
            self.categoryViewClouseClick(tag)
        }
        self.addGestureRecognizer(singleTap)
    }
    
    /// 添加圆角和阴影 radius:圆角半径 shadowOpacity: 阴影透明度 (0-1) shadowColor: 阴影颜色
    func setShadow(view:UIView,sColor:UIColor,offset:CGSize,
                   opacity:Float,radius:CGFloat) {
        //设置阴影颜色
        view.layer.shadowColor = sColor.cgColor
        //设置透明度
        view.layer.shadowOpacity = opacity
        //设置阴影半径
        view.layer.shadowRadius = radius
        //设置阴影偏移量
        view.layer.shadowOffset = offset
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias CategoryTableViewCellClouseClick = (_ tag:Int) ->Void

class CategoryTableViewCell: UITableViewCell {
    
    var contentViews:UIView!
    var categoryTableViewCellClouseClick:CategoryTableViewCellClouseClick!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = App_Theme_F6F6F6_Color
        self.setUpView()
    }
    
    func setUpView(){
        contentViews = UIView.init(frame: CGRect.init(x: 0, y: 5, width: SCREENWIDTH, height: CategoryViewHeight))
        self.contentView.addSubview(contentViews)
        self.cellSetData()
        self.updateConstraints()
    }
    
    func cellSetData(){
        var urls = ["","","",""]
        var titles = ["足球讨论","足球欧指讨论","篮球讨论","篮球欧指讨论"]
        for index in 0...3{
            let categoryView = CategoryView.init(imageUrl: urls[index], title: titles[index], tag: index) { (tag) in
                self.categoryTableViewCellClouseClick(tag)
            }
            categoryView.frame = CGRect.init(x: 10 + CGFloat(CGFloat(index) * (CategoryViewWidth + 8)), y: 5, width: CategoryViewWidth, height: CategoryViewHeight)
            contentViews.addSubview(categoryView)
        }
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
