//
//  UploadCartTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/21.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

enum CartType {
    case font
    case back
    case hand
}

typealias UploadCartTableViewCellClouse = (_ type:CartType) ->Void
class UploadCartTableViewCell: UITableViewCell {

    var titleLabel:YYLabel!
    var cartFontButton:UIButton!
    var cartBackButton:UIButton!
    
    var didMakeConstraints = false
    var uploadCartTableViewCellClouse:UploadCartTableViewCellClouse!
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: SCREENWIDTH, height: 1)))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .left
        titleLabel.font = App_Theme_PinFan_M_15_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = "上传身份证"
        self.contentView.addSubview(titleLabel)
        
        cartFontButton = UIButton.init(type: .custom)
        cartFontButton.setBackgroundImage(UIImage.init(named: "real_name_font"), for: .normal)
        cartFontButton.addAction({ (button) in
            if self.uploadCartTableViewCellClouse != nil {
                self.uploadCartTableViewCellClouse(.font)
            }
        }, for: .touchUpInside)
        self.contentView.addSubview(cartFontButton)
        
        
        cartBackButton = UIButton.init(type: .custom)
        cartBackButton.setBackgroundImage(UIImage.init(named: "real_name_back"), for: .normal)
        cartBackButton.addAction({ (button) in
            if self.uploadCartTableViewCellClouse != nil {
                self.uploadCartTableViewCellClouse(.back)
            }
        }, for: .touchUpInside)
        self.contentView.addSubview(cartBackButton)
        
        self.contentView.addSubview(lineLabel)
        self.updateConstraints()
    }
    
    func cellSetData(fontImage:UIImage?,backImage:UIImage?) {
        if fontImage != nil {
            cartFontButton.setBackgroundImage(fontImage, for: .normal)
        }
        if backImage != nil {
            cartBackButton.setBackgroundImage(backImage, for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView.snp.top).offset(24)
                make.left.equalTo(self.contentView.snp.left).offset(15)
            }
            
            cartFontButton.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize.init(width: 120, height: 75))
                make.top.equalTo(self.contentView.snp.top).offset(55)
                make.centerX.equalTo(self.contentView.snp.centerX).offset(-75)
            }
            
            cartBackButton.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize.init(width: 120, height: 75))
                make.top.equalTo(self.cartFontButton.snp.top).offset(0)
                make.centerX.equalTo(self.contentView.snp.centerX).offset(75)
            }
            
            lineLabel.snp.makeConstraints { (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-1)
                make.size.equalTo(CGSize.init(width: SCREENWIDTH, height: 1))
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
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
