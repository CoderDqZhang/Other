//
//  PostViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import TZImagePickerController

class PostViewController: BaseViewController {

    let postViewModel = PostViewModel.init()
    
    var photoPickerVC:TZImagePickerController!
    
    var isSelectOriginalPhoto:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setUpView() {
        self.bindViewModel(viewModel: postViewModel, controller: self)
        self.setUpTableView(style: .grouped, cells: [GloabelTextFieldTableViewCell.self,GloabelTextFieldAndTitleTableViewCell.self,PostCommentTextTableViewCell.self,PostCommentImagesTableViewCell.self], controller: self)
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(self.leftButtonClick(_:)))
        self.navigationItem.title = "发表帖子"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "发表", style: .plain, target: self, action: #selector(self.rightButtonClick(_:)))
    }
    
    
    @objc func leftButtonClick(_ sender:UIBarButtonItem) {
        UIAlertController.showAlertControl(self, style: .alert, title: "是否保存此次编辑?", message: nil, cancel: "取消", doneTitle: "确定", cancelAction: {
            self.dismiss(animated: true) {
                
            }
        }, doneAction: {
            self.dismiss(animated: true) {
                CacheManager.getSharedInstance().savePostModel(postModel: self.postViewModel.postModel)
            }
        })
    }
    
    @objc func rightButtonClick(_ sender:UIBarButtonItem) {
        self.postViewModel.postTirbeNet()
    }
    
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
    
    override func bindViewModelLogic() {
        if self.postViewModel.postModel.images != nil {
            for asset in self.postViewModel.postModel.images  {
                let model = PHAsset.fetchAssets(withLocalIdentifiers: [asset as! String], options: nil)
                let image = model.firstObject
                let options = PHImageRequestOptions.init()
                PHImageManager.default().requestImage(for: image!, targetSize: CGSize.init(width: image!.pixelWidth, height: image!.pixelHeight), contentMode: PHImageContentMode.aspectFill, options: options) { (img, str) in
                    self.postViewModel.selectPhotos.append(img!)
                }
                
            }
            self.postViewModel.reloadTableView()
        }
    }
    
    func setUpImagePicker(sourceType:UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            photoPickerVC = TZImagePickerController.init(maxImagesCount: 3, columnNumber: 1, delegate: self, pushPhotoPickerVc: true)
            photoPickerVC?.allowTakeVideo = false
            photoPickerVC?.autoDismiss = true
            photoPickerVC!.showSelectedIndex = true
            photoPickerVC?.showPhotoCannotSelectLayer = true
            photoPickerVC!.sortAscendingByModificationDate = true
            if self.postViewModel.postModel.images != nil {
                let images = NSMutableArray.init()
                for asset in self.postViewModel.postModel.images  {
                    let options = PHFetchOptions.init()
                    let result = PHAsset.fetchAssets(withLocalIdentifiers: [asset as! String], options: options)
                    let image = result.firstObject
                    if image != nil {
                        let img:PHAsset = image!
                        images.add(img)
                    }
                }
                photoPickerVC.selectedAssets = images
            }
            NavigaiontPresentView(self, toController: photoPickerVC)
        }else{
            print("模拟器中无法打开照相机,请在真机中使用")
        }
    }
}

extension PostViewController : TZImagePickerControllerDelegate {
    func tz_imagePickerControllerDidCancel(_ picker: TZImagePickerController!) {
        self.dismiss(animated: true) {
            
        }
    }
    
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool, infos: [[AnyHashable : Any]]!) {
        self.postViewModel.selectPhotos = photos
        self.postViewModel.selectAssets = NSMutableArray.init(array: assets)
        self.postViewModel.isSelectOriginalPhoto = isSelectOriginalPhoto
        if self.postViewModel.postModel.images == nil {
            self.postViewModel.postModel.images = NSMutableArray.init()
        }
        for asset in assets  {
            self.postViewModel.postModel.images.removeAllObjects()
            self.postViewModel.postModel.images.add((asset as! PHAsset).localIdentifier)
        }
        self.postViewModel.reloadTableView()
    }
}

