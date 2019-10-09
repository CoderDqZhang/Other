//
//  TakeVCartTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/21.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class TakeVCartTableViewCell: UITableViewCell {

    var titleLabel:YYLabel!
    var takeCartButton:UIButton!
    
    var didMakeConstraints = false
    var uploadCartTableViewCellClouse:UploadCartTableViewCellClouse!
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: SCREENWIDTH, height: 1)))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
        self.setUpView()
    }
    
    func setUpView(){
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .left
        titleLabel.font = App_Theme_PinFan_M_15_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = "上传手持身份证照"
        self.contentView.addSubview(titleLabel)
        
        takeCartButton = UIButton.init(type: .custom)
        takeCartButton.setBackgroundImage(UIImage.init(named: "idcart_hand"), for: .normal)
        self.contentView.addSubview(takeCartButton)
        
        self.contentView.addSubview(lineLabel)
        self.updateConstraints()
    }
    
    func cellSetData(fontImage:UIImage?) {
        if fontImage != nil {
            takeCartButton.setBackgroundImage(fontImage, for: .normal)
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
            
            takeCartButton.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize.init(width: 120, height: 75))
                make.top.equalTo(self.contentView.snp.top).offset(55)
                make.centerX.equalTo(self.contentView.snp.centerX)
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
