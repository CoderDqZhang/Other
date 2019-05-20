//
//  GloableView.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/9.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import Foundation

class GloableLineLabel: UIView {
    
    class func createLineLabel(frame:CGRect) -> YYLabel{
        let lable = YYLabel.init(frame: frame)
        lable.backgroundColor = App_Theme_F6F6F6_Color
        return lable
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
enum GLoabelNavigaitonBarButtonType {
    case backBtn
    case rightBtn
}
typealias GloabelBackButtonClouse = (_ buttonType:GLoabelNavigaitonBarButtonType) ->Void
class GLoabelNavigaitonBar:UIView {
    var titleLabel:YYLabel!
    var backButton:UIButton!
    var gloabelBackButtonClouse:GloabelBackButtonClouse!
    
    init(frame: CGRect, title:String, rightButton:UIButton?,  click:@escaping GloabelBackButtonClouse) {
        super.init(frame:frame)
        self.gloabelBackButtonClouse = click
        titleLabel = YYLabel.init()
        titleLabel.text = title
        titleLabel.font = App_Theme_PinFan_R_18_Font
        titleLabel.textColor = UIColor.clear
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.centerY.equalTo(self.snp.centerY).offset(NAV_HEIGHT/2 + 10)
            } else {
                make.centerY.equalToSuperview()
            }
            make.centerX.equalTo(self.snp.centerX).offset(0)
        }
        
        backButton = UIButton.init(type: .custom)
        backButton.setImage(UIImage.init(named: "back_bar"), for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonClick), for: .touchUpInside)
        self.addSubview(backButton)
        
        if rightButton != nil {
            rightButton?.addTarget(self, action: #selector(self.rightButtonClick), for: .touchUpInside)
            self.addSubview(rightButton!)
            rightButton?.snp.makeConstraints { (make) in
                if #available(iOS 11.0, *) {
                    make.centerY.equalTo(self.snp.centerY).offset(NAV_HEIGHT/2 + 10)
                } else {
                    make.centerY.equalTo(self.snp.centerY).offset(10)
                }
                make.left.equalTo(self.snp.left).offset(6)
                make.size.equalTo(CGSize.init(width: 40, height: 40))
            }
        }
        
