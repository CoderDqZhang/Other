//
//  TopUpToolsTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/29.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

var AnimationTouchViewMarginItemX:CGFloat =  20
var AnimationTouchViewMarginItemY:CGFloat =  15
var AnimationTouchViewMarginLeft:CGFloat =  30
var AnimationTouchViewLineCount = 3
var AnimationTouchViewAllCount = 6
var AnimationTouchViewWidth = (SCREENWIDTH - AnimationTouchViewMarginLeft * 2  - CGFloat((AnimationTouchViewLineCount - 1 )) * AnimationTouchViewMarginItemX) / CGFloat(AnimationTouchViewLineCount)
var AnimationTouchViewHeight = AnimationTouchViewWidth * 72 / 92

class TopUPView: UIView {
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: 100, height: 1))
    var lineLabel1 = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: 100, height: 1))
    var descLable:YYLabel!
    
    var touUpAnimation:AnimationButton!
    var titleStrs = ["30M币","68M币","128M币","288M币","388M币","648M币"]
    var munberStrs = ["￥30","￥68","￥128","￥288","￥388","￥648"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        descLable = YYLabel.init()
        descLable.textAlignment = .center
        descLable.font = App_Theme_PinFan_R_14_Font
        descLable.textColor = App_Theme_B5B5B5_Color
        descLable.text = "请选择充值金额"
        self.addSubview(descLable)
        
        self.addSubview(lineLabel)
        self.addSubview(lineLabel1)
        
        lineLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(56)
            make.top.equalTo(self.snp.top).offset(31)
            make.right.equalTo(descLable.snp.left).offset(-10)
        }
        
        lineLabel1.snp.makeConstraints { (make) in
            make.left.equalTo(descLable.snp.right).offset(10)
            make.top.equalTo(self.snp.top).offset(31)
            make.right.equalTo(self.snp.right).offset(-56)
        }
        
        descLable.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.top).offset(25)
        }
        
        var maxY:CGFloat = 0
        for index in 0...AnimationTouchViewAllCount - 1 {
            let touchView = AnimationTouchView.init(frame: CGRect.init(x: AnimationTouchViewMarginLeft + (AnimationTouchViewWidth + AnimationTouchViewMarginItemX) * CGFloat(index % AnimationTouchViewLineCount), y: CGFloat((index / AnimationTouchViewLineCount)) * (AnimationTouchViewHeight + AnimationTouchViewMarginItemY) + 58, width: AnimationTouchViewWidth, height: AnimationTouchViewHeight), tag:index) {
                self.changeTouchStatus(selectIndex: index + 1000)
            }
            touchView.tag = index + 1000
            self.setUpTitleLableAndMuch(titleL: titleStrs[index], number: munberStrs[index], view: touchView)
            maxY = touchView.frame.maxY
            self.addSubview(touchView)
            touchView.borderWidth = 2
            touchView.layer.masksToBounds = true
            touchView.cornerRadius = 8
            touchView.backgroundColor = App_Theme_F6F6F6_Color
            touchView.borderColor = App_Theme_E9E9E9_Color
        }
        
        self.changeTouchStatus(selectIndex: 1001)
        
        
        touUpAnimation = AnimationButton.init(type: .custom)
        touUpAnimation.setTitle("确认充值", for: .normal)
        touUpAnimation.cornerRadius = 24
        touUpAnimation.layer.masksToBounds = true
        touUpAnimation.titleLabel?.font = App_Theme_PinFan_M_15_Font
        touUpAnimation.backgroundColor = App_Theme_FFD512_Color
        touUpAnimation.addAction({ (button) in
            
        }, for: .touchUpInside)
        self.addSubview(touUpAnimation)
        
        touUpAnimation.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.right.equalTo(self.snp.right).offset(-15)
            make.height.equalTo(47)
            make.top.equalTo(self.snp.top).offset(maxY + 20)
        }
    }
    
    func changeTouchStatus(selectIndex:Int){
        for index in 0...AnimationTouchViewAllCount - 1 {
            let touchView = self.viewWithTag(index + 1000)! as! AnimationTouchView
            if index + 1000 == selectIndex {
                touchView.borderWidth = 2
                touchView.layer.masksToBounds = true
                touchView.cornerRadius = 8
                touchView.backgroundColor = App_Theme_FFF8D5_Color
                touchView.borderColor = App_Theme_FFD512_Color
                self.changeColor(textColor: App_Theme_06070D_Color!, view: touchView)
            }else{
                touchView.borderWidth = 2
                touchView.layer.masksToBounds = true
                touchView.cornerRadius = 8
                touchView.backgroundColor = App_Theme_F6F6F6_Color
                touchView.borderColor = App_Theme_E9E9E9_Color
                self.changeColor(textColor: App_Theme_666666_Color!, view: touchView)
            }
        }
        
    }
    
    func changeColor(textColor:UIColor,view:AnimationTouchView){
        let titleLabel = view.viewWithTag(10) as! YYLabel
        titleLabel.textColor = textColor
        
        let muchLabel = view.viewWithTag(11) as! YYLabel
        muchLabel.textColor = textColor
    }
    
    func setUpTitleLableAndMuch(titleL:String,number:String,view:AnimationTouchView){
        let titleLable = YYLabel.init()
        let nsstring = NSMutableAttributedString.init(string: titleL)
        nsstring.addAttributes([NSAttributedString.Key.font : App_Theme_PinFan_M_21_Font!], range: NSRange.init(location: 0, length: nsstring.length - 2))
        nsstring.addAttributes([NSAttributedString.Key.font : App_Theme_PinFan_R_10_Font!], range: NSRange.init(location: nsstring.length - 2, length: 2))
        titleLable.font = App_Theme_PinFan_R_12_Font
        titleLable.textColor = App_Theme_999999_Color
        titleLable.attributedText = nsstring
        titleLable.tag = 10
        titleLable.textAlignment = .center
        view.addSubview(titleLable)
        
        let muchLabel = YYLabel.init()
        muchLabel.tag = 11
        muchLabel.textAlignment = .center
        muchLabel.font = App_Theme_PinFan_R_12_Font
        muchLabel.textColor = App_Theme_999999_Color
        muchLabel.text = number
        view.addSubview(muchLabel)
        
        titleLable.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.centerY.equalTo(view.snp.centerY).offset(-10)
        }
        
        muchLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.centerY.equalTo(view.snp.centerY).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class TopUpToolsTableViewCell: UITableViewCell {

    var topUPView:TopUPView!
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        topUPView = TopUPView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 58 + 47 + AnimationTouchViewHeight * 2 + AnimationTouchViewMarginItemY + 60))
        topUPView.backgroundColor = App_Theme_FFFFFF_Color
        setMutiBorderRoundingCorners(topUPView, corner: 15, byRoundingCorners: [UIRectCorner.topLeft,UIRectCorner.topRight])
        self.contentView.addSubview(topUPView)
        
        self.updateConstraints()
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
