//
//  WithdrawViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/27.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class WithdrawViewController: BaseViewController {

    var accountModel:AccountInfoModel!
    
    var gloableNavigationBar:GLoabelNavigaitonBar!
    var withdrawViewModel = WithdrawViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        
        if #available(iOS 11.0, *) {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: -NAV_HEIGHT/2, width: SCREENWIDTH, height: 64 + NAV_HEIGHT), title: "", rightButton: nil, click: { (type) in
                if type == .backBtn {
                    self.navigationController?.popViewController()
                }
            })
        } else {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 64), title: "", rightButton: nil, click: { (type) in
                if type == .backBtn {
                    self.navigationController?.popViewController()
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
        self.bindViewModel(viewModel: withdrawViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [TopUpTableViewCell.self, TopUpWarningTableViewCell.self,GloabelConfirmTableViewCell.self,ConfirmProtocolTableViewCell.self,WithDrawTypeTableViewCell.self,WithDrawMuchTableViewCell.self], controller: self)
    }
    
    override func bindViewModelLogic() {
        self.bindViewModel(viewModel: withdrawViewModel, controller: self)
        self.withdrawViewModel.getAccount()
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