        backButton.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.centerY.equalTo(self.snp.centerY).offset(NAV_HEIGHT/2 + 10)
            } else {
                make.centerY.equalTo(self.snp.centerY).offset(10)
            }
            make.left.equalTo(self.snp.left).offset(6)
            make.size.equalTo(CGSize.init(width: 40, height: 40))
        }
    }
    
    func hiddenBackButton(){
        backButton.isHidden = true
    }
    
    @objc func backButtonClick(){
        self.gloabelBackButtonClouse(.backBtn)
    }
    
    @objc func rightButtonClick(){
        self.gloabelBackButtonClouse(.rightBtn)
    }
    
    func changeBackGroundColor(transparency:CGFloat){
        if transparency < 0 {
            titleLabel.textColor = UIColor.clear
        }else{
            titleLabel.textColor = UIColor.init(hexString: "06070D", transparency: transparency)
        }
        self.backgroundColor = UIColor.init(hexString: "FFCB00", transparency: transparency)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomViewButtonTopImageAndBottomLabel: AnimationTouchView {
    
    var imageView:UIImageView!
    var label:YYLabel!
    init(frame:CGRect, title:String, image:UIImage, tag:NSInteger?, titleColor:UIColor,spacing:CGFloat, font:UIFont, click:@escaping TouchClickClouse) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height)) {
            click()
        }
        
        imageView = UIImageView.init(frame: CGRect.init(x: (frame.size.width - image.size.width) / 2, y: 0, width: image.size.width, height: image.size.height))
        imageView.image = image
        self.addSubview(imageView)
        
        label = YYLabel.init(frame: CGRect.init(x: 0, y: spacing + image.size.height, width: frame.size.width, height: font.capHeight + 2))
        label.textAlignment = .center
        label.text = title
        label.font = font
        label.textColor = titleColor
        self.isUserInteractionEnabled = true
        self.tag = tag!
        self.addSubview(label)
        
    }
    
    func changeContent(str:String,image:UIImage) {
        label.text = str
        imageView.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import IQKeyboardManagerSwift

let YYTextViewFrameWidht:CGFloat = SCREENWIDTH - 16 * 2
let YYTextViewFrameMAXHeight:CGFloat = 100
typealias CustomViewCommentTextFieldSenderClick = (_ str:String) ->Void
class CustomViewCommentTextField: UIView {
    
    var textView:YYTextView!
    var imageButton:AnimationButton!
    var touchClickClouse:TouchClickClouse!
    var originFrame:CGRect!
    var keybordFrame:CGRect!
    var textViewOriginFrame:CGRect!
    var customViewCommentTextFieldSenderClick:CustomViewCommentTextFieldSenderClick!
    init(frame:CGRect, placeholderString:String, isEdit:Bool, click:@escaping TouchClickClouse, senderClick:@escaping CustomViewCommentTextFieldSenderClick) {
        super.init(frame: frame)
        originFrame = frame
        self.customViewCommentTextFieldSenderClick = senderClick
        textView = YYTextView.init()
        textView.borderColor = App_Theme_B4B4B4_Color
        textView.delegate = self
        textView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        textView.isScrollEnabled = false
        textView.font = App_Theme_PinFan_R_14_Font
        textView.placeholderFont = App_Theme_PinFan_R_14_Font
        textView.placeholderTextColor = App_Theme_BBBBBB_Color
        textView.textColor = App_Theme_666666_Color
        textView.placeholderText = placeholderString
        textView.cornerRadius = 4
        textView.keyboardType = .default
        textView.returnKeyType = .send
        textView.borderWidth = 1
        self.addSubview(textView)
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(7)
            make.left.equalTo(self.snp.left).offset(15)
            make.right.equalTo(self.snp.right).offset(-15)
            make.height.equalTo(30)
        }
        
        if !isEdit {
            let singTap = UITapGestureRecognizerManager.shareInstance.initTapGestureRecognizer {
                click()
            }
            self.addGestureRecognizer(singTap)
        }
        if #available(iOS 11.0, *) {
            IQKeyboardManager.shared.keyboardDistanceFromTextField = -TABBAR_HEIGHT
        } else {
            // Fallback on earlier versions
            IQKeyboardManager.shared.keyboardDistanceFromTextField = -20
        }
        self.registerNotification()

    }
    
    func senderClick(){
        self.textView.endEditing(true)
        self.releaseNotification()
        self.customViewCommentTextFieldSenderClick(self.textView.text)
    }
    
    //MARK:监听键盘通知
    func registerNotification(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillShow(_ :)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillHide(_ :)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyBoardWillShow(_ notification:Notification){
        DispatchQueue.main.async {
            
            /*
             每次键盘发生变化之前，先恢复原来的状态
             y 是键盘布局的origin.y
             y2 是登录按钮的origin.y+height
             如果y>y2，登录按钮没有被遮挡，不需要向上移动；反之，按钮被遮挡，整体需要向上移动一部分
             */
        }
    }
    
    @objc func keyBoardWillHide(_ notification:Notification){
        DispatchQueue.main.async {
//            self.center = CGPoint.init(x: self.frame.size.width/2, y: self.frame.size.height/2)
        }
    }
    
    //MARK:释放键盘监听通知
    func releaseNotification(){
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @nonobjc
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomViewCommentTextField : YYTextViewDelegate {
    func textView(_ textView: YYTextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n")
        {
            self.senderClick()
            textView.text = ""
            return false
        }
        return true
    }

    func textViewDidChange(_ textView: YYTextView) {
        let fltTextHeight = textView.textLayout!.textBoundingSize.height;
        textView.isScrollEnabled = true //必须设置为NO
        UIView.animate(withDuration: 0.25, animations: {
            self.frame = CGRect.init(x: 0, y: self.keybordFrame.origin.y - (fltTextHeight - self.textViewOriginFrame.size.height), width: self.keybordFrame.size.width, height: fltTextHeight + 14)
            textView.height = fltTextHeight
        }) { (finished) in
            
        }
        
        self.updateConstraintsIfNeeded()
    }

    func textViewDidBeginEditing(_ textView: YYTextView) {
        let fltTextHeight = textView.textLayout!.textBoundingSize.height;
        textView.isScrollEnabled = false //必须设置为NO
        textViewOriginFrame = textView.frame
        //这里动画的作用是抵消，YYTextView 内部动画 防止视觉上的跳动。
        UIView.animate(withDuration: 0.25, animations: {
            textView.height = fltTextHeight
        }) { (finished) in
            
        }
        self.height = textView.frame.size.height + 14
        textView.snp.remakeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(7)
            make.left.equalTo(self.snp.left).offset(15)
            make.right.equalTo(self.snp.right).offset(-15)
            make.bottom.equalTo(self.snp.bottom).offset(-7)
        }
        keybordFrame = self.frame
    }

    func textViewDidEndEditing(_ textView: YYTextView) {
        textView.snp.remakeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(7)
            make.left.equalTo(self.snp.left).offset(15)
            make.right.equalTo(self.snp.right).offset(-15)
            make.height.equalTo(30)
        }
        self.frame = originFrame
    }
    
}

enum KeyboardToobarType:Int {
    case cancel = 0
}
typealias KeyboardToobarClouse = (_ type:KeyboardToobarType) ->Void
class KeyboardToobar: UIToolbar {
    
    var keyboardToobarClouse:KeyboardToobarClouse!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let cancel = UIBarButtonItem.init(image: UIImage.init(named: "@")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(self.backToobarClick))
        cancel.tag = KeyboardToobarType.cancel.rawValue
        self.setShadowImage(UIImage.init(), forToolbarPosition: UIBarPosition.any)
        self.barTintColor = App_Theme_F6F6F6_Color
        self.setItems([], animated: true)
    }
    
    @objc func backToobarClick(_ sender:UIBarButtonItem){
        if self.keyboardToobarClouse != nil {
            self.keyboardToobarClouse(KeyboardToobarType.init(rawValue: sender.tag)!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TableViewHeaderView: UIView {
    
    var label:YYLabel!
    var mushLabel:YYLabel!
    
    init(frame:CGRect, title:String, isMush:Bool) {
        super.init(frame: frame)
        
        label = YYLabel.init(frame: CGRect.zero)
        label.text = title
        label.font = App_Theme_PinFan_M_12_Font
        label.textColor = App_Theme_666666_Color
        self.addSubview(label)
        
        if isMush {
            mushLabel = YYLabel.init(frame: CGRect.zero)
            mushLabel.text = "*"
            mushLabel.isHidden = false
            mushLabel.font = App_Theme_PinFan_M_12_Font
            mushLabel.textColor = App_Theme_FF4200_Color
            self.addSubview(mushLabel)
            mushLabel.snp.makeConstraints { (make) in
                make.left.equalTo(label.snp.right).offset(0)
                make.top.equalTo(self.snp.top).offset(9)
            }
        }else{
            if mushLabel != nil {
                mushLabel.isHidden = true
            }
        }
        
       
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.centerY.equalToSuperview()
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
