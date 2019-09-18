//
//  GloableView.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/9.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import SwifterSwift

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
typealias RightButtonClouse = (_ status:Bool) ->Void

class GLoabelNavigaitonBar:UIView {
    var titleLabel:YYLabel!
    var backButton:UIButton!
    var rigthButton:AnimationButton!
    
    var isSelect:Bool = false
    
    var gloabelBackButtonClouse:GloabelBackButtonClouse!
    var rightButtonClouse:RightButtonClouse!
    
    init(frame: CGRect, title:String, rightButton:AnimationButton?,  click:@escaping GloabelBackButtonClouse) {
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
            self.rigthButton = rightButton
            rightButton?.addTarget(self, action: #selector(self.rightButtonClick), for: .touchUpInside)
            self.addSubview(rightButton!)
            rightButton?.snp.makeConstraints { (make) in
                if #available(iOS 11.0, *) {
                    make.centerY.equalTo(self.snp.centerY).offset(NAV_HEIGHT/2 + 10)
                } else {
                    make.centerY.equalTo(self.snp.centerY).offset(10)
                }
                make.right.equalTo(self.snp.right).offset(-15)
                make.size.equalTo(CGSize.init(width: 61, height: 27))
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
        if self.rightButtonClouse != nil {
            self.rightButtonClouse(self.isSelect)
        }
    }
    
    func changeToolsButtonType(followed:Bool) {
        isSelect = followed
        if followed {
            rigthButton.setTitle("已关注", for: .normal)
            rigthButton.borderColor = App_Theme_FFAC1B_Color
            rigthButton.backgroundColor = UIColor.clear
            rigthButton.setTitleColor(App_Theme_FFAC1B_Color, for: .normal)
            rigthButton.borderWidth = 1
        }else {
            rigthButton.setTitle("关注", for: .normal)
            rigthButton.borderColor = App_Theme_FFAC1B_Color
            rigthButton.backgroundColor = App_Theme_FFAC1B_Color
            rigthButton.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
            rigthButton.borderWidth = 1
        }
        
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
        super.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height),tag: tag!) {
            click()
        }
        
        imageView = UIImageView.init(frame: CGRect.init(x: (frame.size.width - image.size.width) / 2, y: 0, width: image.size.width, height: image.size.height))
        imageView.image = image
        self.addSubview(imageView)
        
        label = YYLabel.init(frame: CGRect.init(x: 0, y: spacing + image.size.height, width: frame.size.width, height: font.capHeight + 5))
        label.textAlignment = .center
        label.text = title
        label.font = font
        label.textColor = titleColor
        self.isUserInteractionEnabled = true
        self.tag = tag!
        self.addSubview(label)
        
    }
    
    func changeContent(str:String?,image:UIImage?) {
        if str != nil {
            label.text = str
        }
        if image != nil {
            imageView.image = image
        }
    }
    
    func isEnable(ret:Bool) {
        self.isUserInteractionEnabled = ret
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import IQKeyboardManagerSwift

let YYTextViewFrameWidht:CGFloat = SCREENWIDTH - 16 * 2
let YYTextViewFrameMAXHeight:CGFloat = 100
typealias CustomViewCommentTextFieldSenderClick = (_ str:String) ->Void
typealias CustomViewCommentTextFieldEndClick = () ->Void
class CustomViewCommentTextField: UIView {
    
    var textView:YYTextView!
    var imageButton:AnimationButton!
    var touchClickClouse:TouchClickClouse!
    var originFrame:CGRect!
    var keybordFrame:CGRect!
    var textViewOriginFrame:CGRect!
    var customViewCommentTextFieldSenderClick:CustomViewCommentTextFieldSenderClick!
    var customViewCommentTextFieldEndClick:CustomViewCommentTextFieldEndClick!
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
            _  = self.newTapGesture { (gesture) in
                gesture.numberOfTouchesRequired = 1
                gesture.numberOfTapsRequired = 1
                }.whenTaped { (tap) in
                    click()
            }
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
        keybordFrame = self.frame
    }

    func textViewDidEndEditing(_ textView: YYTextView) {
        textView.snp.remakeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(7)
            make.left.equalTo(self.snp.left).offset(15)
            make.right.equalTo(self.snp.right).offset(-15)
            make.height.equalTo(30)
        }
        if customViewCommentTextFieldEndClick != nil {
            self.customViewCommentTextFieldEndClick()
        }
    }
    
}

enum KeyboardToobarType:Int {
    case cancel = 0
    case photos = 1
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
        
