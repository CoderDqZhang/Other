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

class LoginViewController: BaseViewController {

    var gloableNavigationBar:GLoabelNavigaitonBar!
    var loginViewModel = LoginViewModel.init()
    var loginCenteView:LoginView!
    var thirdLogin:GloableThirdLogin!
    var cofirmProtocolView:CofirmProtocolView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        let followButton = AnimationButton.init(type: .custom)
        followButton.frame = CGRect.init(x: SCREENWIDTH - 100, y: 0, width: 61, height: 27)
        if #available(iOS 11.0, *) {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: -NAV_HEIGHT/2, width: SCREENWIDTH, height: 64 + NAV_HEIGHT), title: "登录", rightButton: followButton, click: { (type) in
                if type == .backBtn{
                    self.navigationController?.popViewController()
                }
            })
        } else {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 64), title: "登录", rightButton: followButton, click: { (type) in
                if type == .backBtn{
                    self.navigationController?.popViewController()
                }
            })
            // Fallback on earlier versions
        }
        gloableNavigationBar.titleLabel.textColor = App_Theme_FFFFFF_Color
        gloableNavigationBar.titleLabel.font = App_Theme_PinFan_M_24_Font
        gloableNavigationBar.changeToolsButtonType(followed: false)
        self.view.addSubview(gloableNavigationBar)
    }
    
    override func setUpView() {
        self.setUpBackImage()
        
        loginCenteView = LoginView.init(frame: CGRect.init(x: 23, y: (SCREENHEIGHT - 305) / 2 - 37.5, width: SCREENWIDTH - 46, height: 305 + 37.5))
        self.view.addSubview(loginCenteView)
        
        
        thirdLogin = GloableThirdLogin.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 172, width: SCREENWIDTH, height: 91))
        self.view.addSubview(thirdLogin)
        
        cofirmProtocolView = CofirmProtocolView.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 49 - 30, width: SCREENWIDTH, height: 30))
        cofirmProtocolView.checkBox.addAction({ (button) in
            if button?.tag == 100 {
                self.loginCenteView.isCheckBool = true
                self.cofirmProtocolView.checkBox.tag = 101
                self.cofirmProtocolView.checkBox.setBackgroundImage(UIImage.init(named: "check_select"), for: .normal)
            }else{
                self.loginCenteView.isCheckBool = false
                self.cofirmProtocolView.checkBox.tag = 100
                self.cofirmProtocolView.checkBox.setBackgroundImage(UIImage.init(named: "check_normal"), for: .normal)
            }
        }, for: UIControl.Event.touchUpInside)
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

}
