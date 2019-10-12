//
//  InviteUserViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class InviteUserViewController: BaseViewController {

    var gloableNavigationBar:GLoabelNavigaitonBar!
    let inverUserViewModel = InveterViewModel.init()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.setNavigationItemBack()
        self.navigationItem.title = "邀请好友"
//        let followButton = AnimationButton.init(type: .custom)
//        followButton.frame = CGRect.init(x: SCREENWIDTH - 100, y: 0, width: 61, height: 27)
//        followButton.cornerRadius = 14
//        followButton.titleLabel?.font = App_Theme_PinFan_R_14_Font
//        followButton.setTitle("邀请规则", for: .normal)
//        followButton.layer.masksToBounds = false
//        followButton.isHidden = false
//        if #available(iOS 11.0, *) {
//            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: -NAV_HEIGHT/2, width: SCREENWIDTH, height: 64 + NAV_HEIGHT), title: "", rightButton: followButton, click: { (type) in
//                if type == .backBtn{
//                    self.navigationController?.popViewController()
//                }
//            })
//        } else {
//            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 64), title: "", rightButton: followButton, click: { (type) in
//                if type == .backBtn{
//                    self.navigationController?.popViewController()
//                }
//            })
//            // Fallback on earlier versions
//        }
//
//        gloableNavigationBar.rightButtonClouse = { status in
//            NavigationPushView(self, toConroller: InviteRuleViewController())
//        }
//        self.view.addSubview(gloableNavigationBar)
    }
    

    override func setUpView() {
        self.bindViewModel(viewModel: inverUserViewModel, controller: self)
        let backImage = UIImageView.init()
        backImage.image = UIImage.init(named: "inveterate")
        self.view.addSubview(backImage)
        backImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        
        let inveterView = UIView.init()
        inveterView.backgroundColor = .clear
        inveterView.tag = 1000
        self.view.addSubview(inveterView)
        inveterView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.height.equalTo(259 + TABBAR_HEIGHT)
            } else {
                // Fallback on earlier versions
                make.height.equalTo(259)
            }
        }
        
        
        
        let backView = UIView.init()
        backView.backgroundColor = App_Theme_AC0013_Color
        inveterView.addSubview(backView)
        backView.tag = 2000
        backView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(inveterView.snp.top).offset(29)
        }
        
        let sub1 = self.createSubView(title: "邀请总收益", desc: "66M币", descTag: 100)
        let sub2 = self.createSubView(title: "邀请总人数", desc: "66M币", descTag: 200)
        let sub3 = self.createSubView(title: "A级邀请", desc: "66M币", descTag: 300)
        let sub4 = self.createSubView(title: "B级邀请", desc: "66M币", descTag: 400)
        let sub5 = self.createSubView(title: "C级邀请", desc: "66M币", descTag: 500)
        
        let lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: 192, height: 2))
        backView.addSubview(sub1)
        backView.addSubview(sub2)
        backView.addSubview(sub3)
        backView.addSubview(sub4)
        backView.addSubview(sub5)
        backView.addSubview(lineLabel)
        
        sub1.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(backView.snp.top).offset(47)
            make.height.equalTo(20)
        }
        
        sub2.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(sub1.snp.bottom).offset(9)
            make.height.equalTo(20)
        }
        
        sub3.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(sub2.snp.bottom).offset(20)
            make.height.equalTo(20)
        }
        
        sub4.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(sub3.snp.bottom).offset(9)
            make.height.equalTo(20)
        }
        
        sub5.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(sub4.snp.bottom).offset(9)
            make.height.equalTo(20)
        }
        
        lineLabel.snp.makeConstraints { (make) in
            make.top.equalTo(sub2.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(2)
            make.width.equalTo(199)
        }
        
        let inveterBtn = AnimationButton.init(type: .custom)
        inveterBtn.setTitle("邀请好友", for: .normal)
        inveterBtn.setTitleColor(App_Theme_E22007_Color, for: .normal)
        inveterBtn.titleLabel?.font = App_Theme_PinFan_M_18_Font
        inveterBtn.setBackgroundImage(UIImage.init(named: "invete_btn"), for: .normal)
        inveterBtn.addAction({ (button) in
            let controllerVC = InviteWebViewController()
            controllerVC.loadRequest(url: InviteUrl)
            NavigationPushView(self, toConroller: controllerVC)
        }, for: UIControl.Event.touchUpInside)
        inveterView.addSubview(inveterBtn)
        inveterView.bringSubviewToFront(inveterBtn)
        
        inveterBtn.snp.makeConstraints { (make) in
            
            make.size.equalTo(CGSize.init(width: 279, height: 57))
            make.centerX.equalToSuperview()
            make.top.equalTo(inveterView.snp.top).offset(0)
        }
        
    }
    
    func createSubView(title:String, desc:String, descTag:Int) -> UIView{
        let subView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 16))
        
        let titleLabel = YYLabel.init()
        titleLabel.textAlignment = .right
        titleLabel.font = App_Theme_PinFan_M_15_Font
        titleLabel.textColor = App_Theme_FFFFFF_Color
        titleLabel.text = title
        subView.addSubview(titleLabel)
        
        let descLabel = YYLabel.init()
        descLabel.tag = descTag
        descLabel.textAlignment = .left
        descLabel.font = App_Theme_PinFan_M_15_Font
        descLabel.textColor = App_Theme_FFFFFF_Color
        descLabel.text = desc
        subView.addSubview(descLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.right.equalTo(subView.snp.centerX).offset(-25)
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(subView.snp.centerX).offset(25)
            make.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        return subView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

}