        let photos = UIBarButtonItem.init(image: UIImage.init(named: "photos")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(self.photosClick))
        photos.tag = KeyboardToobarType.photos.rawValue
        self.setShadowImage(UIImage.init(), forToolbarPosition: UIBarPosition.any)
        self.barTintColor = App_Theme_F6F6F6_Color
        self.setItems([cancel,photos], animated: true)
        
        
    }
    
    @objc func photosClick(_ sender:UIBarButtonItem){
        if self.keyboardToobarClouse != nil {
            self.keyboardToobarClouse(KeyboardToobarType.init(rawValue: sender.tag)!)
        }
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

enum LoginButtonType {
    case login
    case forgetPas
    case regise
    case senderCode
}

enum LoginType {
    case password
    case code
}

typealias LoginViewButtonClouse = (_ type:LoginButtonType) ->Void

class LoginView: UIView {
    
    var logoImage:UIImageView!
    
    var centenView:UIView!
    
    var phoneTextField:UITextField!
    var passwordTextField:UITextField!
    var codeTextField:UITextField!
    var rightImageView:UIButton!
    
    var senderCode:UIButton!
    
    var type:LoginType!
    
    var time:Timer!
    
    var isCheckBool:Bool = false
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 1))
    var lineLabel1 = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 1))

    var loginButton:AnimationButton!
    
    var forgetButton:UIButton!
    var registerButton:UIButton!
    var loginViewButtonClouse:LoginViewButtonClouse!
    
    var isCheckBoolProperty = MutableProperty<Bool>(false)

    
    var count:Int = 15
    
    init(frame: CGRect, type:LoginType) {
        self.type = type
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.setUpView(frame: frame, type: type)
        self.clipsToBounds = false
    }
    
    func setUpView(frame:CGRect,type:LoginType){
        
        centenView = UIView.init(frame: CGRect.init(x: 0, y: 37.5, width: frame.size.width, height: frame.size.height - 37.5))
        setMutiBorderRoundingCorners(centenView, corner: 15, byRoundingCorners: [UIRectCorner.topLeft,UIRectCorner.topRight,UIRectCorner.bottomRight,UIRectCorner.bottomLeft])
        centenView.backgroundColor = UIColor.init(hexString: "FFFFFF", transparency: 0.2)
        self.addSubview(centenView)
        
        logoImage = UIImageView.init()
        logoImage.cornerRadius = 15
        logoImage.image = UIImage.init(named: "logo1024")
        logoImage.layer.masksToBounds = true
        self.addSubview(logoImage)
        
        phoneTextField = UITextField.init()
        phoneTextField.keyboardType = .numberPad
        phoneTextField.textColor = App_Theme_FFFFFF_Color
        phoneTextField.setPlaceholder(str: "请输入手机号", font: App_Theme_PinFan_M_15_Font!, textColor: App_Theme_FFFFFF_Color!)
        centenView.addSubview(phoneTextField)
        
        
        let phoneTextFieldSignal = phoneTextField.reactive.continuousTextValues.map { (str) -> Bool in
            return str.isNumeric && str.count > 0
        }
        
        rightImageView = UIButton.init(type: .custom)
        rightImageView.setBackgroundImage(UIImage.init(named: "password_hidden"), for: .normal)
        rightImageView.tag = 100
        rightImageView.addAction({ (button) in
            if button?.tag == 100 {
                self.rightImageView.setBackgroundImage(UIImage.init(named: "password_show"), for: .normal)
                self.rightImageView.tag = 101
                self.passwordTextField.isSecureTextEntry = false
            }else{
                self.rightImageView.setBackgroundImage(UIImage.init(named: "password_hidden"), for: .normal)
                self.rightImageView.tag = 100
                self.passwordTextField.isSecureTextEntry = true
            }
        }, for: .touchUpInside)
        centenView.addSubview(rightImageView)
        
        if type == .password {
            passwordTextField = UITextField.init()
            passwordTextField.textType = .password
            passwordTextField.rightView = rightImageView
            passwordTextField.rightViewMode = .always
            passwordTextField.isSecureTextEntry = true
            passwordTextField.textColor = App_Theme_FFFFFF_Color
            passwordTextField.setPlaceholder(str: "请输入密码", font: App_Theme_PinFan_M_15_Font!, textColor: App_Theme_FFFFFF_Color!)
            centenView.addSubview(passwordTextField)
            
            
            let passwordTextFieldSignal = passwordTextField.reactive.continuousTextValues.map { (str) -> Bool in
                return str.count > 0
            }
            
            let confirmSignal = self.isCheckBoolProperty.signal.map { (ret) -> Bool in
                return ret
            }
            
            let combineLatest = confirmSignal.combineLatest(with: passwordTextFieldSignal).map { (ret,ret1) -> Bool in
                return ret && ret1
            }
            
            combineLatest.combineLatest(with: phoneTextFieldSignal).observeValues { (phone,pas) in
                if phone && pas  {
                    self.changeEnabel(isEnabled: true)
                }else{
                    self.changeEnabel(isEnabled: false)
                }
            }
        }else{
            codeTextField = UITextField.init()
            codeTextField.textColor = App_Theme_FFFFFF_Color
            codeTextField.setPlaceholder(str: "请输入验证码", font: App_Theme_PinFan_M_15_Font!, textColor: App_Theme_FFFFFF_Color!)
            centenView.addSubview(codeTextField)
            
            let codeTextFieldSignal = codeTextField.reactive.continuousTextValues.map { (str) -> Bool in
                return str.count > 0
            }
            
            let confirmSignal = self.isCheckBoolProperty.signal.map { (ret) -> Bool in
                return ret
            }
            
            let combineLatest = confirmSignal.combineLatest(with: codeTextFieldSignal).map { (ret,ret1) -> Bool in
                return ret && ret1
            }
            
            combineLatest.combineLatest(with: phoneTextFieldSignal).observeValues { (phone,code) in
                if phone && code {
                    self.changeEnabel(isEnabled: true)
                }else{
                    self.changeEnabel(isEnabled: false)
                }
            }
            
            senderCode = UIButton.init(type: .custom)
            senderCode.setTitle("发送验证码", for: .normal)
            senderCode.titleLabel?.font = App_Theme_PinFan_M_14_Font
            senderCode.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
            senderCode.addAction({ (button) in
                self.count = 15
                self.timeDone()
            }, for: .touchUpInside)
            self.addSubview(senderCode)
        }
        
        loginButton = AnimationButton.init(type: .custom)
        loginButton.isEnabled = false
        loginButton.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
        loginButton.setTitle("登录", for: .normal)
        loginButton.titleLabel?.font = App_Theme_PinFan_M_15_Font
        loginButton.backgroundColor = App_Theme_B5B5B5_Color
        loginButton.cornerRadius = 24
        loginButton.addAction({ (button) in
            if self.loginViewButtonClouse != nil {
                self.loginViewButtonClouse(.login)
            }
            self.relaseTimer()
        }, for: .touchUpInside)
        centenView.addSubview(loginButton)
        
        
        
        forgetButton = AnimationButton.init(type: .custom)
        forgetButton.setTitleColor(UIColor.init(hexString: "FFFFFF", transparency: 0.5), for: .normal)
        forgetButton.setTitle("忘记密码", for: .normal)
        forgetButton.addAction({ (button) in
            if self.loginViewButtonClouse != nil {
                self.loginViewButtonClouse(.forgetPas)
            }
            self.relaseTimer()
        }, for: .touchUpInside)
        forgetButton.titleLabel?.font = App_Theme_PinFan_M_14_Font
        centenView.addSubview(forgetButton)
        
        registerButton = AnimationButton.init(type: .custom)
        registerButton.setTitleColor(UIColor.init(hexString: "FFFFFF", transparency: 0.5), for: .normal)
        registerButton.setTitle("注册账号", for: .normal)
        registerButton.addAction({ (button) in
            if self.loginViewButtonClouse != nil {
                self.loginViewButtonClouse(.regise)
            }
            self.relaseTimer()
        }, for: .touchUpInside)
        registerButton.titleLabel?.font = App_Theme_PinFan_M_14_Font
        centenView.addSubview(registerButton)
        
        centenView.addSubview(lineLabel)
        centenView.addSubview(lineLabel1)
        
        self.updateConstraints()
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
    
    
    func changeEnabel(isEnabled:Bool)
    {
        loginButton.isEnabled = isEnabled
        if isEnabled {
            loginButton.setTitleColor(App_Theme_06070D_Color, for: .normal)
            loginButton.backgroundColor = App_Theme_FFCB00_Color
        }else{
            loginButton.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
            loginButton.backgroundColor = App_Theme_B5B5B5_Color
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        centenView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(self.snp.top).offset(37.5)
        }
        
        logoImage.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 75, height: 75))
            make.top.equalTo(self.snp.top).offset(0)
            make.centerX.equalToSuperview()
        }
        
        phoneTextField.snp.makeConstraints { (make) in
            make.left.equalTo(centenView.snp.left).offset(24)
            make.right.equalTo(centenView.snp.right).offset(-24)
            make.top.equalTo(centenView.snp.top).offset(60)
        }
        
        lineLabel.snp.makeConstraints { (make) in
            make.left.equalTo(centenView.snp.left).offset(24)
            make.right.equalTo(centenView.snp.right).offset(-24)
            make.top.equalTo(self.phoneTextField.snp.bottom).offset(15)
            make.height.equalTo(1)
        }
        
        if self.type == .password {
            passwordTextField.snp.makeConstraints { (make) in
                make.left.equalTo(centenView.snp.left).offset(24)
                make.right.equalTo(centenView.snp.right).offset(-24)
                make.top.equalTo(self.lineLabel.snp.bottom).offset(16)
            }
            
            rightImageView.snp.makeConstraints { (make) in
                make.right.equalTo(centenView.snp.right).offset(-24)
                make.top.equalTo(self.phoneTextField.snp.bottom).offset(16)
                make.size.equalTo(CGSize.init(width: 24, height: 16))
            }
            
            lineLabel1.snp.makeConstraints { (make) in
                make.left.equalTo(centenView.snp.left).offset(24)
                make.right.equalTo(centenView.snp.right).offset(-24)
                make.top.equalTo(self.passwordTextField.snp.bottom).offset(15)
                make.height.equalTo(1)
            }
        }else{
            codeTextField.snp.makeConstraints { (make) in
                make.left.equalTo(centenView.snp.left).offset(24)
                make.right.equalTo(centenView.snp.right).offset(-24)
                make.top.equalTo(self.lineLabel.snp.bottom).offset(16)
            }
            
            lineLabel1.snp.makeConstraints { (make) in
                make.left.equalTo(centenView.snp.left).offset(24)
                make.right.equalTo(centenView.snp.right).offset(-24)
                make.top.equalTo(self.codeTextField.snp.bottom).offset(15)
                make.height.equalTo(1)
            }
            
            senderCode.snp.makeConstraints { (make) in
                make.right.equalTo(centenView.snp.right).offset(-24)
                make.top.equalTo(self.phoneTextField.snp.bottom).offset(30)
            }
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.left.equalTo(centenView.snp.left).offset(24)
            make.right.equalTo(centenView.snp.right).offset(-24)
            make.top.equalTo(self.lineLabel1.snp.bottom).offset(49)
            make.bottom.equalTo(centenView.snp.bottom).offset(-45)
            make.size.equalTo(47)
        }
        
        forgetButton.snp.makeConstraints { (make) in
            make.left.equalTo(loginButton.snp.left).offset(0)
            make.top.equalTo(self.lineLabel1.snp.bottom).offset(13)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.right.equalTo(loginButton.snp.right).offset(0)
            make.top.equalTo(self.lineLabel1.snp.bottom).offset(13)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


enum RegisterViewType {
    case login
    case regise
    case senderCode
}

typealias RegisterViewButtonClouse = (_ type:RegisterViewType) ->Void

class RegisterView: UIView {
    
    var logoImage:UIImageView!
    
    var centenView:UIView!
    
    var phoneTextField:UITextField!
    var passwordTextField:UITextField!
    var codeTextField:UITextField!
    var rightImageView:UIButton!
    
    var senderCode:UIButton!
    
    var time:Timer!
    
    var isCheckBool:Bool = true
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 1))
    var lineLabel1 = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 1))
    var lineLabel2 = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 1))
    
    var registerButton:AnimationButton!
    
    var loginButton:UIButton!
    var registerViewButtonClouse:RegisterViewButtonClouse!
    
    var isCheckBoolProperty = MutableProperty<Bool>(false)
    
    var count:Int = 15
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.setUpView(frame: frame)
        self.clipsToBounds = false
    }
    
    func setUpView(frame:CGRect){
        
        centenView = UIView.init(frame: CGRect.init(x: 0, y: 37.5, width: frame.size.width, height: frame.size.height - 37.5))
        setMutiBorderRoundingCorners(centenView, corner: 15, byRoundingCorners: [UIRectCorner.topLeft,UIRectCorner.topRight,UIRectCorner.bottomRight,UIRectCorner.bottomLeft])
        centenView.backgroundColor = UIColor.init(hexString: "FFFFFF", transparency: 0.2)
        self.addSubview(centenView)
        
        logoImage = UIImageView.init()
        logoImage.cornerRadius = 15
        logoImage.image = UIImage.init(named: "logo1024")
        logoImage.layer.masksToBounds = true
        self.addSubview(logoImage)
        
        phoneTextField = UITextField.init()
        phoneTextField.keyboardType = .numberPad
        phoneTextField.textColor = App_Theme_FFFFFF_Color
        phoneTextField.setPlaceholder(str: "请输入手机号", font: App_Theme_PinFan_M_15_Font!, textColor: App_Theme_FFFFFF_Color!)
        centenView.addSubview(phoneTextField)
        
        
        let phoneTextFieldSignal = phoneTextField.reactive.continuousTextValues.map { (str) -> Bool in
            return str.isNumeric && str.count > 0
        }
        
        rightImageView = UIButton.init(type: .custom)
        rightImageView.setBackgroundImage(UIImage.init(named: "password_hidden"), for: .normal)
        rightImageView.tag = 100
        rightImageView.addAction({ (button) in
            if button?.tag == 100 {
                self.rightImageView.setBackgroundImage(UIImage.init(named: "password_show"), for: .normal)
                self.rightImageView.tag = 101
                self.passwordTextField.isSecureTextEntry = false
            }else{
                self.rightImageView.setBackgroundImage(UIImage.init(named: "password_hidden"), for: .normal)
                self.rightImageView.tag = 100
                self.passwordTextField.isSecureTextEntry = true
            }
        }, for: .touchUpInside)
        centenView.addSubview(rightImageView)
        passwordTextField = UITextField.init()
        passwordTextField.textType = .password
        passwordTextField.rightView = rightImageView
        passwordTextField.rightViewMode = .always
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textColor = App_Theme_FFFFFF_Color
        passwordTextField.setPlaceholder(str: "请输入密码", font: App_Theme_PinFan_M_15_Font!, textColor: App_Theme_FFFFFF_Color!)
        centenView.addSubview(passwordTextField)
        
        
        let passwordTextFieldSignal = passwordTextField.reactive.continuousTextValues.map { (str) -> Bool in
            return str.count > 0
        }
        
        let codeSignal =  passwordTextFieldSignal.combineLatest(with: phoneTextFieldSignal).map { (phone,pas) -> Bool in
            return phone && pas
        }
        
        
        codeTextField = UITextField.init()
        codeTextField.textColor = App_Theme_FFFFFF_Color
        centenView.addSubview(codeTextField)
        codeTextField.setPlaceholder(str: "请输入验证码", font: App_Theme_PinFan_M_15_Font!, textColor: App_Theme_FFFFFF_Color!)
        let codeTextFieldSignal = codeTextField.reactive.continuousTextValues.map { (str) -> Bool in
            return str.count > 0
        }
        
        let confirmSignal = self.isCheckBoolProperty.signal.map { (ret) -> Bool in
            return ret
        }
        
        let combineLatest = confirmSignal.combineLatest(with: codeTextFieldSignal).map { (ret,ret1) -> Bool in
            return ret && ret1
        }
        
        combineLatest.combineLatest(with: codeSignal).observeValues { (phone,code) in
            if phone && code {
                self.changeEnabel(isEnabled: true)
            }else{
                self.changeEnabel(isEnabled: false)
            }
        }
        
        senderCode = UIButton.init(type: .custom)
        senderCode.setTitle("发送验证码", for: .normal)
        senderCode.titleLabel?.font = App_Theme_PinFan_M_14_Font
        senderCode.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
        senderCode.addAction({ (button) in
            self.count = 15
            self.timeDone()
            if self.registerViewButtonClouse != nil {
                self.registerViewButtonClouse(.senderCode)
            }
        }, for: .touchUpInside)
        self.addSubview(senderCode)
        
        registerButton = AnimationButton.init(type: .custom)
        registerButton.isEnabled = false
        registerButton.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
        registerButton.setTitle("注册", for: .normal)
        registerButton.titleLabel?.font = App_Theme_PinFan_M_15_Font
        registerButton.backgroundColor = App_Theme_B5B5B5_Color
        registerButton.cornerRadius = 24
        registerButton.addAction({ (button) in
            if self.registerViewButtonClouse != nil {
                self.registerViewButtonClouse(.regise)
            }
            self.relaseTimer()
        }, for: .touchUpInside)
        centenView.addSubview(registerButton)
        
        
        
        loginButton = AnimationButton.init(type: .custom)
        loginButton.setTitleColor(UIColor.init(hexString: "FFFFFF", transparency: 0.5), for: .normal)
        loginButton.setTitle("已有账号登录", for: .normal)
        loginButton.addAction({ (button) in
            if self.registerViewButtonClouse != nil {
                self.registerViewButtonClouse(.login)
            }
            self.relaseTimer()
        }, for: .touchUpInside)
        loginButton.titleLabel?.font = App_Theme_PinFan_M_14_Font
        centenView.addSubview(loginButton)
        
        centenView.addSubview(lineLabel)
        centenView.addSubview(lineLabel1)
        centenView.addSubview(lineLabel2)
        
        self.updateConstraints()
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
    
    
    func changeEnabel(isEnabled:Bool)
    {
        registerButton.isEnabled = isEnabled
        if isEnabled {
            registerButton.setTitleColor(App_Theme_06070D_Color, for: .normal)
            registerButton.backgroundColor = App_Theme_FFCB00_Color
        }else{
            registerButton.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
            registerButton.backgroundColor = App_Theme_B5B5B5_Color
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        centenView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(self.snp.top).offset(37.5)
        }
        
        logoImage.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 75, height: 75))
            make.top.equalTo(self.snp.top).offset(0)
            make.centerX.equalToSuperview()
        }
        
        phoneTextField.snp.makeConstraints { (make) in
            make.left.equalTo(centenView.snp.left).offset(24)
            make.right.equalTo(centenView.snp.right).offset(-24)
            make.top.equalTo(centenView.snp.top).offset(60)
        }
        
        lineLabel.snp.makeConstraints { (make) in
            make.left.equalTo(centenView.snp.left).offset(24)
            make.right.equalTo(centenView.snp.right).offset(-24)
            make.top.equalTo(self.phoneTextField.snp.bottom).offset(15)
            make.height.equalTo(1)
        }
        passwordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(centenView.snp.left).offset(24)
            make.right.equalTo(centenView.snp.right).offset(-24)
            make.top.equalTo(self.lineLabel.snp.bottom).offset(16)
        }
        
        rightImageView.snp.makeConstraints { (make) in
            make.right.equalTo(centenView.snp.right).offset(-24)
            make.top.equalTo(self.phoneTextField.snp.bottom).offset(16)
            make.size.equalTo(CGSize.init(width: 24, height: 16))
        }
        
        lineLabel1.snp.makeConstraints { (make) in
            make.left.equalTo(centenView.snp.left).offset(24)
            make.right.equalTo(centenView.snp.right).offset(-24)
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(15)
            make.height.equalTo(1)
        }
        
        codeTextField.snp.makeConstraints { (make) in
            make.left.equalTo(centenView.snp.left).offset(24)
            make.right.equalTo(centenView.snp.right).offset(-24)
            make.top.equalTo(self.lineLabel1.snp.bottom).offset(16)
        }
        
        lineLabel2.snp.makeConstraints { (make) in
            make.left.equalTo(centenView.snp.left).offset(24)
            make.right.equalTo(centenView.snp.right).offset(-24)
            make.top.equalTo(self.codeTextField.snp.bottom).offset(15)
            make.height.equalTo(1)
        }
        
        senderCode.snp.makeConstraints { (make) in
            make.right.equalTo(centenView.snp.right).offset(-24)
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(30)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.left.equalTo(centenView.snp.left).offset(24)
            make.right.equalTo(centenView.snp.right).offset(-24)
            make.top.equalTo(self.lineLabel2.snp.bottom).offset(49)
            make.bottom.equalTo(centenView.snp.bottom).offset(-45)
            make.size.equalTo(47)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(centenView.snp.centerX)
            make.top.equalTo(self.registerButton.snp.bottom).offset(16)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum GloableThirdLoginType:Int {
    case weibo = 0
    case weichat = 1
    case qq = 2
}

typealias GloableThirdLoginClouse = (_ type:GloableThirdLoginType)->Void
let GloableThirdLoginMargin:CGFloat = 40
let GloableThirdLoginImageWidth:CGFloat = 36

class GloableThirdLogin: UIView {
    
    var detailLabel:YYLabel!
    var centenView:UIView!
    var gloableThirdLoginClouse:GloableThirdLoginClouse!
    let images = ["weibo","wechat","qq"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    func setUpView(){
        detailLabel = YYLabel.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 20))
        detailLabel.textAlignment = .center
        detailLabel.backgroundColor = .clear
        detailLabel.font = App_Theme_PinFan_M_14_Font
        detailLabel.textColor = App_Theme_FFFFFF_Color
        detailLabel.text = "选择其他方式登录"
        self.addSubview(detailLabel)
        
        centenView = UIView.init(frame: CGRect.init(x: (SCREENWIDTH - ( CGFloat(images.count) * GloableThirdLoginImageWidth + CGFloat((CGFloat(images.count) - 1)) * GloableThirdLoginMargin)) / 2, y: detailLabel.frame.maxY + 21, width: CGFloat(images.count) * GloableThirdLoginImageWidth + CGFloat((CGFloat(images.count) - 1)) * GloableThirdLoginMargin, height: GloableThirdLoginImageWidth))
        self.addSubview(centenView)
        
        for index in 0...2{
            let button = AnimationButton.init(type: .custom)
            button.tag = GloableThirdLoginType.init(rawValue: index)!.rawValue
            button.setBackgroundImage(UIImage.init(named: images[index]), for: .normal)
            button.frame = CGRect.init(x: 0 + (GloableThirdLoginMargin + GloableThirdLoginImageWidth) * CGFloat(index), y: 0, width: GloableThirdLoginImageWidth, height: GloableThirdLoginImageWidth)
            button.addAction({ (button) in
                if self.gloableThirdLoginClouse != nil {
                    self.gloableThirdLoginClouse(GloableThirdLoginType.init(rawValue: button!.tag)!)
                }
            }, for: UIControl.Event.touchUpInside)
            centenView.addSubview(button)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias CofirmProtocolViewClouse = () ->Void

class CofirmProtocolView: UIView {
    
    var checkBox:UIButton!
    var titleLabel:YYLabel!
    var detailLabel:YYLabel!
    var cofirmProtocolViewClouse:CofirmProtocolViewClouse!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        checkBox = UIButton.init(type: .custom)
        checkBox.layer.masksToBounds = true
        checkBox.cornerRadius = 8.5
        checkBox.tag = 100
        checkBox.setBackgroundImage(UIImage.init(named: "check_normal"), for: .normal)
        self.addSubview(checkBox)
        
        detailLabel = YYLabel.init()
        detailLabel.textAlignment = .left
        _ = detailLabel.newTapGesture(config: { (config) in
            config.numberOfTouchesRequired = 1
            config.numberOfTapsRequired = 1
        }).whenTaped(handler: { (gesture) in
            if self.cofirmProtocolViewClouse != nil {
                self.cofirmProtocolViewClouse()
            }
        })
        detailLabel.font = App_Theme_PinFan_M_12_Font
        detailLabel.textColor = App_Theme_FFFFFF_Color
        let attributedText = NSMutableAttributedString.init(string: "《隐私用户条款约定》")
        attributedText.yy_lineSpacing = 3
        attributedText.yy_color = App_Theme_FFFFFF_Color
        attributedText.yy_setTextUnderline(YYTextDecoration.init(style: YYTextLineStyle.single), range: NSRange.init(location: 1, length: attributedText.length - 2))
        detailLabel.attributedText = attributedText
        self.addSubview(detailLabel)
        
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .left
        titleLabel.font = App_Theme_PinFan_M_12_Font
        titleLabel.textColor = App_Theme_FFFFFF_Color
        titleLabel.text = "同意"
        
        self.addSubview(titleLabel)
        self.updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        checkBox.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(-75)
            make.centerY.equalToSuperview()
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.checkBox.snp.right).offset(9)
            make.centerY.equalToSuperview()
        }
    }
}

