//
//  PostCommentImagesTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/14.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import TZImagePickerController

let PostImageMaxCount:CGFloat = 4
let PostImageMarginTop:CGFloat = 12
let PostImageSelectViewMargetWidth:CGFloat = 16
let PostImageSelectMarginLeftAndRight:CGFloat = 15
let PostImageSelectViewWidth:CGFloat = (SCREENWIDTH - PostImageSelectMarginLeftAndRight * 2 - PostImageSelectViewMargetWidth * (PostImageMaxCount - 1)) / PostImageMaxCount
let PostImageSelectViewHeight:CGFloat = PostImageSelectViewWidth

class PostImageSelectView:UIView {
    
    var deleteButton:UIButton!
    var imageView:UIImageView!
    
    init(frame: CGRect, image:UIImage) {
        super.init(frame: frame)
        imageView = UIImageView.init()
        imageView.image = UIImageMaxCroped.cropeImage(image: image, imageViewSize:  CGSize.init(width: PostImageSelectViewWidth, height: PostImageSelectViewHeight))
        self.addSubview(imageView)
        
        deleteButton = UIButton.init(type: .custom)
        deleteButton.setImage(UIImage.init(named: "reduceicon"), for: .normal)
        self.addSubview(deleteButton)
        
        imageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: PostImageSelectViewWidth, height: PostImageSelectViewHeight))
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(0)
            make.top.equalTo(self.snp.top).offset(-20)
            make.size.equalTo(CGSize.init(width: 40, height: 40))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum CommentImages {
    case delete
    case image
}
typealias PostCommentImageAddButtonClouse = (_ button:UIButton) ->Void
typealias PostCommentImageImageButtonClouse = (_ tag:Int, _ type:CommentImages) ->Void
class PostCommentImagesTableViewCell: UITableViewCell {

    var snapshotView:UIView!
    var photoImage:UIImageView!
    var addButton:AnimationButton!
    var postCommentImageAddButtonClouse:PostCommentImageAddButtonClouse!
    var postCommentImageImageButtonClouse:PostCommentImageImageButtonClouse!
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
        self.setUpView()
    }
    
    func setUpView(){
        snapshotView = UIView.init()
        self.contentView.addSubview(snapshotView)
        
        snapshotView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(PostImageSelectMarginLeftAndRight)
            make.right.equalTo(self.contentView.snp.right).offset(-PostImageSelectMarginLeftAndRight)
            make.top.equalTo(self.contentView.snp.top).offset(PostImageMarginTop)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-PostImageMarginTop)
        }
        
        addButton = AnimationButton.init(type: .custom)
        addButton.setImage(UIImage.init(named: "addicon"), for: .normal)
        addButton.backgroundColor = App_Theme_F6F6F6_Color
        addButton.addAction({ (btn) in
            if self.postCommentImageAddButtonClouse != nil {
                self.postCommentImageAddButtonClouse(btn!)
            }
        }, for: .touchUpInside)
        snapshotView.addSubview(addButton)
        self.updateConstraints()
    }
    
    func cellSetData(images:NSMutableArray){
        snapshotView.removeSubviews()
        snapshotView.addSubview(addButton)
        if images.count > 0 {
            for index in 0...images.count - 1 {
                let postImageView = PostImageSelectView.init(frame: CGRect.init(x: 0 + CGFloat(index) * (PostImageSelectViewWidth + PostImageSelectViewMargetWidth), y: 0, width: PostImageSelectViewWidth + 20, height: PostImageSelectViewHeight + 20), image: images[index] as! UIImage)
                postImageView.tag = index + 10000
                _  = postImageView.newTapGesture { (gesture) in
                    gesture.numberOfTouchesRequired = 1
                    gesture.numberOfTapsRequired = 1
                    }.whenTaped { (tap) in
                        if self.postCommentImageImageButtonClouse != nil {
                            self.postCommentImageImageButtonClouse(postImageView.tag - 10000,.image)
                        }
                }
                postImageView.deleteButton.addAction({ (button) in
                    if self.postCommentImageImageButtonClouse != nil {
                        self.postCommentImageImageButtonClouse(postImageView.tag - 10000, .delete)
                    }
                }, for: UIControl.Event.touchUpInside)
                snapshotView.addSubview(postImageView)
            }
            if images.count == 3 {
                addButton.isHidden = true
            }else{
                addButton.isHidden = false
                addButton.frame = CGRect.init(x: 0 + CGFloat(images.count) * (PostImageSelectViewWidth + PostImageSelectViewMargetWidth), y: 0, width: PostImageSelectViewWidth, height: PostImageSelectViewHeight)
            }
        }else{
            addButton.isHidden = false
            addButton.frame = CGRect.init(x: 0 + CGFloat(images.count) * (PostImageSelectViewWidth + PostImageSelectViewMargetWidth), y: 0, width: PostImageSelectViewWidth, height: PostImageSelectViewHeight)
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
