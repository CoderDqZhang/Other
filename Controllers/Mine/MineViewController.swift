//
//  MineViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController {

    let mineViewModel = MineViewModel.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: mineViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [MineInfoTableViewCell.self, MineToolsTableViewCell.self, AdTableViewCell.self,TitleLableAndDetailLabelDescRight.self], controller: self)
        self.tableView.backgroundColor = App_Theme_F6F6F6_Color
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
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