let ButtonHeight:CGFloat = 54
let ContentWidth:CGFloat = 290
typealias GloableAlertViewButtonActionClouse = (_ tag:Int) ->Void
typealias GloableAlertViewCancelActionClouse = () ->Void
class GloableAlertView: UIView {
    var backView:UIView!
    var cententView:UIView!
    init(titles:[String], cancelTitle:String, buttonClick:@escaping GloableAlertViewButtonActionClouse, cancelAction:@escaping GloableAlertViewCancelActionClouse) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        
        backView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        backView.backgroundColor = UIColor.init(hexString: "000000", transparency: 0.5)
        _ = backView.newTapGesture(config: { (tapGestup) in
            tapGestup.numberOfTapsRequired = 1
            tapGestup.numberOfTouchesRequired = 1
        }).whenTaped(handler: { (tap) in
            self.disMissView()
        })
        self.addSubview(backView)
        
        cententView = UIView.init()
        cententView.cornerRadius = 8
        cententView.backgroundColor = App_Theme_FFFFFF_Color
        self.addSubview(cententView)
        cententView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: ContentWidth, height: CGFloat(titles.count + 1) * ButtonHeight))
        }
        
        for index in 0...titles.count - 1 {
            let frame = CGRect.init(x: 0, y: CGFloat(index) * ButtonHeight, width: ContentWidth, height: ButtonHeight)
            let button = self.createTitleButton(title: titles[index], frame: frame)
            button.tag = index + 1000
            button.reactive.controlEvents(.touchUpInside).observeValues { (btn) in
                buttonClick(btn.tag - 1000)
                self.disMissView()
            }
            cententView.addSubview(button)
            let lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 35, y: CGFloat(index + 1) * ButtonHeight, width: ContentWidth - 70, height: 1))
            cententView.addSubview(lineLabel)
        }
        
        let frame = CGRect.init(x: 0, y: CGFloat(titles.count) * ButtonHeight, width: ContentWidth, height: ButtonHeight)
        let cancelButton = self.createTitleButton(title: cancelTitle, frame: frame)
        cancelButton.tag = 10000
        cancelButton.setTitleColor(App_Theme_666666_Color, for: .normal)
        cancelButton.reactive.controlEvents(.touchUpInside).observeValues { (btn) in
            cancelAction()
            self.removeFromSuperview()
        }
        cententView.addSubview(cancelButton)
    }
    
    func disMissView(){
        self.removeFromSuperview()
    }
    
    func createTitleButton(title:String, frame:CGRect) ->UIButton{
        let button = UIButton.init(type: .custom)
        button.frame = frame
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = App_Theme_PinFan_M_15_Font
        button.setTitleColor(App_Theme_06070D_Color, for: .normal)
        button.setTitleColor(App_Theme_FFCB00_Color, for: .selected)
        return button
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias AdViewClouse = () ->Void
class AdView: UIView {
    
    var imageView:UIImageView!
    var doneButton:AnimationButton!
    
    var count = 3
    var time:Timer!
    
    init(frame: CGRect, url:String, click:@escaping AdViewClouse) {
        super.init(frame: frame)
        imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        imageView.sd_crope_imageView(url: url, imageView: imageView, placeholderImage: nil) { (image, url, type, stage, error) in
            
        }
        
        doneButton = AnimationButton.init(type: .custom)
        time  = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (time) in
            if self.count > 0 {
                self.doneButton.setTitle("跳过\(self.count)", for: .normal)
                self.count = self.count - 1
            }else{
                self.doneButton.setTitle("跳过", for: .normal)
                self.time.invalidate()
                self.disMiss()
            }
        })
        doneButton.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
        doneButton.titleLabel?.font = App_Theme_PinFan_R_14_Font
        doneButton.reactive.controlEvents(.touchUpInside).observeValues { (button) in
            self.disMiss()
        }
        self.addSubview(doneButton)
        
        doneButton.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.snp.top).offset(NAV_HEIGHT + 30)
            } else {
                 make.top.equalTo(self.snp.top).offset(30)
                // Fallback on earlier versions
            }
            make.right.equalTo(self.snp.right).offset(-15)
            make.size.equalTo(CGSize.init(width: 50, height: 20))
        }
        
        _ = self.newTapGesture(config: { (config) in
            config.numberOfTapsRequired = 1
            config.numberOfTouchesRequired = 1
        }).whenTaped(handler: { (guest) in
            click()
        })
    }
    
    func disMiss(){
        self.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
enum FilterBottomViewClickType {
    case allselect
    case allunselect
    case done
}
typealias FilterBottomViewClick = (_ type:FilterBottomViewClickType) ->Void
class FilterBottomView: UIView {
    var allSelectButton:AnimationButton!
    var allUnselectButton:AnimationButton!
    var doneButton:UIButton!
    
    var selectLabel:YYLabel!
    
    let lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 54, y: 18, width: 1, height: 12))
    init(frame:CGRect, number:String, click:@escaping FilterBottomViewClick) {
        super.init(frame: frame)
        self.backgroundColor = App_Theme_FFFFFF_Color
        allSelectButton = AnimationButton.init(type: .custom)
        allSelectButton.setTitle("全选", for: .normal)
        allSelectButton.addAction({ (button) in
            click(.allselect)
        }, for: .touchUpInside)
        allSelectButton.setTitleColor(App_Theme_06070D_Color!, for: .normal)
        allSelectButton.titleLabel?.font = App_Theme_PinFan_M_12_Font
        self.addSubview(allSelectButton)
        allSelectButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 54, height: 48))
            make.left.equalToSuperview()
        }
        
        allUnselectButton = AnimationButton.init(type: .custom)
        allUnselectButton.setTitle("反选", for: .normal)
        allUnselectButton.addAction({ (button) in
            click(.allunselect)
        }, for: .touchUpInside)
        allUnselectButton.setTitleColor(App_Theme_06070D_Color!, for: .normal)
        allUnselectButton.titleLabel?.font = App_Theme_PinFan_M_12_Font
        self.addSubview(allUnselectButton)
        
        allUnselectButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 54, height: 48))
            make.left.equalTo(self.allSelectButton.snp.right).offset(0)
        }
        
        
        doneButton = AnimationButton.init(type: .custom)
        doneButton.setTitle("确定", for: .normal)
        doneButton.addAction({ (button) in
            click(.done)
        }, for: .touchUpInside)
        doneButton.setTitleColor(App_Theme_06070D_Color!, for: .normal)
        doneButton.titleLabel?.font = App_Theme_PinFan_M_12_Font
        doneButton.backgroundColor = App_Theme_FFD512_Color
        self.addSubview(doneButton)
        doneButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 120, height: 48))
            make.right.equalTo(self.snp.right).offset(0)
        }
        
        selectLabel = YYLabel.init()
        selectLabel.textAlignment = .left
        selectLabel.font = App_Theme_PinFan_M_10_Font
        selectLabel.textColor = App_Theme_666666_Color
        selectLabel.text = "已隐藏比赛: \(number) 场"
        self.addSubview(selectLabel)
        selectLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(17)
            make.left.equalTo(self.allUnselectButton.snp.right).offset(0)
        }
        
        self.addSubview(lineLabel)
        lineLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(17)
            make.size.equalTo(CGSize.init(width: 1, height: 12))
            make.left.equalTo(self.allSelectButton.snp.right).offset(0)
        }
    }
    
    func changeSelectLabelText(number:String){
        selectLabel.text = "已隐藏比赛: \(number) 场"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias GloableSignViewClick = () ->Void

class GloableSignView: UIView {
    var backView:UIView!
    var imageView:UIImageView!
    var closeView:UIImageView!
    var gloableSignViewClick:GloableSignViewClick!
    
    init(frame: CGRect, img:String, click:@escaping GloableSignViewClick) {
        super.init(frame: frame)
        self.gloableSignViewClick = click
        self.backgroundColor = .clear
        self.setUpView(img:img)
    }
    
    func setUpView(img:String){
        backView = UIView.init()
        backView.backgroundColor = UIColor.init(hexString: "000000", transparency: 0.6)
        backView.isUserInteractionEnabled = true
        backView.newTapGesture { (tap) in
            tap.numberOfTapsRequired = 1
            tap.numberOfTouchesRequired = 1
            }.whenTaped { (tap) in
                self.disMissView()
        }
        
        self.addSubview(backView)
        
        imageView = UIImageView.init()
        imageView.newTapGesture { (tap) in
            tap.numberOfTapsRequired = 1
            tap.numberOfTouchesRequired = 1
            }.whenTaped { (tap) in
                if self.gloableSignViewClick != nil {
                    self.gloableSignViewClick()
                    self.disMissView()
                }
        }
        imageView.sd_crope_imageView_withMaxWidth(url: img, imageSize: nil, placeholderImage: nil) { (image, error, cacheType, url) in
            if error == nil {
                self.imageView.image = image
            }
        }
        imageView.image = UIImage.init(named: "sign")
        self.addSubview(imageView)
        
        
        closeView = UIImageView.init()
        closeView.image = UIImage.init(named: "clouse")
        closeView.isUserInteractionEnabled = true
        closeView.newTapGesture { (tap) in
            tap.numberOfTapsRequired = 1
            tap.numberOfTouchesRequired = 1
            }.whenTaped { (tap) in
                self.disMissView()
        }
        self.addSubview(closeView)
        self.updateConstraints()
    }
    
    func viewCellData(imageUrl:String){
        
    }
    
    func disMissView(){
        self.removeFromSuperview()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        backView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        closeView.snp.makeConstraints { (make) in
            make.right.equalTo(self.imageView.snp.right).offset(0)
            make.bottom.equalTo(self.imageView.snp.top).offset(0)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias GloableAdViewComplet = () ->Void
class GloableAdView: UIView {
    
    var imageView:UIImageView!
    var buttomImageView:UIImageView!
    var disMissBtn:UIButton!
    var gloableAdViewComplet:GloableAdViewComplet!
    
    init(frame: CGRect, image:String, compley:GloableAdViewComplet!) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        self.setUpView(image: image)
        self.gloableAdViewComplet = compley
        disMissBtn = UIButton.init(frame: CGRect.init(x: SCREENWIDTH - 15 - 70, y: SCREENHEIGHT - 95 - 30, width: 70, height: 30))
        
        disMissBtn.addAction({ (button) in
            self.disMissView()
        }, for: UIControl.Event.touchUpInside)
        var count = 3
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (time) in
            self.disMissBtn.setTitle("跳过 \(count)s", for: .normal)
            count = count - 1
            if count == 0 {
                self.disMissView()
            }
        })
        self.addSubview(disMissBtn)
    }
    
    func disMissView() {
//        self.removeFromSuperview()
//        if self.gloableAdViewComplet != nil {
//            self.gloableAdViewComplet()
//        }
    }
    
    func setUpView(image:String){
        imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT - 95))
        imageView.sd_crope_imageView(url: image, imageView: imageView, placeholderImage: nil) { (image, url, type, stage, error) in
            
        }
        self.addSubview(imageView)
        
        let bottomView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 95))
        bottomView.backgroundColor = .white
        let image = UIImage.init(named: "ad_logo")
        buttomImageView = UIImageView.init(frame:CGRect.zero)
        buttomImageView.image = image
        bottomView.addSubview(buttomImageView)
        buttomImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        self.addSubview(bottomView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
