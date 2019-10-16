//
//  CommentTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class CommentView: UIView {
    var timeLabel:YYLabel!
    var likeButton:UIButton!
    var commentButtom:UIButton!
    
    var didMakeConstraints = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func crateContent(time:String, like:String, comment:String, status:Int) {
        if timeLabel == nil {
            timeLabel = YYLabel.init()
            timeLabel.textColor = App_Theme_999999_Color
            timeLabel.font = App_Theme_PinFan_R_12_Font
            self.addSubview(timeLabel)
        }
        timeLabel.text = time

        
        if likeButton == nil {
            likeButton = UIButton.init(type: .custom)
            likeButton.setTitleColor(App_Theme_B5B5B5_Color, for: .normal)
            likeButton.titleLabel?.font = App_Theme_PinFan_R_12_Font
            likeButton.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -6, bottom: 0, right: 0)
            self.addSubview(likeButton)

        }
        likeButton.setTitle(like, for: .normal)

        self.changeLikeButtonStatus(status: status)
        
        if commentButtom == nil {
            commentButtom = UIButton.init(type: .custom)
            commentButtom.setTitleColor(App_Theme_B5B5B5_Color, for: .normal)
            commentButtom.titleLabel?.font = App_Theme_PinFan_R_12_Font
            commentButtom.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -6, bottom: 0, right: 0)
            commentButtom.setImage(UIImage.init(named: "comment"), for: .normal)
            self.addSubview(commentButtom)
        }
        commentButtom.setTitle(comment, for: .normal)

        self.updateConstraints()
    }
    
    override func updateConstraints() {
        if self.timeLabel != nil {
            timeLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.snp.left).offset(15)
                make.centerY.equalToSuperview()
            }
            
            commentButtom.snp.makeConstraints { (make) in
                make.right.equalTo(self.snp.right).offset(-15)
                make.centerY.equalToSuperview()
            }
            
            likeButton.snp.makeConstraints { (make) in
                make.right.equalTo(self.commentButtom.snp.left).offset(-13)
                make.centerY.equalToSuperview()
            }
        }
        
        super.updateConstraints()
    }
    
    func changeLikeButtonStatus(status:Int){
        if status == 0 {
            likeButton.setImage(UIImage.init(named: "like"), for: .normal)
        }else{
            likeButton.setImage(UIImage.init(named: "like_select"), for: .normal)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CommentTableViewCell: UITableViewCell {

    var commentView:CommentView!
    var model:TipModel!
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
        self.setUpView()
    }
    
    func setUpView(){
        commentView = CommentView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 32))
        self.contentView.addSubview(commentView)

        self.updateConstraints()
    }
    
    func cellSetData(model:TipModel){
        var favorStr = ""
        if model.fork > 1000 {
            favorStr = model.fork.kFormatted
        }else{
            favorStr = model.fork.string
        }
        
        var commentStr = ""
        if model.commentTotal > 1000 {
            commentStr = model.commentTotal.kFormatted
        }else{
            commentStr = model.commentTotal.string
        }
        commentView.crateContent(time: model.createTime, like: favorStr, comment: commentStr, status: 0)
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
