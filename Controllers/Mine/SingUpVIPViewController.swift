//
//  SingUpVIPViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class SingUpVIPViewController: BaseViewController {

    let singVipViewModel = SigupVIPViewModel.init()
    var backgroundView:UIView!
    var aShape:UIView!
    var type:CartType!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.setNavigationItemBack()
        self.navigationItem.title = "专家号申请"
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: singVipViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [GloabelTextFieldAndTitleTableViewCell.self,GloabelConfirmTableViewCell.self,TakeVCartTableViewCell.self,UploadCartTableViewCell.self,ConfirmProtocolTableViewCell.self], controller: self)
        self.view.backgroundColor = App_Theme_F6F6F6_Color
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    func uploadIDCart(_ type:CartType){
        self.type = type
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.camera;
            imagePicker.isNavigationBarHidden = true
            //Create camera overlay
            aShape = UIView.init(frame: CGRect.init(x: (SCREENWIDTH - 300) / 2, y: (SCREENHEIGHT - 400) / 2, width: 300, height: 400))
            // 不能直接加在最底层viewController.view上面，会黑掉 后面没东西显示了
            backgroundView = UIView(frame: CGRect.init(x: 0, y: -20, width: SCREENWIDTH, height: SCREENHEIGHT - 70))
            backgroundView.backgroundColor =  UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
            view.addSubview(backgroundView)
            let maskLayer = CAShapeLayer()
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd //  奇偶层显示规则
            let basicPath = UIBezierPath(rect: view.frame) // 底层
//            let maskPath = UIBezierPath(ovalIn: C
            let maskPath = UIBezierPath(rect: aShape.frame) //自定义的遮罩图形
            basicPath.append(maskPath) // 重叠
            maskLayer.path = basicPath.cgPath
            backgroundView.layer.mask = maskLayer
            imagePicker.modalPresentationStyle = .currentContext
            imagePicker.cameraOverlayView = backgroundView
        
            NavigaiontPresentView(self, toController: imagePicker)
        }else{
            print("模拟器中无法打开照相机,请在真机中使用")
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

extension SingUpVIPViewController : UINavigationControllerDelegate {
    
}

extension SingUpVIPViewController : UIImagePickerControllerDelegate {
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        if self.type == .font {
            self.singVipViewModel.fontImage = selectedImage
            self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
        }else if self.type == .back {
            self.singVipViewModel.backImage = selectedImage
            self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
        }else if self.type == .hand {
            self.singVipViewModel.takeHandImage = selectedImage
            self.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .automatic)
        }
        
        self.dismiss(animated: true) {
            
        }
    }
}
