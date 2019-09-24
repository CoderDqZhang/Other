//
//  AdTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/16.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    var adImageView:UIImageView!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        adImageView = UIImageView.init()
        self.contentView.addSubview(adImageView)
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func cellSetData(model:AdModel) {
        adImageView.sd_crope_imageView(url: model.image, imageView: adImageView, placeholderImage: nil) { (image, url, type, stage, error) in
            
        }
    }
    
    override func updateConstraints() {
        if !didMakeConstraints {
            adImageView.snp.makeConstraints { (make) in
                make.right.equalToSuperview()
                make.left.equalToSuperview()
                make.bottom.equalToSuperview()
                make.top.equalToSuperview()
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
