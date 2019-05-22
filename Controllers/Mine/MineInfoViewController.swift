//
//  MineInfoViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/17.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class MineInfoViewController: BaseViewController {

    let mineInfoViewModel = MineInfoViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.setNavigationItemBack()
        self.navigationItem.title = "基本资料"
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: mineInfoViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [TitleLableAndDetailLabelDescRight.self], controller: self)
        self.view.backgroundColor = App_Theme_F6F6F6_Color
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setUpAlerViewController(){
        let alerController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        alerController.addAction(title: "相册", style: .default, isEnabled: true, handler: { (ret) in
            self.setUpImagePicker(sourceType: .photoLibrary)
        })
        alerController.addAction(title: "拍照", style: .default, isEnabled: true, handler: { (ret) in
            self.setUpImagePicker(sourceType: .camera)
        })
        alerController.addAction(title: "取消", style: .cancel, isEnabled: true, handler: { (ret) in
            
        })
        NavigaiontPresentView(self, toController: alerController)
    }
    
    func setUpImagePicker(sourceType:UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let photoPickerVC = UIImagePickerController.init()
            photoPickerVC.sourceType = sourceType
            photoPickerVC.delegate = self
            NavigaiontPresentView(self, toController: photoPickerVC)
        }else{
            print("模拟器中无法打开照相机,请在真机中使用")
        }
    }
}

extension MineInfoViewController : UINavigationControllerDelegate {
    
}
extension MineInfoViewController : UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard var selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        print(selectedImage)
        picker.dismiss(animated: true) {
            
        }
    }
}
