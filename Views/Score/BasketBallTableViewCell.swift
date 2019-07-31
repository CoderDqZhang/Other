//
//  BasketBallTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

typealias BasketBallTableViewCellClouse = () ->Void

class BasketBallTableViewCell: UITableViewCell {

    var scoreType:YYLabel!
    var scoreTime:YYLabel!
    
    var scoreStatus:YYLabel!
    
    var teamA:YYLabel!
    var teamB:YYLabel!
    
    var whiteTeamA:YYLabel!
    var whiteTeamB:YYLabel!
    var specificTeamA:YYLabel!
    var specificTeamB:YYLabel!
    
    var oneTeamA:YYLabel!
    var oneTeamB:YYLabel!
    var twoTeamA:YYLabel!
    var twoTeamB:YYLabel!
    var threeTeamA:YYLabel!
    var threeTeamB:YYLabel!
    var fourTeamA:YYLabel!
    var fourTeamB:YYLabel!
    var fiveTeamA:YYLabel!
    var fiveTeamB:YYLabel!
    var allTeamA:YYLabel!
    var allTeamB:YYLabel!
    
    var attentionButton:AnimationButton!
    
    var basketBallTableViewCellClouse:BasketBallTableViewCellClouse!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        
        scoreType = YYLabel.init()
        scoreType.textAlignment = .left
        scoreType.font = App_Theme_PinFan_M_10_Font
        scoreType.textColor = App_Theme_5FBBFC_Color
        scoreType.text = "NBA"
        self.contentView.addSubview(scoreType)
        
        scoreTime = YYLabel.init()
        scoreTime.textAlignment = .left
        scoreTime.font = App_Theme_PinFan_M_10_Font
        scoreTime.textColor = App_Theme_999999_Color
        scoreTime.text = "19:35"
        self.contentView.addSubview(scoreTime)
        
        scoreStatus = YYLabel.init()
        scoreStatus.textAlignment = .center
        scoreStatus.font = App_Theme_PinFan_M_10_Font
        scoreStatus.textColor = App_Theme_FFAC1B_Color
        scoreStatus.text = "加时 10：35"
        self.contentView.addSubview(scoreStatus)
        
        teamA = YYLabel.init()
        teamA.textAlignment = .left
        teamA.font = App_Theme_PinFan_M_12_Font
        teamA.textColor = App_Theme_06070D_Color
        teamA.text = "广州恒大哈哈哈哈哈"
        self.contentView.addSubview(teamA)
        
        teamB = YYLabel.init()
        teamB.textAlignment = .left
        teamB.font = App_Theme_PinFan_M_12_Font
        teamB.textColor = App_Theme_06070D_Color
        teamB.text = "广州恒大"
        self.contentView.addSubview(teamB)
        
        whiteTeamA = YYLabel.init()
        whiteTeamA.textAlignment = .left
        whiteTeamA.font = App_Theme_PinFan_M_10_Font
        whiteTeamA.textColor = App_Theme_666666_Color
        whiteTeamA.text = "[1]"
        self.contentView.addSubview(whiteTeamA)
        
        whiteTeamB = YYLabel.init()
        whiteTeamB.textAlignment = .left
        whiteTeamB.font = App_Theme_PinFan_M_10_Font
        whiteTeamB.textColor = App_Theme_666666_Color
        whiteTeamB.text = "[1]"
        self.contentView.addSubview(whiteTeamB)
        
        specificTeamA = YYLabel.init()
        specificTeamA.textAlignment = .left
        specificTeamA.font = App_Theme_PinFan_M_10_Font
        specificTeamA.textColor = App_Theme_999999_Color
        specificTeamA.text = "0.98"
        self.contentView.addSubview(specificTeamA)
        
        specificTeamB = YYLabel.init()
        specificTeamB.textAlignment = .left
        specificTeamB.font = App_Theme_PinFan_M_10_Font
        specificTeamB.textColor = App_Theme_999999_Color
        specificTeamB.text = "0.98"
        self.contentView.addSubview(specificTeamB)
        
        
        oneTeamA = YYLabel.init()
        oneTeamA.textAlignment = .left
        oneTeamA.font = App_Theme_PinFan_M_10_Font
        oneTeamA.textColor = App_Theme_06070D_Color
        oneTeamA.text = "25"
        self.contentView.addSubview(oneTeamA)
        
