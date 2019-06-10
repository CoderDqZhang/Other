
//
//  GloabelTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/16.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import Foundation

class TitleLableAndDetailLabelDescRight:UITableViewCell {
    
    
    var titleLabel:YYLabel!
    var descLabel:YYLabel!
    var rightImageView:UIImageView!

    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 1))
    var didMakeConstraints = false
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
        self.accessoryType = .disclosureIndicator
    }
    
    func setUpView(){
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .left
        titleLabel.font = App_Theme_PinFan_M_15_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = ""
        self.contentView.addSubview(titleLabel)
        
        descLabel = YYLabel.init()
        descLabel.textAlignment = .right
        descLabel.font = App_Theme_PinFan_R_12_Font
        descLabel.textColor = App_Theme_FF7800_Color
        descLabel.text = ""
        self.contentView.addSubview(descLabel)
        
        rightImageView  = UIImageView.init()
        rightImageView.cornerRadius = 17
        rightImageView.layer.masksToBounds = true
        self.contentView.addSubview(rightImageView)
        
        self.contentView.addSubview(lineLabel)
        self.updateConstraints()
    }
    
    func cellSetData(title:String, desc:String, image:String?, isDescHidden:Bool){
        titleLabel.text = title
        if image != nil {
            UIImageViewManger.sd_imageView(url: image!, imageView: rightImageView, placeholderImage: nil) { (image, error, cache, url) in
                self.rightImageView.image = image
            }
            descLabel.isHidden = true
        }else{
            descLabel.text = desc
            self.descLabel.isHidden = isDescHidden
        }
        
    }
    
    func setNumberText(str:String){
        var showStr = str
        if str.int! > 99 {
            showStr = "99+"
        }
        descLabel.text = showStr
        descLabel.textAlignment = .center
        descLabel.backgroundColor = App_Theme_F65449_Color
        descLabel.textColor = App_Theme_FFFFFF_Color
        descLabel.layer.cornerRadius = 7
        descLabel.font = App_Theme_PinFan_R_12_Font
        
        let strHeight = showStr.nsString.width(with: App_Theme_PinFan_R_12_Font, constrainedToHeight: 14)
        descLabel.snp.remakeConstraints({ (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-9)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: strHeight + 8, height: 14))
        })
    }
    
    func updateDescFontAndColor(_ color:UIColor,_ font:UIFont){
        descLabel.textColor = color
        descLabel.font = font
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func lineLableHidden(){
        self.lineLabel.isHidden = true
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.width.equalTo(200)
                make.centerY.equalToSuperview()
            }
            
            descLabel.snp.makeConstraints { (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-9)
                make.width.equalTo(200)
                make.centerY.equalToSuperview()
            }
            
            rightImageView.snp.makeConstraints { (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-9)
                make.size.equalTo(CGSize.init(width: 34, height: 34))
                make.centerY.equalToSuperview()
            }
            
            lineLabel.snp.makeConstraints { (make) in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-1)
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

class GloabelFansTableViewCell : UITableViewCell {
    
    
    var titleLabel:YYLabel!
    var descLabel:YYLabel!
    var avatarImageView:UIImageView!
    var vImageView:UIImageView!
    
    var toolsButton:AnimationButton!
    
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 1))
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
        titleLabel.text = "德国朱艺"
        self.contentView.addSubview(titleLabel)
        
        descLabel = YYLabel.init()
        descLabel.textAlignment = .left
        descLabel.font = App_Theme_PinFan_M_12_Font
        descLabel.textColor = App_Theme_999999_Color
        descLabel.text = "用户个性签名用户个性签名"
        self.contentView.addSubview(descLabel)
        
        avatarImageView  = UIImageView.init()
        avatarImageView.backgroundColor = .gray
        avatarImageView.cornerRadius = 17
        avatarImageView.layer.masksToBounds = true
        self.contentView.addSubview(avatarImageView)
        
        vImageView  = UIImageView.init()
        vImageView.image = UIImage.init(named: "vicon_")
        vImageView.layer.masksToBounds = true
        self.contentView.addSubview(vImageView)
        
        self.contentView.addSubview(lineLabel)
        
        toolsButton = AnimationButton.init(type: .custom)
        toolsButton.cornerRadius = 14
        toolsButton.titleLabel?.font = App_Theme_PinFan_R_14_Font
        toolsButton.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
        toolsButton.addAction({ (button) in
            
        }, for: .touchUpInside)
        self.contentView.addSubview(toolsButton)
        self.updateConstraints()
    }
    
    func cellSetData(model:FansFlowwerModel){
        titleLabel.text = model.nickname
        UIImageViewManger.sd_imageView(url: model.img, imageView: avatarImageView, placeholderImage: nil) { (image, error, cache, url) in
            if error == nil {
                self.avatarImageView.image = image
            }
        }
        self.changeToolsButtonType(followed: model.isFollow == 0 ? true : false)
        descLabel.text = model.descriptionField
        
    }
    
    func changeToolsButtonType(followed:Bool) {
        if followed {
            toolsButton.setTitle("已关注", for: .normal)
            toolsButton.borderColor = App_Theme_FFAC1B_Color
            toolsButton.backgroundColor = UIColor.clear
            toolsButton.setTitleColor(App_Theme_FFAC1B_Color, for: .normal)
            toolsButton.borderWidth = 1
        }else {
            toolsButton.setTitle("关注", for: .normal)
            toolsButton.borderColor = App_Theme_FFAC1B_Color
            toolsButton.backgroundColor = App_Theme_FFAC1B_Color
            toolsButton.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
            toolsButton.borderWidth = 1
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func lineLableHidden(){
        self.lineLabel.isHidden = true
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            avatarImageView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.size.equalTo(CGSize.init(width: 34, height: 34))
            }
            
            titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.avatarImageView.snp.right).offset(11)
                make.right.equalTo(self.toolsButton.snp.left).offset(-11)
                make.top.equalTo(self.avatarImageView.snp.top).offset(0)
            }
            
            descLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.avatarImageView.snp.right).offset(11)
                make.right.equalTo(self.toolsButton.snp.left).offset(-11)
                make.top.equalTo(self.titleLabel.snp.bottom).offset(1)
            }
            
            toolsButton.snp.makeConstraints { (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize.init(width: 61, height: 27))
            }
            
            vImageView.snp.makeConstraints { (make) in
                make.right.equalTo(self.avatarImageView.snp.right).offset(0)
                make.bottom.equalTo(self.avatarImageView.snp.bottom).offset(0)
                make.size.equalTo(CGSize.init(width: 11, height: 11))
            }
            
            lineLabel.snp.makeConstraints { (make) in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-1)
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

