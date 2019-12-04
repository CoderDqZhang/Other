//
//  LoginViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/21.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import AuthenticationServices

typealias LoginDoneClouse = () ->Void

class LoginViewController: BaseViewController {

    var gloableNavigationBar:GLoabelNavigaitonBar!
    var loginViewModel = LoginViewModel.init()
    var loginCenteView:LoginView!
    var thirdLogin:GloableThirdLogin!
    var cofirmProtocolView:CofirmProtocolView!
    
    var loginDoneClouse:LoginDoneClouse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        
        if #available(iOS 11.0, *) {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: -NAV_HEIGHT/2, width: SCREENWIDTH, height: 64 + NAV_HEIGHT), title: "登录", rightButton: nil, click: { (type) in
                if type == .backBtn{
                    self.navigationController?.popViewController()
                }
            })
        } else {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 64), title: "登录", rightButton: nil, click: { (type) in
                if type == .backBtn{
                    self.navigationController?.popViewController()
                }
            })
            // Fallback on earlier versions
        }
        gloableNavigationBar.titleLabel.textColor = App_Theme_FFFFFF_Color
        gloableNavigationBar.titleLabel.font = App_Theme_PinFan_M_24_Font
        self.view.addSubview(gloableNavigationBar)
    }
    
    override func setUpView() {
        self.setUpBackImage()
        self.loginViewModel.controller = self
        if #available(iOS 13.0, *) {
            loginCenteView = LoginView.init(frame:  CGRect.init(x: 23, y: (SCREENHEIGHT - 305) / 2 - 37.5 - 47, width: SCREENWIDTH - 46, height: 305 + 37.5 + 47), type: .password)
        } else {
            loginCenteView = LoginView.init(frame:  CGRect.init(x: 23, y: (SCREENHEIGHT - 305) / 2 - 37.5, width: SCREENWIDTH - 46, height: 305 + 37.5), type: .password)
            // Fallback on earlier versions
        }
        loginCenteView.loginViewButtonClouse = { type in
            switch type {
            case .forgetPas:
                NavigationPushView(self, toConroller: FindPasViewController())
            case .regise:
                NavigationPushView(self, toConroller: RegiseViewController())
            case .senderCode:
                self.loginViewModel.sendCodeNetWork(phone: self.loginCenteView.phoneTextField.text!)
            case .loginApp:
                self.handleAuthorizationAppleIDButtonPress()
            default:
                self.loginViewModel.loginPasswordNetWork(phone: self.loginCenteView.phoneTextField.text!, password: self.loginCenteView.passwordTextField.text!)
            }
        }
        self.view.addSubview(loginCenteView)
        
        
        thirdLogin = GloableThirdLogin.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 172 + (IPHONE5 ? 30 : 0), width: SCREENWIDTH, height: 91))
        thirdLogin.gloableThirdLoginClouse = { type in
            //消除定时器
            self.loginCenteView.relaseTimer()
            switch type {
            case .qq:
                
                UMengManager.getSharedInstance().loginWithPlatform(type: UMSocialPlatformType.QQ, controller: self, loginType: type)
            case .weibo:
                UMengManager.getSharedInstance().loginWithPlatform(type: UMSocialPlatformType.sina, controller: self, loginType: type)
            default:
                UMengManager.getSharedInstance().loginWithPlatform(type: UMSocialPlatformType.wechatSession, controller: self, loginType: type)
            }
            UMengManager.getSharedInstance().umengManagerUserInfoResponse = { response,type in
                let model = ThirdLoginModel()
                switch type {
                case .qq:
                    model.openId = response.openid
                    model.nickname = ((response.originalResponse as! NSDictionary).object(forKey: "nickname") as! String)
                    model.img = ((response.originalResponse as! NSDictionary).object(forKey: "figureurl_qq") as! String)
                    model.type = "1"
                    model.descriptions = ((response.originalResponse as! NSDictionary).object(forKey: "nickname") as! String)
                    break
                case .weibo:
                    model.openId = response.openid != nil ? response.openid : response.uid
                    model.nickname = ((response.originalResponse as! NSDictionary).object(forKey: "name") as! String)
                    model.img = ((response.originalResponse as! NSDictionary).object(forKey: "avatar_large") as! String)
                    model.type = "2"
                    model.descriptions = ((response.originalResponse as! NSDictionary).object(forKey: "description") as! String)
                default:
                    model.openId = response.openid
                    model.nickname = ((response.originalResponse as! NSDictionary).object(forKey: "nickname") as! String)
                    model.img = ((response.originalResponse as! NSDictionary).object(forKey: "headimgurl") as! String)
                    model.type = "0"
                    model.descriptions = ""
                }
                self.loginViewModel.loginThirdPlathom(model: model)
            }
        }
        
        self.view.addSubview(thirdLogin)
        
        cofirmProtocolView = CofirmProtocolView.init(frame: CGRect.init(x: 0, y: thirdLogin.frame.maxY, width: SCREENWIDTH, height: 30))
        cofirmProtocolView.checkBox.addAction({ (button) in
            if button?.tag == 100 {
                self.loginCenteView.isCheckBoolProperty.value = true
                self.loginCenteView.isCheckBool = true
                self.cofirmProtocolView.checkBox.tag = 101
                self.cofirmProtocolView.checkBox.setBackgroundImage(UIImage.init(named: "check_select"), for: .normal)
            }else{
                self.loginCenteView.isCheckBoolProperty.value = false
                self.loginCenteView.isCheckBool = false
                self.cofirmProtocolView.checkBox.tag = 100
                self.cofirmProtocolView.checkBox.setBackgroundImage(UIImage.init(named: "check_normal"), for: .normal)
            }
        }, for: UIControl.Event.touchUpInside)
        cofirmProtocolView.cofirmProtocolViewClouse = {
            let controllerVC = ProtocolViewViewController()
            controllerVC.loadRequest(url: RegisterLoginUrl)
            NavigationPushView(self, toConroller: controllerVC)
        }
        self.view.addSubview(cofirmProtocolView)
    }
    
    func setUpBackImage(){
        let backMask = UIImageView.init()
        backMask.image = UIImage.init(color: UIColor.init(hexString: "000000", transparency: 0.5)!, size: CGSize.init(width: SCREENWIDTH, height: SCREENHEIGHT))
        let backImage = UIImageView.init()
        backImage.image = UIImage.init(named: "back")
        self.view.addSubview(backImage)
        self.view.addSubview(backMask)

        backImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        backMask.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        performExistingAccountSetupFlows()
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /// Prompts the user if an existing iCloud Keychain credential or Apple ID credential is found.
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        if #available(iOS 13.0, *) {
            let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                            ASAuthorizationPasswordProvider().createRequest()]
            let authorizationController = ASAuthorizationController(authorizationRequests: requests)
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
        }
        
        // Create an authorization controller with the given requests.
        
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
        }
        
    }

}

