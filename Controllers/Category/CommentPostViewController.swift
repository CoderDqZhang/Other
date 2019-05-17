//
//  CommentPostViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/13.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import TZImagePickerController

class CommentPostViewController: BaseViewController {

    let commentPostViewModel =  CommentPostViewModel.init()
    var photoPickerVC:TZImagePickerController!
    
    var isSelectOriginalPhoto:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AuthorityManager.setUpAuthorityManager(controller: self)
        // Do any additional setup after loading the view.
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: commentPostViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [PostCommentTextTableViewCell.self,PostCommentImagesTableViewCell.self], controller: self)
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(self.leftButtonClick(_:)))
        self.navigationItem.title = "发表评论"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "发表", style: .plain, target: self, action: #selector(self.rightButtonClick(_:)))
    }

    
    @objc func leftButtonClick(_ sender:UIBarButtonItem) {
        self.dismiss(animated: true) {
            
        }
    }
    
    @objc func rightButtonClick(_ sender:UIBarButtonItem) {
        
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
            photoPickerVC = TZImagePickerController.init(maxImagesCount: 3, columnNumber: 1, delegate: self, pushPhotoPickerVc: true)
            photoPickerVC?.allowTakeVideo = false
            photoPickerVC?.autoDismiss = true
            photoPickerVC!.showSelectedIndex = true
            photoPickerVC?.showPhotoCannotSelectLayer = true
            photoPickerVC!.sortAscendingByModificationDate = true
            photoPickerVC.selectedAssets = self.commentPostViewModel.selectAssets
            NavigaiontPresentView(self, toController: photoPickerVC)
        }else{
            print("模拟器中无法打开照相机,请在真机中使用")
        }
    }
}

extension CommentPostViewController : TZImagePickerControllerDelegate {
    func tz_imagePickerControllerDidCancel(_ picker: TZImagePickerController!) {
        self.dismiss(animated: true) {
            
        }
    }
    
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool, infos: [[AnyHashable : Any]]!) {
        self.commentPostViewModel.selectPhotos = photos
        self.commentPostViewModel.selectAssets = NSMutableArray.init(array: assets)
        self.commentPostViewModel.isSelectOriginalPhoto = isSelectOriginalPhoto
        self.commentPostViewModel.reloadTableView()
    }
}

