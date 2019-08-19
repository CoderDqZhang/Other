//
//  MineToolsTableViewCell.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/16.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit
let ToolsViewMarginLeftAndRight:CGFloat = 8
let ToolsViewMargin:CGFloat = 12
let ToolsViewNumber:CGFloat = 5
let ToolsViewWidth = (SCREENWIDTH - ToolsViewMarginLeftAndRight * 2) / ToolsViewNumber
let ToolsViewHeight = SCREENWIDTH * 79 / 375 - 19 * 2 + 20

enum MineToolsType:Int {
    case recommend = 0
    case post = 1
    case powerfull = 2
    case collect = 3
    case buy = 4
}

typealias MineToolsTableViewCellClouse = (_ type:MineToolsType) ->Void

class MineToolsTableViewCell: UITableViewCell {

    var didMakeConstraints = false
    let images = ["recommend","post","powerful","collect","take"]
    let strings = ["我的推荐","我的发表","我的竞猜","我的收藏","我的购买"]
    
    var mineToolsTableViewCellClouse:MineToolsTableViewCellClouse!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        for index in 0...strings.count - 1 {
            let buttonView = UIView.init(frame:  CGRect.init(x: ToolsViewMarginLeftAndRight + CGFloat(index) * ToolsViewWidth, y: 19, width: ToolsViewWidth, height: ToolsViewHeight))
            buttonView.isUserInteractionEnabled = true
            
            
            let button = CustomViewButtonTopImageAndBottomLabel.init(frame: CGRect.init(x: 0, y: 0, width: ToolsViewWidth, height: ToolsViewHeight), title: strings[index], image: UIImage.init(named: images[index])!, tag: index, titleColor: App_Theme_999999_Color!, spacing: 10, font: App_Theme_PinFan_M_12_Font!) {
                if self.mineToolsTableViewCellClouse != nil {
                    self.mineToolsTableViewCellClouse(MineToolsType.init(rawValue: index)!)
                }
            }
            button.isUserInteractionEnabled = true
            buttonView.addSubview(button)
            self.contentView.addSubview(buttonView)
        }
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            
            didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
