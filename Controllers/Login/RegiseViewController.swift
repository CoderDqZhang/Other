//
//  RegiseViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/22.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
class RegiseViewController: BaseViewController {

    var gloableNavigationBar:GLoabelNavigaitonBar!
    var loginViewModel = LoginViewModel.init()
    var regisViewCenteView:RegisterView!
    var thirdLogin:GloableThirdLogin!
    var cofirmProtocolView:CofirmProtocolView!
    var resgisterViewModel = RegisterViewModel.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
       
        if #available(iOS 11.0, *) {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: -NAV_HEIGHT/2, width: SCREENWIDTH, height: 64 + NAV_HEIGHT), title: "注册", rightButton: nil, click: { (type) in
                if type == .backBtn{
                    self.navigationController?.popViewController()
                }
            })
        } else {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 64), title: "注册", rightButton: nil, click: { (type) in
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
        self.resgisterViewModel.controller = self
        regisViewCenteView = RegisterView.init(frame:  CGRect.init(x: 23, y: (SCREENHEIGHT - 355) / 2 - 37.5, width: SCREENWIDTH - 46, height: 355 + 37.5))
        regisViewCenteView.registerViewButtonClouse = { type in
            switch type {
            case .login:
                self.navigationController?.popViewController()
            case .regise:
                self.resgisterViewModel.resgisterNetWork(phone: self.regisViewCenteView.phoneTextField.text!, password: self.regisViewCenteView.passwordTextField.text!, code: self.regisViewCenteView.codeTextField.text!)
            default:
                self.resgisterViewModel.sendCodeNetWork(phone: self.regisViewCenteView.phoneTextField.text!)
                break;
            }
        }
        self.view.addSubview(regisViewCenteView)
        
        
        thirdLogin = GloableThirdLogin.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 172, width: SCREENWIDTH, height: 91))
        thirdLogin.gloableThirdLoginClouse = { type in
            //消除定时器
            self.regisViewCenteView.relaseTimer()
            
        }
        
        self.view.addSubview(thirdLogin)
        
        cofirmProtocolView = CofirmProtocolView.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 49 - 30, width: SCREENWIDTH, height: 30))
        cofirmProtocolView.checkBox.addAction({ (button) in
            if button?.tag == 100 {
                self.regisViewCenteView.isCheckBool = true
                self.cofirmProtocolView.checkBox.tag = 101
                self.cofirmProtocolView.checkBox.setBackgroundImage(UIImage.init(named: "check_select"), for: .normal)
            }else{
                self.regisViewCenteView.isCheckBool = false
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
