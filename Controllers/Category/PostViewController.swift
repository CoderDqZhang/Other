//
//  PostViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/8.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import TZImagePickerController

let maxImagesCount = 3

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
                CacheManager.getSharedInstance().removePostModel()
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
    
    
    func bindCategoryModel(tribe:CategoryModel){
        self.postViewModel.postModel.tribe = tribe
    }
    
    func setUpAlerViewController(){
        let alerController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        alerController.addAction(title: "相册", style: .default, isEnabled: true, handler: { (ret) in
            self.setUpImagePicker(sourceType: .photoLibrary)
        })
        
        alerController.addAction(title: "拍照", style: .default, isEnabled: true, handler: { (ret) in
            self.setUpUIImagePicker(sourceType: .camera)
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
                    if self.postViewModel.selectPhotos.count < self.postViewModel.postModel.images.count {
                        self.postViewModel.selectPhotos.add(img!)
                    }
                }
                self.postViewModel.selectAssets.add(model.firstObject!)
                
            }
            self.postViewModel.reloadTableView()
        }
    }
    
    func setUpUIImagePicker(sourceType:UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let photoPickerVC = UIImagePickerController.init()
            photoPickerVC.sourceType = sourceType
            photoPickerVC.delegate = self
            NavigaiontPresentView(self, toController: photoPickerVC)
        }else{
            print("模拟器中无法打开照相机,请在真机中使用")
        }
    }
    
    func setUpImagePicker(sourceType:UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            photoPickerVC = TZImagePickerController.init(maxImagesCount: maxImagesCount, columnNumber: 4, delegate: self, pushPhotoPickerVc: true)
            photoPickerVC.notScaleImage = true
            photoPickerVC?.autoDismiss = true
            photoPickerVC!.showSelectedIndex = true
            photoPickerVC?.showPhotoCannotSelectLayer = true
            photoPickerVC!.sortAscendingByModificationDate = true
            photoPickerVC.selectedAssets = self.postViewModel.selectAssets
            NavigaiontPresentView(self, toController: photoPickerVC)
        }else{
            print("模拟器中无法打开照相机,请在真机中使用")
        }
    }
    
    func setUpPrewImagePickerBrowser(index:Int){
        let photoPickerVC = TZImagePickerController.init(selectedAssets: self.postViewModel.selectAssets, selectedPhotos: self.postViewModel.selectPhotos, index: index)
        photoPickerVC?.maxImagesCount = maxImagesCount
        photoPickerVC?.autoDismiss = true
        photoPickerVC!.showSelectedIndex = true
        photoPickerVC?.showPhotoCannotSelectLayer = true
        photoPickerVC!.sortAscendingByModificationDate = true
        photoPickerVC?.didFinishPickingPhotosHandle = { photos, assets, isSelectOriginalPhoto in
            self.postViewModel.selectPhotos.removeAllObjects()
            self.postViewModel.selectAssets.removeAllObjects()
            self.postViewModel.selectPhotos = NSMutableArray.init(array: photos!)
            self.postViewModel.selectAssets = NSMutableArray.init(array: assets!)
            self.postViewModel.isSelectOriginalPhoto = isSelectOriginalPhoto
            if self.postViewModel.postModel.images == nil {
                self.postViewModel.postModel.images = NSMutableArray.init()
            }
            self.postViewModel.postModel.images.removeAllObjects()
            for asset in assets!  {
                self.postViewModel.postModel.images.add((asset as! PHAsset).localIdentifier)
            }
            self.postViewModel.reloadTableView()
        }
        NavigaiontPresentView(self, toController: photoPickerVC!)
    }
}

extension PostViewController : TZImagePickerControllerDelegate {
    func tz_imagePickerControllerDidCancel(_ picker: TZImagePickerController!) {

    }
    
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool, infos: [[AnyHashable : Any]]!) {
        self.postViewModel.selectPhotos.removeAllObjects()
        self.postViewModel.selectAssets.removeAllObjects()
        self.postViewModel.selectPhotos.addObjects(from: photos)
        self.postViewModel.selectAssets.addObjects(from: assets)
        self.postViewModel.isSelectOriginalPhoto = isSelectOriginalPhoto
        if self.postViewModel.postModel.images == nil {
            self.postViewModel.postModel.images = NSMutableArray.init()
        }
        self.postViewModel.postModel.images.removeAllObjects()
        for asset in self.postViewModel.selectAssets  {
            self.postViewModel.postModel.images.add((asset as! PHAsset).localIdentifier)
        }
        self.postViewModel.reloadTableView()
    }
}


extension PostViewController : UINavigationControllerDelegate {
    
}
extension PostViewController : UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true) {
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            
        }
        let image = (info as NSDictionary).object(forKey: UIImagePickerController.InfoKey.originalImage)
        let type = (info as NSDictionary).object(forKey: UIImagePickerController.InfoKey.mediaType)
        let tzImagePickerVC = TZImagePickerController.init(maxImagesCount: 1, delegate: self)
        tzImagePickerVC?.showProgressHUD()
        if type as! String == "public.image" {
            (TZImageManager.default())!.savePhoto(with: image as? UIImage, completion: { (assert, error) in
                if error != nil {
                    print("图片保存失败")
                }else{
                    self.postViewModel.selectPhotos.add(image!)
                    self.postViewModel.selectAssets.add(assert!)
                    if self.postViewModel.postModel.images != nil {
                        self.postViewModel.postModel.images.removeAllObjects()
                    }else{
                        self.postViewModel.postModel.images = NSMutableArray.init()
                    }
                    for asset in self.postViewModel.selectAssets  {
                        self.postViewModel.postModel.images.add((asset as! PHAsset).localIdentifier)
                    }
                    self.postViewModel.reloadTableView()
                }
            })
        }
    }
}


