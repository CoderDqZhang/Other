//
//  HotDetailTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class HotDetailTableViewCell: UITableViewCell {

    var detailLabel:UILabel!
    var imageLabel:UILabel!
    
    var numberLabel:UILabel!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
        self.setUpView()
    }
    
    func setUpView(){
        detailLabel = UILabel.init()
        detailLabel.textColor = App_Theme_06070D_Color
        detailLabel.font = App_Theme_PinFan_M_14_Font
        self.contentView.addSubview(detailLabel)
        
        numberLabel = UILabel.init()
        numberLabel.textColor = App_Theme_06070D_Color
        numberLabel.font = App_Theme_PinFan_M_14_Font
        self.contentView.addSubview(numberLabel)
        
        imageLabel = UILabel.init()
        imageLabel.backgroundColor = App_Theme_FFCB00_Color
        imageLabel.cornerRadius = 4
        imageLabel.layer.masksToBounds = true
        self.contentView.addSubview(imageLabel)
        self.updateConstraints()
    }
    
    func cellSetData(detail:String, number:String){
        detailLabel.text = detail
        numberLabel.text = number
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            imageLabel.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.contentView.snp.left).offset(18)
                make.size.equalTo(CGSize.init(width: 7, height: 14))
            }
            detailLabel.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.imageLabel.snp.right).offset(7)
            }
            numberLabel.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.detailLabel.snp.right).offset(9)
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
