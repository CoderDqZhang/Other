//
//  CommentTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class CommentView: UIView {
    var timeLabel:UILabel!
    var likeButton:UIButton!
    var commentButtom:UIButton!
    
    var didMakeConstraints = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func crateContent(time:String, like:String, comment:String, status:Int) {
        timeLabel = UILabel.init()
        timeLabel.text = time
        timeLabel.textColor = App_Theme_999999_Color
        timeLabel.font = App_Theme_PinFan_R_12_Font
        self.addSubview(timeLabel)
        
        
        likeButton = UIButton.init(type: .custom)
        likeButton.setTitleColor(App_Theme_B5B5B5_Color, for: .normal)
        likeButton.setTitle(like, for: .normal)
        likeButton.titleLabel?.font = App_Theme_PinFan_R_12_Font
        likeButton.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -6, bottom: 0, right: 0)
        self.changeLikeButtonStatus(status: status)
        self.addSubview(likeButton)
        
        commentButtom = UIButton.init(type: .custom)
        commentButtom.setTitleColor(App_Theme_B5B5B5_Color, for: .normal)
        commentButtom.titleLabel?.font = App_Theme_PinFan_R_12_Font
        commentButtom.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -6, bottom: 0, right: 0)
        commentButtom.setTitle(like, for: .normal)
        commentButtom.setImage(UIImage.init(named: "comment"), for: .normal)
        self.addSubview(commentButtom)
        
        self.updateConstraints()
    }
    
    override func updateConstraints() {
        if !didMakeConstraints {
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
            didMakeConstraints = true
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
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
        self.setUpView()
    }
    
    func setUpView(){
        commentView = CommentView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 32))
        self.contentView.addSubview(commentView)
        
        commentView.crateContent(time: "12分钟前", like: "66", comment: "6666", status: 1)
        
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
