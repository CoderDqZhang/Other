//
//  TopUpWarningTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/29.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class TopUpWarningTableViewCell: UITableViewCell {

    var warningLabel:YYLabel!
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = App_Theme_FFFFFF_Color
        self.setUpView()
    }
    
    func setUpView(){
        warningLabel = YYLabel.init(frame: CGRect.init(x: 17, y: 0, width: SCREENWIDTH - 17 * 2, height: 100))
        warningLabel.textAlignment = .left
        warningLabel.numberOfLines = 0
        warningLabel.font = App_Theme_PinFan_R_12_Font
        warningLabel.textColor = App_Theme_B5B5B5_Color
        warningLabel.text = "温馨提示\n1. 兑换比例：1元=1M币2. 兑换比例：1元=1M币2. 兑换比例：1元=1M币2. 兑换比例：1元=1M币2. 兑换比例：1元=1M币2. 兑换比例：1元=1M币2. 兑换比例：1元=1M币2. 兑换比例：1元=1M币3. 兑换比例：1元=1M币4. 兑换比例：1元=1M币"
        self.contentView.addSubview(warningLabel)
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
