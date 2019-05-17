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

class ChangeInfoViewController: BaseViewController {

    var changeText:UITextField!
    var detailLable:YYLabel!
    var infoLable:YYLabel!
    
    var changeView:UIView!
    
    var type:ChangeInfoType!
    var detailString:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = App_Theme_F6F6F6_Color
        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(self.leftBarItemClick(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "保存", style: .plain, target: self, action: #selector(self.rightBarItemClick(_:)))
    }
    
    @objc func leftBarItemClick(_ sender:UIBarButtonItem) {
        self.dismiss(animated: true) {
            
        }
    }
    
    @objc func rightBarItemClick(_ sender:UIBarButtonItem) {
        
        if detailString.count == 0 {
            _ = Tools.shareInstance.showMessage(KWindow, msg: "请输入字符", autoHidder: true)
        }
        if self.type == .email {
            let ret = detailString.isValidEmail
            if !ret {
                _ = Tools.shareInstance.showMessage(KWindow, msg: "邮件格式不对", autoHidder: true)
            }
        }
        
    }
    
    override func setUpView() {
        changeView = UIView.init()
        changeView.backgroundColor = App_Theme_FFFFFF_Color
        self.view.addSubview(changeView)
        
        changeText = UITextField.init()
        changeText.placeholderFont = App_Theme_PinFan_R_14_Font!
        changeText.font = App_Theme_PinFan_R_14_Font
        changeText.textColor = App_Theme_06070D_Color
        
        changeView.addSubview(changeText)
        
        
        detailLable = YYLabel.init()
        detailLable.textAlignment = .right
        detailLable.font = App_Theme_PinFan_M_14_Font
        detailLable.textColor = App_Theme_999999_Color
        detailLable.text = "0/16"
        detailLable.backgroundColor = .red
        changeText.reactive.continuousTextValues.observeValues { (str) in
            self.detailString = str
            self.detailLable.text = "\(str.count)/16"
        }
        changeView.addSubview(detailLable)
        
        infoLable = YYLabel.init()
        infoLable.textAlignment = .left
        infoLable.font = App_Theme_PinFan_R_12_Font
        infoLable.textColor = App_Theme_666666_Color
        self.view.addSubview(infoLable)
        
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

    
    func changeInfoType(text:String,type:ChangeInfoType, placeholder:String){
        self.setUpView()
        changeText.placeholder = placeholder
        changeText.text = text
        switch type {
        case .desc:
            detailLable.isHidden = false
            infoLable.isHidden = true
            infoLable.text = ""
            changeText.reactive.continuousTextValues.filter({ (str) -> Bool in
                return str.count < 16
            }).observeValues({ (str) in
                self.changeText.text = str
            })
            
            self.navigationItem.title = "更改简介"
        case .email:
            detailLable.isHidden = true
            infoLable.isHidden = true
            infoLable.text = ""
            self.navigationItem.title = "更改邮箱"
        case .name:
            detailLable.isHidden = true
            infoLable.isHidden = false
            infoLable.text = "好名称可以让朋友更好的记住你"

            self.navigationItem.title = "更改名称"
        default:
            break
        }
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
