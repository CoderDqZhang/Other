//
//  GloableView.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/9.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import Foundation

class GloableLineLabel: UIView {
    
    class func createLineLabel(frame:CGRect) -> UILabel{
        let lable = UILabel.init(frame: frame)
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
    var titleLabel:UILabel!
    var backButton:UIButton!
    var gloabelBackButtonClouse:GloabelBackButtonClouse!
    
    init(frame: CGRect, title:String, rightButton:UIButton?,  click:@escaping GloabelBackButtonClouse) {
        super.init(frame:frame)
        self.gloabelBackButtonClouse = click
        titleLabel = UILabel.init()
        titleLabel.text = title
        titleLabel.font = App_Theme_PinFan_R_17_Font
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
            titleLabel.textColor = UIColor.init(hexString: "FFFFFF", transparency: transparency)
        }
        self.backgroundColor = UIColor.init(hexString: "1B85FD", transparency: transparency)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomViewButtonTopImageAndBottomLabel: AnimationTouchView {
    
    var imageView:UIImageView!
    var label:UILabel!
    init(frame:CGRect, title:String, image:UIImage, tag:NSInteger?, titleColor:UIColor,spacing:CGFloat, font:UIFont, click:@escaping TouchClickClouse) {
        super.init(frame: CGRect.zero) {
            click()
        }
        
        imageView = UIImageView.init(frame: CGRect.init(x: (frame.size.width - image.size.width) / 2, y: 0, width: image.size.width, height: image.size.height))
        imageView.image = image
        self.addSubview(imageView)
        
        label = UILabel.init(frame: CGRect.init(x: 0, y: spacing + image.size.height, width: frame.size.width, height: font.capHeight + 2))
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

class CustomViewCommentTextField: UIView,UITextFieldDelegate {
    
    var textField:UITextField!
    var imageButton:AnimationButton!
    var touchClickClouse:TouchClickClouse!
    var originFrame:CGRect!
    init(frame:CGRect, placeholderString:String, click:@escaping TouchClickClouse) {
        super.init(frame: frame)
        originFrame = frame
        textField = UITextField.init(frame: CGRect.init(x: 16, y: 7, width: SCREENWIDTH - 16 * 2 , height: 30))
        textField.borderColor = App_Theme_B4B4B4_Color
        textField.addPaddingLeft(17)
        textField.placeholderFont = App_Theme_PinFan_R_12_Font!
        textField.setPlaceHolderTextColor(App_Theme_BBBBBB_Color!)
        textField.cornerRadius = 4
        textField.borderWidth = 1
        textField.delegate = self
        textField.placeholder = placeholderString
        self.addSubview(textField)
        let singTap = UITapGestureRecognizerManager.shareInstance.initTapGestureRecognizer {
            click()
        }
        
        if #available(iOS 11.0, *) {
            IQKeyboardManager.shared.keyboardDistanceFromTextField = -TABBAR_HEIGHT
        } else {
            // Fallback on earlier versions
            IQKeyboardManager.shared.keyboardDistanceFromTextField = -20
        }
        
        self.addGestureRecognizer(singTap)
//        self.registerNotification()

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
//            self.center = CGPoint.init(x: self.frame.size.width, y: self.frame.origin.y)
//            let user_info = notification.userInfo
//            let keyboardRect = (user_info?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//
//            let y = keyboardRect.origin.y
//            let y2 = (self.frame.origin.y) + (self.frame.size.height) + 5
//            let offset_y = y2 > y ? (y2-y):(0)
//
//            print(keyboardRect)//896 *
//            UIView.animate(withDuration: 0.25, animations: {
//                self.frame = CGRect.init(x: 0, y: 760, width: SCREENWIDTH, height: 44)
////                self.transform = CGAffineTransform.init(translationX: 0, y: 2)
//
//
//            })
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
//        self.frame.size = CGSize.init(width: originFrame.size.width, height: 44)
//        self.frame = CGRect.init(x: 0, y: 760, width: SCREENWIDTH, height: 44)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        if #available(iOS 11.0, *) {
//            self.frame = originFrame
//        } else {
//            // Fallback on earlier versions
//            self.frame = originFrame
//        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