        oneTeamB = YYLabel.init()
        oneTeamB.textAlignment = .left
        oneTeamB.font = App_Theme_PinFan_M_10_Font
        oneTeamB.textColor = App_Theme_06070D_Color
        oneTeamB.text = "25"
        self.contentView.addSubview(oneTeamB)
        
        twoTeamA = YYLabel.init()
        twoTeamA.textAlignment = .left
        twoTeamA.font = App_Theme_PinFan_M_10_Font
        twoTeamA.textColor = App_Theme_06070D_Color
        twoTeamA.text = "25"
        self.contentView.addSubview(twoTeamA)
        
        twoTeamB = YYLabel.init()
        twoTeamB.textAlignment = .left
        twoTeamB.font = App_Theme_PinFan_M_10_Font
        twoTeamB.textColor = App_Theme_06070D_Color
        twoTeamB.text = "25"
        self.contentView.addSubview(twoTeamB)
        
        threeTeamA = YYLabel.init()
        threeTeamA.textAlignment = .left
        threeTeamA.font = App_Theme_PinFan_M_10_Font
        threeTeamA.textColor = App_Theme_06070D_Color
        threeTeamA.text = "25"
        self.contentView.addSubview(threeTeamA)
        
        threeTeamB = YYLabel.init()
        threeTeamB.textAlignment = .left
        threeTeamB.font = App_Theme_PinFan_M_10_Font
        threeTeamB.textColor = App_Theme_06070D_Color
        threeTeamB.text = "25"
        self.contentView.addSubview(threeTeamB)
        
        fourTeamA = YYLabel.init()
        fourTeamA.textAlignment = .left
        fourTeamA.font = App_Theme_PinFan_M_10_Font
        fourTeamA.textColor = App_Theme_06070D_Color
        fourTeamA.text = "25"
        self.contentView.addSubview(fourTeamA)
        
        fourTeamB = YYLabel.init()
        fourTeamB.textAlignment = .left
        fourTeamB.font = App_Theme_PinFan_M_10_Font
        fourTeamB.textColor = App_Theme_06070D_Color
        fourTeamB.text = "25"
        self.contentView.addSubview(fourTeamB)
        
        fiveTeamA = YYLabel.init()
        fiveTeamA.textAlignment = .left
        fiveTeamA.font = App_Theme_PinFan_M_10_Font
        fiveTeamA.textColor = App_Theme_06070D_Color
        fiveTeamA.text = "25"
        self.contentView.addSubview(fiveTeamA)
        
        fiveTeamB = YYLabel.init()
        fiveTeamB.textAlignment = .left
        fiveTeamB.font = App_Theme_PinFan_M_10_Font
        fiveTeamB.textColor = App_Theme_06070D_Color
        fiveTeamB.text = "25"
        self.contentView.addSubview(fiveTeamB)
        
        allTeamA = YYLabel.init()
        allTeamA.textAlignment = .left
        allTeamA.font = App_Theme_PinFan_M_10_Font
        allTeamA.textColor = App_Theme_06070D_Color
        allTeamA.text = "25"
        self.contentView.addSubview(allTeamA)
        
        allTeamB = YYLabel.init()
        allTeamB.textAlignment = .left
        allTeamB.font = App_Theme_PinFan_M_10_Font
        allTeamB.textColor = App_Theme_06070D_Color
        allTeamB.text = "25"
        self.contentView.addSubview(allTeamB)
        
