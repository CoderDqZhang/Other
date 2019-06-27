//
//  ChangeInfoViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

enum ChangeInfoType{
    case desc
    case email
    case name
}

typealias ChangeInfoViewControllerClouse = (_ type:ChangeInfoType, _ str:String) ->Void

class ChangeInfoViewController: BaseViewController {

    var changeText:UITextField!
    var detailLable:YYLabel!
    var infoLable:YYLabel!
    
    var changeView:UIView!
    
    var anmationButton:AnimationButton!
    
    var type:ChangeInfoType!
    var detailString:String = ""
    var changeInfoViewControllerClouse:ChangeInfoViewControllerClouse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = App_Theme_F6F6F6_Color
        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(self.leftBarItemClick(_:)))
    }
    
    @objc func leftBarItemClick(_ sender:UIBarButtonItem) {
        self.view.endEditing(true)
        
    }
    
    @objc func rightBarItemClick(_ sender:UIBarButtonItem) {
        
        if detailString.count == 0 {
            _ = Tools.shareInstance.showMessage(self.getControllerView(), msg: "请输入字符", autoHidder: true)
        }
        if self.type == .email {
            let ret = detailString.isValidEmail
            if !ret {
                _ = Tools.shareInstance.showMessage(self.getControllerView(), msg: "邮件格式不对", autoHidder: true)
            }
        }
        
    }
    
    override func setupBaseViewForDismissKeyboard(){
    
    }
    
    func initView() {
        
        if self.changeView == nil {
            self.registerNotification()

            changeView = UIView.init()
            changeView.backgroundColor = App_Theme_FFFFFF_Color
            self.view.addSubview(changeView)
            
            changeText = UITextField.init()
            changeText.placeholderFont = App_Theme_PinFan_R_14_Font!
            changeText.font = App_Theme_PinFan_R_14_Font
            changeText.delegate = self
            changeText.textColor = App_Theme_06070D_Color
            changeText.becomeFirstResponder()
            changeView.addSubview(changeText)
            
            
            detailLable = YYLabel.init()
            detailLable.textAlignment = .right
            detailLable.font = App_Theme_PinFan_M_14_Font
            detailLable.textColor = App_Theme_999999_Color
            detailLable.text = "0/16"
            changeText.reactive.continuousTextValues.observeValues { (str) in
                if self.type != .desc {
                    self.detailString = str
                }
                self.detailLable.text = "\(str.count)/16"
                if str.count > 0 {
                    self.anmationButton.backgroundColor = App_Theme_FFD512_Color
                    self.anmationButton.isEnabled = true
                    self.anmationButton.setTitleColor(App_Theme_06070D_Color!, for: .normal)
                }else{
                    self.anmationButton.backgroundColor = App_Theme_DCDCDC_Color
                    self.anmationButton.isEnabled = false
                    self.anmationButton.setTitleColor(App_Theme_FFFFFF_Color!, for: .normal)
                }
            }
            changeView.addSubview(detailLable)
            
            infoLable = YYLabel.init()
            infoLable.textAlignment = .left
            infoLable.font = App_Theme_PinFan_R_12_Font
            infoLable.textColor = App_Theme_666666_Color
            self.view.addSubview(infoLable)
            
            
            anmationButton = AnimationButton.init(type: .custom)
            anmationButton.setTitle("确定", for: .normal)
            anmationButton.addAction({ (button) in
                if self.changeInfoViewControllerClouse != nil {
                    self.changeInfoViewControllerClouse(self.type,self.changeText.text!)
                }
                self.dismiss(animated: true, completion: {
                    
                })
            }, for: .touchUpInside)
            anmationButton.isEnabled = false
            anmationButton.backgroundColor = App_Theme_FFD512_Color
            anmationButton.setTitleColor(App_Theme_06070D_Color!, for: .normal)
            anmationButton.isEnabled = false
            anmationButton.titleLabel?.font = App_Theme_PinFan_M_15_Font
            anmationButton.cornerRadius = 23.5
            self.view.addSubview(anmationButton)
            
            changeView.snp.makeConstraints { (make) in
                make.top.equalTo(self.view.snp.top).offset(5)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(47)
            }
            
            changeText.snp.makeConstraints { (make) in
                make.left.equalTo(self.changeView.snp.left).offset(15)
                make.centerY.equalToSuperview()
                make.right.equalTo(self.changeView.snp.right).offset(-15)
            }
            
            detailLable.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.width.equalTo(40)
                make.right.equalTo(self.changeView.snp.right).offset(-15)
            }
            
            infoLable.snp.makeConstraints { (make) in
                make.top.equalTo(self.changeView.snp.bottom).offset(15)
                make.left.equalTo(self.view.snp.left).offset(10)
            }
        }
        
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.releaseNotification()
    }
    
    
    func changeInfoType(text:String,type:ChangeInfoType, placeholder:String){
        self.initView()
        changeText.placeholder = placeholder
        changeText.text = text
        self.type = type
        switch type {
        case .desc:
            detailLable.isHidden = false
            infoLable.isHidden = true
            infoLable.text = ""
            changeText.keyboardType = .default
            changeText.reactive.continuousTextValues.filter({ (str) -> Bool in
                self.changeText.text = self.detailString
                return str.count < 16
            }).observeValues({ (str) in
                self.detailString = str
            })
            
            self.navigationItem.title = "更改简介"
        case .email:
            changeText.keyboardType = .emailAddress
            detailLable.isHidden = true
            infoLable.isHidden = true
            infoLable.text = ""
            self.navigationItem.title = "更改邮箱"
        default:
            detailLable.isHidden = true
            infoLable.isHidden = false
            changeText.keyboardType = .default
            infoLable.text = "好名称可以让朋友更好的记住你"
            self.navigationItem.title = "更改名称"
            break
        }
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
            let keyboardinfo = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey]
            let keyboardheight:CGFloat = ((keyboardinfo as AnyObject).cgRectValue.size.height)
            if #available(iOS 11.0, *) {
                self.anmationButton.frame = CGRect.init(x: 15, y: self.view.bounds.size.height - keyboardheight - NAV_HEIGHT / 2 - 47, width: SCREENWIDTH - 30, height: 47)
            } else {
                self.anmationButton.frame = CGRect.init(x: 15, y: self.view.bounds.size.height - keyboardheight - 47, width: SCREENWIDTH - 30, height: 47)
                // Fallback on earlier versions
            }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChangeInfoViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.dismiss(animated: true) {
            
        }
    }
}
