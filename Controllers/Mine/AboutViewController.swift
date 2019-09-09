//
//  AboutViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {

    let aboutViewModel = AboutViewModel.init()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "关于豹典"
        self.setNavigationItemBack()
    }

    override func setUpView() {
        self.bindViewModel(viewModel: aboutViewModel, controller: self)
        self.setUpTableView(style: .plain, cells: [AboutTableViewCell.self,AboutInfoTableViewCell.self,TitleLableAndDetailLabelDescRight.self], controller: self)
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
