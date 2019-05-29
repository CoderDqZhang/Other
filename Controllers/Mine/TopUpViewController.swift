//
//  TopUpViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/27.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit



class TopUpViewController: BaseViewController {

    var gloableNavigationBar:GLoabelNavigaitonBar!
    var touUpViewModel = TouUpViewModel.init()
    var accountInfo:AccountInfoModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        let rightButton = AnimationButton.init(type: .custom)
        rightButton.setTitle("明细", for: .normal)
        rightButton.setTitleColor(App_Theme_06070D_Color, for: .normal)
        rightButton.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        if #available(iOS 11.0, *) {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: -NAV_HEIGHT/2, width: SCREENWIDTH, height: 64 + NAV_HEIGHT), title: "", rightButton: rightButton, click: { (type) in
                if type == .backBtn {
                    self.navigationController?.popViewController()
                }else{
                    NavigationPushView(self, toConroller: ConinsSegementViewController())
                }
            })
        } else {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 64), title: "", rightButton: rightButton, click: { (type) in
                if type == .backBtn {
                    self.navigationController?.popViewController()
                }else{
                    NavigationPushView(self, toConroller: CoinsDetailViewController())
                }
            })
            // Fallback on earlier versions
        }
        
        self.view.addSubview(gloableNavigationBar)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: touUpViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [TopUpTableViewCell.self,TopUpToolsTableViewCell.self,TopUpWarningTableViewCell.self], controller: self)
        
    }
    
    override func bindViewModelLogic() {
        self.bindViewModel(viewModel: touUpViewModel, controller: self)
        self.touUpViewModel.accountInfo = self.accountInfo
        self.touUpViewModel.getAccount()
        
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
