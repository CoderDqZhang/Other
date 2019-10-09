//
//  ScoreListTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

enum ScoreListCollectType {
    case select
    case unselect
}

typealias ScoreListTableViewCellClouse = (_ type:ScoreListCollectType, _ model:FootBallModel) ->Void

class ScoreListTableViewCell: UITableViewCell {

    var scoreType:YYLabel!
    var scoreTime:YYLabel!
    
    var scoreStatus:YYLabel!
    
    var timeLabel:YYLabel!
    var teamA:YYLabel!
    var teamB:YYLabel!
    
    var whiteTeamA:YYLabel!
    var whiteTeamB:YYLabel!
    var yellowTeamA:YYLabel!
    var redTeamA:YYLabel!
    var yellowTeamB:YYLabel!
    var redTeamB:YYLabel!
    
    var teamAInfo:UIView!
    var teamBInfo:UIView!
    
    var attentionButton:AnimationButton!
    
    var scoreLabel:YYLabel!
    var scoreInfo:YYLabel!
    var scoreInfos:YYLabel!
    var scoreInfo3:YYLabel!
    
    var scoreListTableViewCellClouse:ScoreListTableViewCellClouse!
    
    var didMakeConstraints = false
    
    var model:FootBallModel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
        self.setUpView()
    }
    
    func setUpView(){
        
        scoreType = YYLabel.init()
        scoreType.textAlignment = .left
        scoreType.font = App_Theme_PinFan_M_10_Font
        scoreType.textColor = App_Theme_666666_Color
        scoreType.text = "中超联赛"
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
        scoreStatus.text = "90"
        self.contentView.addSubview(scoreStatus)
        
        timeLabel = YYLabel.init()
        timeLabel.textAlignment = .left
        timeLabel.font = App_Theme_PinFan_M_10_Font
        timeLabel.textColor = App_Theme_666666_Color
        timeLabel.text = "周二 002"
        self.contentView.addSubview(timeLabel)
        
        teamA = YYLabel.init()
        teamA.numberOfLines = 1
        teamA.font = App_Theme_PinFan_M_12_Font
        teamA.textColor = App_Theme_06070D_Color
        teamA.text = "广州恒大哈哈哈哈哈"
        self.contentView.addSubview(teamA)
        
        teamB = YYLabel.init()
        teamB.textAlignment = .left
        teamB.font = App_Theme_PinFan_M_12_Font
        teamB.lineBreakMode = .byTruncatingTail
        teamB.textColor = App_Theme_06070D_Color
        teamB.text = "广州恒大"
        self.contentView.addSubview(teamB)
        
        teamAInfo = UIView.init()
        self.contentView.addSubview(teamAInfo)
        teamBInfo = UIView.init()
        self.contentView.addSubview(teamBInfo)
        
        yellowTeamA = YYLabel.init()
        yellowTeamA.backgroundColor = App_Theme_FFD512_Color
        yellowTeamA.textAlignment = .center
        yellowTeamA.font = App_Theme_PinFan_M_10_Font
        yellowTeamA.textColor = App_Theme_FFFFFF_Color
        yellowTeamA.text = "1"
        teamAInfo.addSubview(yellowTeamA)
        
        redTeamA = YYLabel.init()
        redTeamA.backgroundColor = App_Theme_FF4343_Color
        redTeamA.textAlignment = .center
        redTeamA.font = App_Theme_PinFan_M_10_Font
        redTeamA.textColor = App_Theme_FFFFFF_Color
        redTeamA.text = "1"
        teamAInfo.addSubview(redTeamA)
        
        whiteTeamA = YYLabel.init()
        whiteTeamA.textAlignment = .left
        whiteTeamA.font = App_Theme_PinFan_M_10_Font
        whiteTeamA.textColor = App_Theme_666666_Color
        whiteTeamA.text = "[1]"
        teamAInfo.addSubview(whiteTeamA)
        
        yellowTeamB = YYLabel.init()
        yellowTeamB.backgroundColor = App_Theme_FFD512_Color
        yellowTeamB.textAlignment = .center
        yellowTeamB.font = App_Theme_PinFan_M_10_Font
        yellowTeamB.textColor = App_Theme_FFFFFF_Color
        yellowTeamB.text = "1"
        teamBInfo.addSubview(yellowTeamB)
        
        redTeamB = YYLabel.init()
        redTeamB.backgroundColor = App_Theme_FF4343_Color
        redTeamB.textAlignment = .center
        redTeamB.font = App_Theme_PinFan_M_10_Font
        redTeamB.textColor = App_Theme_FFFFFF_Color
        redTeamB.text = "1"
        teamBInfo.addSubview(redTeamB)
        
        whiteTeamB = YYLabel.init()
        whiteTeamB.textAlignment = .left
        whiteTeamB.font = App_Theme_PinFan_M_10_Font
        whiteTeamB.textColor = App_Theme_666666_Color
        whiteTeamB.text = "[1]"
        teamBInfo.addSubview(whiteTeamB)
        
        scoreLabel = YYLabel.init()
        scoreLabel.textAlignment = .left
        scoreLabel.font = App_Theme_PinFan_M_12_Font
        scoreLabel.textColor = App_Theme_FF4343_Color
        scoreLabel.text = "9-9"
        self.contentView.addSubview(scoreLabel)
        
        scoreInfo = YYLabel.init()
        scoreInfo.textAlignment = .left
        scoreInfo.font = App_Theme_PinFan_M_10_Font
        scoreInfo.textColor = App_Theme_999999_Color
        scoreInfo.text = "1.08 军/半 0.72"
        self.contentView.addSubview(scoreInfo)
        
        
        scoreInfos = YYLabel.init()
        scoreInfos.textAlignment = .left
        scoreInfos.font = App_Theme_PinFan_M_10_Font
        scoreInfos.textColor = App_Theme_999999_Color
        scoreInfos.text = "半:1-1 角:1-1"
        self.contentView.addSubview(scoreInfos)
        
        
        scoreInfo3 = YYLabel.init()
        scoreInfo3.textAlignment = .left
        scoreInfo3.font = App_Theme_PinFan_M_10_Font
        scoreInfo3.textColor = App_Theme_999999_Color
        scoreInfo3.text = "1.08 2.5 0.72"
        self.contentView.addSubview(scoreInfo3)
        
        attentionButton = AnimationButton.init(type: .custom)
        attentionButton.setImage(UIImage.init(named: "score_normal_attention"), for: .normal)
        attentionButton.addAction({ (button) in
            if self.scoreListTableViewCellClouse != nil {
                self.attentionButton.setImage(UIImage.init(named: button?.tag == 1000 ? "score_select_attention" : "score_normal_attention"), for: .normal)
                self.scoreListTableViewCellClouse(button?.tag == 1000 ? .select : .unselect, self.model)
            }
        }, for: .touchUpInside)
        attentionButton.tag = 1000
        self.contentView.addSubview(attentionButton)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetData(model:FootBallModel, viewDesc:ScoreDetailTypeVC){
        self.model = model
        scoreType.text = model.eventInfo.shortNameZh
        scoreTime.text = Date.init(timeIntervalSince1970: model.startTime.double).string(withFormat: "HH:mm")
        
        if model.status == 0 {
            scoreStatus.text = "比赛异常"
            scoreStatus.textColor = App_Theme_999999_Color
        }else if model.status == 1 {
            scoreStatus.text = "未开赛"
            scoreStatus.textColor = App_Theme_999999_Color
        }else if model.status == 3 {
            scoreStatus.text = "中场"
            scoreStatus.textColor = App_Theme_FFAC1B_Color
        }else if model.status == 5 {
            scoreStatus.text = "加时赛"
            scoreStatus.textColor = App_Theme_FFAC1B_Color
        }else if model.status == 7 {
            scoreStatus.text = "点球对决"
            scoreStatus.textColor = App_Theme_FFAC1B_Color
        }else if model.status == 8 {
            scoreStatus.text = "完场"
            scoreStatus.textColor = App_Theme_999999_Color
        }else if model.status == 9 {
            scoreStatus.text = "推迟"
            scoreStatus.textColor = App_Theme_999999_Color
        }else if model.status == 10 {
            scoreStatus.text = "中断"
            scoreStatus.textColor = App_Theme_999999_Color
        }else if model.status == 11 {
            scoreStatus.text = "腰斩"
            scoreStatus.textColor = App_Theme_999999_Color
        }else if model.status == 12 {
            scoreStatus.text = "取消"
            scoreStatus.textColor = App_Theme_999999_Color
        }else if model.status == 13 {
            scoreStatus.text = "待定"
            scoreStatus.textColor = App_Theme_999999_Color
        }else{
            let double = Date.init().minutesSince(Date.init(timeIntervalSince1970: model.time.double))
            scoreStatus.text = String(format: "%.0f“", double + (model.status == 4 ? 46.00 : 0.00))
            if scoreStatus.layer.animation(forKey: "animation") == nil {
                scoreStatus.layer.add(AnimationTools.getSharedInstance().opacityForever_Animation(), forKey: "animation")
            }
            scoreStatus.textColor = App_Theme_FFAC1B_Color
        }
        
        var showType = 0
        
        if UserDefaults.standard.bool(forKey: RELOADCOLLECTFOOTBALLTYPEMODEL){
            showType = UserDefaults.standard.integer(forKey: RELOADCOLLECTFOOTBALLTYPEMODEL)
        }
        
        if [0,1].contains(showType) || viewDesc == .attention {
            if model.indexes.issueNum != nil{
                let str =  DateTools.getSharedInstance().intConvertStringWeek(str: model.indexes.issueNum.first!.string)
                timeLabel.text = "\(str) \(String.init(format: "%03d", model.indexes.issueNum.slice(at: 1).int!))"
            }else if model.footballLottery.issueNum != nil{
                timeLabel.text = "足彩 \(String.init(format: "%03d", model.footballLottery.issueNum.int!))"
            }else if model.northSigle.issueNum != nil {
                timeLabel.text = "北单 \(String.init(format: "%03d", model.northSigle.issueNum!))"
            }else{
                timeLabel.text = ""
            }
        }else{
            if showType == 4 {
                let str =  DateTools.getSharedInstance().intConvertStringWeek(str: model.indexes.issueNum.first!.string)
                timeLabel.text = "\(str) \(String.init(format: "%03d", model.indexes.issueNum.slice(at: 1).int!))"
            }
            if showType == 3 {
                timeLabel.text = "足彩 \(String.init(format: "%03d", model.footballLottery.issueNum.int!))"
            }
            if showType == 2 {
                timeLabel.text = "北单 \(String.init(format: "%03d", model.northSigle.issueNum!))"
            }
        }
        
        
        if viewDesc == .amidithion {
            attentionButton.isHidden = true
        }else{
            attentionButton.isHidden = false
        }
        
        let size = model.teamA.teamName.nsString.height(with: App_Theme_PinFan_M_12_Font, constraintToWidth: (SCREENWIDTH / 2) - 90)
        teamA.text = model.teamA.teamName
        if size > 20 {
            teamAInfo.snp.remakeConstraints({ (make) in
                make.top.equalTo(self.teamA.snp.bottom).offset(7)
                make.right.equalTo(self.contentView.snp.centerX).offset(-18)
                make.left.equalTo(self.contentView.snp.left).offset(30)
            })
        }else{
            teamAInfo.snp.remakeConstraints({ (make) in
                make.centerY.equalToSuperview()
                make.right.equalTo(self.teamA.snp.left).offset(-2)
                make.left.equalTo(self.contentView.snp.left).offset(30)
            })
        }
        
        
        let sizeB = model.teamB.teamName.nsString.height(with: App_Theme_PinFan_M_12_Font, constraintToWidth: (SCREENWIDTH / 2) - 90)
        if sizeB > 20 {
            teamBInfo.snp.remakeConstraints({ (make) in
                make.top.equalTo(self.teamB.snp.bottom).offset(7)
                make.left.equalTo(self.contentView.snp.centerX).offset(18)
                make.right.equalTo(self.contentView.snp.right).offset(-30)
            })
        }else{
            teamBInfo.snp.remakeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-30)
                make.centerY.equalToSuperview()
                make.left.equalTo(self.teamB.snp.right).offset(-2)
            })
        }
        teamB.text = model.teamB.teamName
        
        if model.teamA.sort != "" {
            whiteTeamA.text = "[\(String(describing: model.teamA.sort!))]"
            whiteTeamA.isHidden = false
            redTeamA.snp.remakeConstraints { (make) in
                make.right.equalTo(self.whiteTeamA.snp.left).offset(-2)
                make.top.equalTo(self.whiteTeamA.snp.top).offset(3)
                make.size.equalTo(CGSize.init(width: 10, height: 9))
            }
        }else{
            whiteTeamA.isHidden = true
            redTeamA.snp.remakeConstraints { (make) in
                make.right.equalTo(self.teamAInfo.snp.right).offset(-2)
                make.top.equalTo(self.whiteTeamA.snp.top).offset(3)
                make.size.equalTo(CGSize.init(width: 10, height: 9))
            }
        }
    
        if model.teamB.sort != "" {
            whiteTeamB.text = "[\(String(describing: model.teamB.sort!))]"
            whiteTeamB.isHidden = false
            yellowTeamB.snp.remakeConstraints { (make) in
                make.left.equalTo(self.whiteTeamB.snp.right).offset(2)
                make.top.equalTo(self.whiteTeamB.snp.top).offset(3)
                make.size.equalTo(CGSize.init(width: 10, height: 9))
            }
        }else{
            whiteTeamB.isHidden = true
            yellowTeamB.snp.remakeConstraints { (make) in
                make.left.equalTo(self.teamBInfo.snp.left).offset(2)
                make.top.equalTo(self.whiteTeamB.snp.top).offset(3)
                make.size.equalTo(CGSize.init(width: 10, height: 9))
            }
        }
        
        if model.teamA.halfRed != 0 {
            redTeamA.text = model.teamA.halfRed.string
            redTeamA.isHidden = false
            yellowTeamA.snp.remakeConstraints { (make) in
                make.right.equalTo(self.redTeamA.snp.left).offset(-2)
                make.top.equalTo(self.whiteTeamA.snp.top).offset(3)
                make.size.equalTo(CGSize.init(width: 10, height: 9))
            }
        }else{
            redTeamA.isHidden = true
            if model.teamA.sort == ""{
                yellowTeamA.snp.remakeConstraints { (make) in
                    make.right.equalTo(self.teamAInfo.snp.right).offset(0)
                    make.top.equalTo(self.whiteTeamA.snp.top).offset(3)
                    make.size.equalTo(CGSize.init(width: 10, height: 9))
                }
            }else{
                yellowTeamA.snp.remakeConstraints { (make) in
                    make.right.equalTo(self.whiteTeamA.snp.left).offset(-2)
                    make.top.equalTo(self.whiteTeamA.snp.top).offset(3)
                    make.size.equalTo(CGSize.init(width: 10, height: 9))
                }
            }
        }
        
        if model.teamB.halfRed != 0 {
            redTeamB.text = model.teamB.halfRed.string
            redTeamB.isHidden = false
        }else{
            redTeamB.isHidden = true
        }
        
        if model.teamA.halfYellow != 0 && model.teamA.halfYellow > 0{
            yellowTeamA.text = model.teamA.halfYellow.string
            yellowTeamA.isHidden = false
        }else{
            yellowTeamA.isHidden = true
        }
        
        if model.teamB.halfYellow != 0 {
            yellowTeamB.text = model.teamB.halfYellow.string
            yellowTeamB.isHidden = false
            redTeamB.snp.remakeConstraints { (make) in
                make.left.equalTo(self.yellowTeamB.snp.right).offset(2)
                make.top.equalTo(self.whiteTeamB.snp.top).offset(3)
                make.size.equalTo(CGSize.init(width: 10, height: 9))
                
            }
        }else{
            yellowTeamB.isHidden = true
            if model.teamB.sort == "" {
                redTeamB.snp.remakeConstraints { (make) in
                    make.left.equalTo(self.teamBInfo.snp.left).offset(2)
                    make.top.equalTo(self.whiteTeamB.snp.top).offset(3)
                    make.size.equalTo(CGSize.init(width: 10, height: 9))
                }
            }else{
                redTeamB.snp.remakeConstraints { (make) in
                    make.left.equalTo(self.whiteTeamB.snp.right).offset(2)
                    make.top.equalTo(self.whiteTeamB.snp.top).offset(3)
                    make.size.equalTo(CGSize.init(width: 10, height: 9))
                }
            }
        }
        
        
        if model.status == 1 || model.status == 0{
            scoreLabel.text = "VS"
        }else{
            scoreLabel.text = "\(String(describing: model.teamA.score!))-\(String(describing: model.teamB.score!))"
        }
        
        scoreInfo.isHidden = true
        scoreInfo3.isHidden = true
        
        if model.teamB.cornerBall == -1 || model.teamA.cornerBall == -1{
            scoreInfos.text = "半:\(String(describing: model.teamA.halfScore!))-\(String(describing: model.teamB.halfScore!)) 角:-"
        }else{
           scoreInfos.text = "半:\(String(describing: model.teamA.halfScore!))-\(String(describing: model.teamB.halfScore!)) 角:\(String(describing: model.teamA.cornerBall!))-\(String(describing: model.teamB.cornerBall!))"
        }
        
        attentionButton.tag = model.isSelect ? 2000 : 1000
        attentionButton.setImage(UIImage.init(named: model.isSelect ? "score_select_attention" : "score_normal_attention"), for: .normal)
    }
    
    override func updateConstraints() {
        if !didMakeConstraints {
            
            scoreType.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.top.equalTo(self.contentView.snp.top).offset(7)
            }
            
            scoreTime.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(75)
                make.top.equalTo(self.scoreType.snp.top).offset(1)
            }
            
            scoreStatus.snp.makeConstraints { (make) in
                make.top.equalTo(self.scoreType.snp.top).offset(0)
                make.centerX.equalToSuperview()
                make.width.equalTo(100)
            }
            
            timeLabel.snp.makeConstraints { (make) in
                make.top.equalTo(self.scoreType.snp.top).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            }
            
            teamA.snp.makeConstraints { (make) in
                make.right.equalTo(self.contentView.snp.centerX).offset(-18)
                make.centerY.equalToSuperview()
                make.height.equalTo(15)
            }
            
            teamB.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.centerX).offset(18)
                make.centerY.equalToSuperview()
                make.height.equalTo(15)
            }
            
            teamAInfo.snp.makeConstraints { (make) in
                make.right.equalTo(self.teamA.snp.left).offset(-2)
                make.left.equalTo(self.contentView.snp.left).offset(30)
                make.centerY.equalToSuperview()
            }
            
            teamBInfo.snp.makeConstraints { (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-30)
                make.left.equalTo(self.contentView.snp.centerX).offset(18)
                make.centerY.equalToSuperview()
            }
            
            whiteTeamA.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalTo(self.teamAInfo.snp.right).offset(0)
            }
            
            redTeamA.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalTo(self.whiteTeamA.snp.left).offset(-2)
                make.size.equalTo(CGSize.init(width: 10, height: 9))
            }
            
            yellowTeamA.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalTo(self.redTeamA.snp.left).offset(-2)
                make.size.equalTo(CGSize.init(width: 10, height: 9))
            }
            
            whiteTeamB.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.teamBInfo.snp.left).offset(2)
            }
            
            redTeamB.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.yellowTeamB.snp.right).offset(2)
                make.size.equalTo(CGSize.init(width: 10, height: 9))
                
            }
            
            yellowTeamB.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.whiteTeamB.snp.right).offset(2)
                make.size.equalTo(CGSize.init(width: 10, height: 9))
            }
            
            attentionButton.snp.makeConstraints { (make) in
                make.right.equalTo(self.contentView.snp.right).offset(5)
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize.init(width: 40, height: 40))
            }
            
            scoreLabel.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            
            scoreInfos.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-5)
            }
            
            scoreInfo.snp.makeConstraints { (make) in
                make.right.equalTo(self.scoreInfos.snp.left).offset(-35)
                make.bottom.equalTo(self.scoreInfos.snp.bottom).offset(0)
            }
            
            scoreInfo3.snp.makeConstraints { (make) in
                make.left.equalTo(self.scoreInfos.snp.right).offset(35)
                make.bottom.equalTo(self.scoreInfos.snp.bottom).offset(0)
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