        attentionButton = AnimationButton.init(type: .custom)
        attentionButton.setImage(UIImage.init(named: "score_normal_attention"), for: .normal)
        attentionButton.addAction({ (button) in
            if self.basketBallTableViewCellClouse != nil {
                self.basketBallTableViewCellClouse()
            }
        }, for: .touchUpInside)
        self.contentView.addSubview(attentionButton)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            scoreType.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.top.equalTo(self.contentView.snp.top).offset(7)
            }
            
            scoreTime.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(75)
                make.top.equalTo(self.scoreType.snp.top).offset(0)
            }
            
            scoreStatus.snp.makeConstraints { (make) in
                make.top.equalTo(self.scoreType.snp.top).offset(0)
                make.centerX.equalToSuperview()
                make.width.equalTo(100)
            }
            
            teamA.snp.makeConstraints { (make) in
                make.width.lessThanOrEqualTo(93)
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.top.equalTo(self.contentView.snp.top).offset(26)
            }
            
            teamB.snp.makeConstraints { (make) in
                make.width.lessThanOrEqualTo(93)
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-3)
            }
            
            whiteTeamA.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView.snp.top).offset(28)
                make.left.equalTo(self.teamA.snp.right).offset(2)
            }
            
            whiteTeamB.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView.snp.top).offset(46)
                make.left.equalTo(self.teamB.snp.right).offset(2)
            }
            
            specificTeamA.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView.snp.top).offset(30)
                make.right.equalTo(self.contentView.snp.centerX).offset(-9)
                make.size.equalTo(CGSize.init(width: 22, height: 9))
                
            }
            
            specificTeamB.snp.makeConstraints { (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-6)
                make.right.equalTo(self.contentView.snp.centerX).offset(-9)
                make.size.equalTo(CGSize.init(width: 22, height: 9))
            }
            
            oneTeamA.snp.makeConstraints { (make) in
                make.left.equalTo(self.specificTeamA.snp.right).offset(16)
                make.top.equalTo(self.specificTeamA.snp.top).offset(-2)
            }
            
            oneTeamB.snp.makeConstraints { (make) in
                make.left.equalTo(self.specificTeamB.snp.right).offset(16)
                make.top.equalTo(self.specificTeamB.snp.top).offset(-2)
            }
            
            twoTeamA.snp.makeConstraints { (make) in
                make.left.equalTo(self.oneTeamA.snp.right).offset(10)
                make.top.equalTo(self.specificTeamA.snp.top).offset(-2)
            }
            
            twoTeamB.snp.makeConstraints { (make) in
                make.left.equalTo(self.oneTeamB.snp.right).offset(10)
                make.top.equalTo(self.specificTeamB.snp.top).offset(-2)
            }
            
            threeTeamA.snp.makeConstraints { (make) in
                make.left.equalTo(self.twoTeamA.snp.right).offset(10)
                make.top.equalTo(self.specificTeamA.snp.top).offset(-2)
            }
            
            threeTeamB.snp.makeConstraints { (make) in
                make.left.equalTo(self.twoTeamB.snp.right).offset(10)
                make.top.equalTo(self.specificTeamB.snp.top).offset(-2)
            }
            
            fourTeamA.snp.makeConstraints { (make) in
                make.left.equalTo(self.threeTeamA.snp.right).offset(10)
                make.top.equalTo(self.specificTeamA.snp.top).offset(-2)
            }
            
            fourTeamB.snp.makeConstraints { (make) in
                make.left.equalTo(self.threeTeamB.snp.right).offset(10)
                make.top.equalTo(self.specificTeamB.snp.top).offset(-2)
            }
            
            fiveTeamA.snp.makeConstraints { (make) in
                make.left.equalTo(self.fourTeamA.snp.right).offset(10)
                make.top.equalTo(self.specificTeamA.snp.top).offset(-2)
            }
            
            fiveTeamB.snp.makeConstraints { (make) in
                make.left.equalTo(self.fourTeamB.snp.right).offset(10)
                make.top.equalTo(self.specificTeamB.snp.top).offset(-2)
            }
            
            allTeamA.snp.makeConstraints { (make) in
                make.left.equalTo(self.fiveTeamA.snp.right).offset(13)
                make.top.equalTo(self.specificTeamA.snp.top).offset(-2)
            }
            
            allTeamB.snp.makeConstraints { (make) in
                make.left.equalTo(self.fiveTeamB.snp.right).offset(13)
                make.top.equalTo(self.specificTeamB.snp.top).offset(-2)
            }
            
            attentionButton.snp.makeConstraints { (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.contentView.snp.top).offset(24)
                make.size.equalTo(CGSize.init(width: 18, height: 18))
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
