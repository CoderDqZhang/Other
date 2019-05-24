//
//  CategoryChoosSearchViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/24.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class CategoryChoosSearchViewController: BaseViewController {

    var serarchViewModel = CategorySearchViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: serarchViewModel, controller: self)
        self.setUpTableView(style: .plain, cells: [TagerUserTableViewCell.self], controller: self)
    }
    
    
    func refreshResultData(){
        serarchViewModel.reslutArray = self.viewModel?.resultData
        self.tableView.reloadData()
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
