//
//  FilterViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/1.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
import JXSegmentedView
import BDKCollectionIndexView

let CollectIemtCount:CGFloat = 3
let CollectIemtMarginWidth:CGFloat = 12
let CollectItemMarginHeight:CGFloat = 8
let CollectItemSizeWidth:CGFloat = ((SCREENWIDTH - 30) - CollectIemtCount * CollectIemtMarginWidth) / CollectIemtCount
let CollectItemSizeHeight:CGFloat = 34

class FilterViewController: BaseViewController {

    var filterViewModel = FilterViewModel.init()
    
    var collectionView:UICollectionView!
    
    var buttomView:FilterBottomView!
    
    var viewType:ScoreDetailVC!
    var viewDesc:ScoreDetailTypeVC!
    
    let indexWidth:CGFloat = 28
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func initSView(type:Int) {
        self.bindViewModel(viewModel: filterViewModel, controller: self)
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: CollectItemSizeWidth, height: CollectItemSizeHeight)
        layout.minimumLineSpacing = CollectItemMarginHeight
        layout.minimumInteritemSpacing = CollectIemtMarginWidth
        layout.headerReferenceSize = CGSize.init(width: SCREENWIDTH, height: 30)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 8, left: 15, bottom: 8, right: 15)

        collectionView = UICollectionView.init(frame: CGRect(x:0, y:0, width:SCREENWIDTH, height:SCREENHEIGHT - 108 - 48), collectionViewLayout: layout)
        collectionView?.backgroundColor = App_Theme_F6F6F6_Color
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.description())
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        collectionView?.delegate = filterViewModel
        collectionView?.dataSource = filterViewModel
        self.view.addSubview(collectionView!)
        
        
        buttomView = FilterBottomView.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 48, width: SCREENWIDTH, height: 48), number: "0", click: { (type) in
            
        })
        self.view.addSubview(buttomView)
        buttomView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.height.equalTo(48 + TABBAR_HEIGHT)
            } else {
                // Fallback on earlier versions
                make.height.equalTo(48)
            }
        }
        
        let frame = CGRect(x: SCREENWIDTH - indexWidth,
                           y: 0,
                           width: indexWidth,
                           height: SCREENHEIGHT - 108 - 44 - 44)
        let indexView = BDKCollectionIndexView.init(frame: frame, indexTitles: ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T"])
        indexView?.delegate = self
        indexView!.autoresizingMask = [.flexibleHeight,.flexibleLeftMargin]
        indexView!.addTarget(self, action: #selector(indexViewValueChanged(sender:)), for: .valueChanged)
        self.view.addSubview(indexView!)
        
    }
    
    @objc func indexViewValueChanged(sender: BDKCollectionIndexView) {
        let path = NSIndexPath(item: 0, section: Int(sender.currentIndex))
        collectionView.scrollToItem(at: path as IndexPath, at: .top, animated: false)
        // If you're using a collection view, bump the y-offset by a certain number of points
        // because it won't otherwise account for any section headers you may have.
        collectionView.contentOffset = CGPoint(x: collectionView.contentOffset.x,
                                               y: collectionView.contentOffset.y - 45.0)
    }
    
    override func bindViewModelLogic() {
    
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

extension FilterViewController : JXSegmentedListContainerViewListDelegate {
    override func listView() -> UIView {
        return view
    }
    
    override func listDidAppear() {
        print("listDidAppear")
    }
    
    override func listDidDisappear() {
        print("listDidDisappear")
    }
}

extension FilterViewController : BDKCollectionIndexViewDelegate {
    func collectionIndexView(_ collectionIndexView: BDKCollectionIndexView!, liftedFingerFrom pressedIndex: UInt) {
        
    }
    
    func collectionIndexView(_ collectionIndexView: BDKCollectionIndexView!, isPressedOn pressedIndex: UInt, indexTitle: String!) {
        
    }
}
