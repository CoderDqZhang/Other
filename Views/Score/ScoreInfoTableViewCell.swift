//
//  ScoreInfoTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/7/31.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class ScoreInfoTableViewCell: UITableViewCell {
    
    var scoreDesc:YYLabel!
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 1))
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        
        scoreDesc = YYLabel.init()
        scoreDesc.textAlignment = .left
        scoreDesc.font = App_Theme_PinFan_M_10_Font
        scoreDesc.textColor = App_Theme_666666_Color
        scoreDesc.text = "广州恒大先开球：角球数( )角球球数( )"
        self.contentView.addSubview(scoreDesc)
        
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetData(model:FootBallModel){
        scoreDesc.text = model.remark.remarkDetail
    }
    
    override func updateConstraints() {
        if !didMakeConstraints {
            scoreDesc.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            
            lineLabel.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView.snp.top).offset(0.5)
                make.height.equalTo(1)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
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
