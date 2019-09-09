//
//  WithDrawMuchTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/30.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

typealias WithDrawMuchTableViewAllMuchClouse = () ->Void
class WithDrawMuchTableViewCell: UITableViewCell {

    var titleLabel:YYLabel!
    var muchTextFiled:UITextField!
    var allMuchLabel:YYLabel!
    var muchLabel:YYLabel!
    
    var accountInfo:AccountInfoModel!
    
    var lineLabel:YYLabel!
    var withDrawMuchTableViewAllMuchClouse:WithDrawMuchTableViewAllMuchClouse!
    
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .left
        titleLabel.font = App_Theme_PinFan_M_14_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = "提现金额"
        self.contentView.addSubview(titleLabel)
        
        let attributedText = NSMutableAttributedString.init(string: "全部提现")
        attributedText.yy_lineSpacing = 3
        attributedText.yy_color = App_Theme_FFAC1B_Color
        attributedText.yy_setTextUnderline(YYTextDecoration.init(style: YYTextLineStyle.single), range: NSRange.init(location: 0, length: 4))
        allMuchLabel = YYLabel.init()
        allMuchLabel.textAlignment = .center
        allMuchLabel.font = App_Theme_PinFan_M_14_Font
        allMuchLabel.attributedText = attributedText
        _ = allMuchLabel.newTapGesture(config: { (tap) in
            tap.numberOfTapsRequired = 1
            tap.numberOfTouchesRequired = 1
        }).whenTaped(handler: { (tap) in
            if self.withDrawMuchTableViewAllMuchClouse != nil {
                self.withDrawMuchTableViewAllMuchClouse()
            }
        })
        self.contentView.addSubview(allMuchLabel)
        
        muchLabel = YYLabel.init()
        muchLabel.textAlignment = .left
        muchLabel.font = App_Theme_PinFan_R_18_Font
        muchLabel.textColor = App_Theme_06070D_Color
        muchLabel.text = "￥"
        self.contentView.addSubview(muchLabel)
        
        muchTextFiled = UITextField.init()
        muchTextFiled.textAlignment = .left
        muchTextFiled.font = App_Theme_PinFan_M_15_Font
        muchTextFiled.textColor = App_Theme_06070D_Color
        muchTextFiled.delegate = self
        muchTextFiled.keyboardType = .decimalPad
        muchTextFiled.setPlaceholder(str: "请输入金额", font: App_Theme_PinFan_M_15_Font!, textColor: App_Theme_B5B5B5_Color!)
        self.contentView.addSubview(muchTextFiled)
        
        
        lineLabel = YYLabel.init()
        lineLabel.font = App_Theme_PinFan_R_18_Font
        lineLabel.backgroundColor = App_Theme_B5B5B5_Color
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraints()
    }
    
    func cellSetData(model:AccountInfoModel){
        self.accountInfo = model
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(16)
                make.top.equalTo(self.contentView.snp.top).offset(16)
            }
            
            allMuchLabel.snp.makeConstraints { (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-16)
                make.top.equalTo(self.contentView.snp.top).offset(40)
                make.size.equalTo(CGSize.init(width: 60, height: 40))
            }
            
            muchLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.top.equalTo(self.contentView.snp.top).offset(52)
                make.width.equalTo(20)
            }
            
            muchTextFiled.snp.makeConstraints { (make) in
                make.left.equalTo(muchLabel.snp.right).offset(6)
                make.top.equalTo(self.contentView.snp.top).offset(52)
                make.right.equalTo(self.allMuchLabel.snp.left).offset(0)
            }
            
            lineLabel.snp.makeConstraints { (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-40)
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.height.equalTo(1)
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

extension WithDrawMuchTableViewCell : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard string == "." || string == "0" else { return true }
        guard let text = textField.text else { return true }
        if text.count == 0 {
            textField.text = "0."
            return false
        }
        if text.range(of: ".") != nil && string == "." {
            return false
        }
        return true
    }
}