@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerDelegate {
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let model = ThirdLoginModel()
            model.openId = appleIDCredential.user
            model.nickname = "苹果登录"
            model.img = "/user/default.png"
            model.type = "3"
            model.descriptions = ""
            self.loginViewModel.loginThirdPlathom(model: model)
            // Create an account in your system.
            // For the purpose of this demo app, store the userIdentifier in the keychain.
//            do {
//                try KeychainItem(service: "com.example.apple-samplecode.touqiu", account: "userIdentifier").saveItem(userIdentifier)
//            } catch {
//                print("Unable to save userIdentifier to keychain.")
//            }
//
//            // For the purpose of this demo app, show the Apple ID credential information in the ResultViewController.
//            if let viewController = self.presentingViewController as? ResultViewController {
//                DispatchQueue.main.async {
//                    viewController.userIdentifierLabel.text = userIdentifier
//                    if let givenName = fullName?.givenName {
//                        viewController.givenNameLabel.text = givenName
//                    }
//                    if let familyName = fullName?.familyName {
//                        viewController.familyNameLabel.text = familyName
//                    }
//                    if let email = email {
//                        viewController.emailLabel.text = email
//                    }
//                    self.dismiss(animated: true, completion: nil)
//                }
//            }
//        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
//            // Sign in using an existing iCloud Keychain credential.
//            let username = passwordCredential.user
//            let password = passwordCredential.password
//
//            // For the purpose of this demo app, show the password credential as an alert.
//            DispatchQueue.main.async {
//                let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
//                let alertController = UIAlertController(title: "Keychain Credential Received",
//                                                        message: message,
//                                                        preferredStyle: .alert)
//                alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
//                self.present(alertController, animated: true, completion: nil)
//            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

