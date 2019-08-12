//
//  FilterCollectionViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/1.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

typealias FilterCollectionViewCellClouse = (_ indexPath:IndexPath) ->Void
class FilterCollectionViewCell: UICollectionViewCell {
    
    var selectImageButton:AnimationButton!
    var titleLabel:YYLabel!
    var filterCollectionViewCellClouse:FilterCollectionViewCellClouse!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
        self.contentView.layer.cornerRadius = 4
        self.setUpView()
    }
    
    func setUpView(){
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .left
        titleLabel.font = App_Theme_PinFan_M_12_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = "NBA"
        self.contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(32)
            make.centerY.equalToSuperview()
            make.right.equalTo(self.contentView.snp.right).offset(-10)
        }
        
        selectImageButton = AnimationButton.init(type: .custom)
        selectImageButton.setImage(UIImage.init(named: "filter_normal"), for: .normal)
        
        self.contentView.addSubview(selectImageButton)
        selectImageButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(8)
            make.size.equalTo(CGSize.init(width: 17, height: 17))
            make.centerY.equalToSuperview()
        }
    }
    
    func cellSetData(_ indexPath:IndexPath, model:FootBallEventModel){
        selectImageButton.addAction({ (button) in
            if self.filterCollectionViewCellClouse != nil {
                self.filterCollectionViewCellClouse(indexPath)
            }
        }, for: .touchUpInside)
        selectImageButton.setImage(model.isSelect ? UIImage.init(named: "filter_select") : UIImage.init(named: "filter_normal"), for: .normal)
        titleLabel.text = model.shortNameZh
    }
    
    func cellSetBaketBallData(_ indexPath:IndexPath, model:BasketballEvent){
        selectImageButton.addAction({ (button) in
            if self.filterCollectionViewCellClouse != nil {
                self.filterCollectionViewCellClouse(indexPath)
            }
        }, for: .touchUpInside)
        selectImageButton.setImage(model.isSelect ? UIImage.init(named: "filter_select") : UIImage.init(named: "filter_normal"), for: .normal)
        titleLabel.text = model.nameZh
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