class GloabelTextFieldAndTitleTableViewCell : UITableViewCell {
    
    var textFiled:UITextField!
    var titleLabel:YYLabel!
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: SCREENWIDTH, height: 1)))

    var didMakeConstraints = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .left
        titleLabel.font = App_Theme_PinFan_M_15_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = ""
        self.contentView.addSubview(titleLabel)
        
        
        
        textFiled = UITextField.init()
        textFiled.textAlignment = .left
        textFiled.font = App_Theme_PinFan_M_15_Font
        textFiled.textColor = App_Theme_06070D_Color
        textFiled.placeholder = ""
        textFiled.placeholderColor = App_Theme_B5B5B5_Color!
        textFiled.placeholderFont = App_Theme_PinFan_M_15_Font!
        self.contentView.addSubview(textFiled)
        
        
        self.contentView.addSubview(lineLabel)
        self.updateConstraints()
    }
    
    func cellSetData(title:String, placeholder:String){
        titleLabel.text = title
        textFiled.placeholder = placeholder
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hiddenLineLabel(){
        lineLabel.isHidden = true
    }
    
    override func updateConstraints() {
        if !didMakeConstraints {
            textFiled.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.titleLabel.snp.right).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            }
            
            titleLabel.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.width.equalTo(85)
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

class GloabelTextFieldTableViewCell : UITableViewCell {
    
    var textFiled:UITextField!
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: SCREENWIDTH, height: 1)))
    
    var didMakeConstraints = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        
        textFiled = UITextField.init()
        textFiled.textAlignment = .left
        textFiled.font = App_Theme_PinFan_M_15_Font
        textFiled.textColor = App_Theme_06070D_Color
        textFiled.placeholder = ""
        textFiled.placeholderColor = App_Theme_B5B5B5_Color!
        textFiled.placeholderFont = App_Theme_PinFan_M_15_Font!
        self.contentView.addSubview(textFiled)
        
        
        self.contentView.addSubview(lineLabel)
        self.updateConstraints()
    }
    
    func cellSetData(placeholder:String){
        textFiled.placeholder = placeholder
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hiddenLineLabel(){
        lineLabel.isHidden = true
    }
    
    override func updateConstraints() {
        if !didMakeConstraints {
            textFiled.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
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

typealias GloabelTextViewTableViewCellClouse = (_ str:String, _ isEnabel:Bool) ->Void

class GloabelTextViewTableViewCell : UITableViewCell,YYTextViewDelegate {
    
    var textView:YYTextView!
    var detailLabel:YYLabel!
    
    var didMakeConstraints = false
    var gloabelTextViewTableViewCellClouse:GloabelTextViewTableViewCellClouse!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        
        textView = YYTextView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 100))
        textView.delegate = self
        textView.font = App_Theme_PinFan_M_15_Font
        textView.textColor = App_Theme_06070D_Color
        textView.placeholderTextColor = App_Theme_B5B5B5_Color!
        textView.placeholderFont = App_Theme_PinFan_M_15_Font!
        self.contentView.addSubview(textView)
        
        
        detailLabel = YYLabel.init()
        detailLabel.text = "0/255"
        detailLabel.textColor = App_Theme_999999_Color
        detailLabel.font = App_Theme_PinFan_M_14_Font
        self.contentView.addSubview(detailLabel)
        
        
        self.updateConstraints()
    }
    
    func cellSetData(placeholder:String){
        textView.placeholderText = placeholder
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !didMakeConstraints {
            
            textView.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView.snp.top).offset(15)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(15)
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            }
            
            detailLabel.snp.makeConstraints { (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-15)
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
    
    func textView(_ textView: YYTextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        detailLabel.text = "\(textView.text.count)/255"
        if textView.text.count > 255 {
            textView.text = textView.text.nsString.substring(to: 255)
        }
        if self.gloabelTextViewTableViewCellClouse != nil {
            self.gloabelTextViewTableViewCellClouse(textView.text,textView.text.count > 0 ? true : false)
        }
        return true
    }
}

class GloabelConfirmTableViewCell : UITableViewCell {
    
    var anmationButton:AnimationButton!
    
    var didMakeConstraints = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
        self.backgroundColor = App_Theme_F6F6F6_Color
    }
    
    func setUpView(){
        anmationButton = AnimationButton.init(type: .custom)
        anmationButton.isEnabled = false
        anmationButton.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
        anmationButton.setTitle("确定", for: .normal)
        anmationButton.titleLabel?.font = App_Theme_PinFan_M_15_Font
        anmationButton.backgroundColor = App_Theme_B5B5B5_Color
        anmationButton.cornerRadius = 23.5
        self.contentView.addSubview(anmationButton)
        
        self.updateConstraints()
    }
    
    func changeEnabel(isEnabled:Bool)
    {
        anmationButton.isEnabled = isEnabled
        if isEnabled {
            anmationButton.setTitleColor(App_Theme_06070D_Color, for: .normal)
            anmationButton.backgroundColor = App_Theme_FFCB00_Color
        }else{
            anmationButton.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
            anmationButton.backgroundColor = App_Theme_B5B5B5_Color
        }
    }
    
    func cellSetData(title:String){
        anmationButton.setTitle(title, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !didMakeConstraints {
            anmationButton.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
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


class GloabelTextFieldButtonTableViewCell : UITableViewCell {
    
    var textFiled:UITextField!
    var senderCode:UIButton!
    var titleLabel:YYLabel!
    
    var time:Timer!
    var count:Int =  15
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: SCREENWIDTH, height: 1)))
    
    var didMakeConstraints = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .left
        titleLabel.font = App_Theme_PinFan_M_15_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = ""
        self.contentView.addSubview(titleLabel)
        
        senderCode = UIButton.init(type: .custom)
        senderCode.setTitle("发送验证码", for: .normal)
        senderCode.titleLabel?.font = App_Theme_PinFan_M_14_Font
        senderCode.setTitleColor(App_Theme_FFAC1B_Color, for: .normal)
        senderCode.addAction({ (button) in
            self.count = 15
            self.timeDone()
        }, for: .touchUpInside)
        self.addSubview(senderCode)
        
        textFiled = UITextField.init()
        textFiled.textAlignment = .left
        textFiled.font = App_Theme_PinFan_M_15_Font
        textFiled.textColor = App_Theme_06070D_Color
        textFiled.placeholder = ""
        textFiled.placeholderColor = App_Theme_B5B5B5_Color!
        textFiled.placeholderFont = App_Theme_PinFan_M_15_Font!
        self.contentView.addSubview(textFiled)
        
        
        self.contentView.addSubview(lineLabel)
        self.updateConstraints()
    }
    
    func cellSetData(title:String, placeholder:String){
        titleLabel.text = title
        textFiled.placeholder = placeholder
    }
    
    func timeDone(){
        if time == nil {
            time = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (time) in
                self.count = self.count - 1
                if self.count > 0 {
                    self.senderCode.isEnabled = false
                    self.senderCode.setTitle("\(self.count)s", for: .normal)
                }else{
                    self.senderCode.isEnabled = true
                    self.senderCode.setTitle("发送验证码", for: .normal)
                    self.time.fireDate = Date.distantFuture
                }
            }
            time.fire()
        }else{
            time.fireDate = Date.init()
        }
        
    }
    
    func relaseTimer(){
        if self.time != nil {
            self.time.invalidate()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hiddenLineLabel(){
        lineLabel.isHidden = true
    }
    
    override func updateConstraints() {
        if !didMakeConstraints {
            textFiled.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.titleLabel.snp.right).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            }
            
            titleLabel.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.width.equalTo(85)
            }
            
            lineLabel.snp.makeConstraints { (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-1)
                make.size.equalTo(CGSize.init(width: SCREENWIDTH, height: 1))
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            }
            
            
            senderCode.snp.makeConstraints { (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.centerY.equalToSuperview()

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


