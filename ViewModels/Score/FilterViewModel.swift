//
//  FilterViewModel.swift
//  Touqiu
//
//  Created by Zhang on 2019/8/1.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class FilterViewModel: BaseViewModel {

    var titles:NSArray = NSArray.init(array: ["Z","A","B","C","D","E","F"])
    override init() {
        
    }
    
    func cellFilterCollectionViewCellSetData(_ indexPath:IndexPath, cell:FilterCollectionViewCell){
        
    }
}

extension FilterViewModel : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
    }
}

extension FilterViewModel : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath)
        let titleLabel = YYLabel.init(frame: CGRect.init(x: 16, y: 5, width: 100, height: 20))
        titleLabel.textAlignment = .left
        titleLabel.font = App_Theme_PinFan_M_12_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = "A"
        headerView.addSubview(titleLabel)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.description(), for: indexPath)
        self.cellFilterCollectionViewCellSetData(indexPath, cell: cell as! FilterCollectionViewCell)
        return cell
    }
}
