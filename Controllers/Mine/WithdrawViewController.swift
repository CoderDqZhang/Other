//
//  WithdrawViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/27.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class CoinsCountView: UIView {
    var backImageView:UIImageView!
    var titleLabel:YYLabel!
    var coinsLabel:YYLabel!
    var allCoinsLabel:YYLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backImageView = UIImageView.init()
        backImageView.image = UIImage.init(named: "coins_back")
        self.addSubview(backImageView)
        
        titleLabel = YYLabel.init()
        titleLabel.textAlignment = .center
        titleLabel.font = App_Theme_PinFan_R_14_Font
        titleLabel.textColor = App_Theme_06070D_Color
        titleLabel.text = "当前余额(M币)"
        self.addSubview(titleLabel)
        
        coinsLabel = YYLabel.init()
        coinsLabel.textAlignment = .center
        coinsLabel.font = App_Theme_PinFan_M_24_Font
        coinsLabel.textColor = App_Theme_06070D_Color
        coinsLabel.text = "666.66"
        self.addSubview(coinsLabel)
        
        coinsLabel = YYLabel.init()
        coinsLabel.textAlignment = .center
        coinsLabel.font = App_Theme_PinFan_M_24_Font
        coinsLabel.textColor = App_Theme_06070D_Color
        coinsLabel.text = "总余额为666666.66M币"
        self.addSubview(coinsLabel)
        
        self.updateConstraints()
    }
    
    func viewSetData(model:AccountCoinsModel){
        //        coinsLabel.text = model.chargeCoin.string
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        backImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        coinsLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.centerY.equalTo(self.snp.centerY).offset(24)
            } else {
                make.centerY.equalTo(self.snp.centerY).offset(0)
                // Fallback on earlier versions
            }
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(coinsLabel.snp.top).offset(0)
        }
        
        coinsLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(coinsLabel.snp.bottom).offset(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class WithdrawViewController: BaseViewController {

    
    var scrollerView:UIScrollView!
    
    var coinsView:CoinsCountView!
    var topUPView:TopUPView!
    
    var warningLabel:YYLabel!
    
    var gloableNavigationBar:GLoabelNavigaitonBar!
    var touUpViewModel = TouUpViewModel.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        let rightButton = AnimationButton.init(type: .custom)
        rightButton.setTitle("明细", for: .normal)
        rightButton.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        if #available(iOS 11.0, *) {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: -NAV_HEIGHT/2, width: SCREENWIDTH, height: 64 + NAV_HEIGHT), title: "", rightButton: rightButton, click: { (type) in
                if type == .backBtn {
                    self.navigationController?.popViewController()
                }else{
                    NavigationPushView(self, toConroller: ConinsSegementViewController())
                }
            })
        } else {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 64), title: "", rightButton: rightButton, click: { (type) in
                if type == .backBtn {
                    self.navigationController?.popViewController()
                }else{
                    NavigationPushView(self, toConroller: CoinsDetailViewController())
                }
            })
            // Fallback on earlier versions
        }
        
        self.view.addSubview(gloableNavigationBar)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func setUpView() {
        scrollerView = UIScrollView.init()
        scrollerView.contentSize = CGSize.init(width: SCREENWIDTH, height: 700)
        scrollerView.backgroundColor = App_Theme_FFFFFF_Color
        self.view.addSubview(scrollerView)
        
        scrollerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
        if #available(iOS 11.0, *) {
            coinsView = CoinsCountView.init(frame: CGRect.init(x: 0, y: -20 - NAV_HEIGHT, width: SCREENWIDTH, height: 189 + NAV_HEIGHT))
        } else {
            coinsView = CoinsCountView.init(frame: CGRect.init(x: 0, y: -20 , width: SCREENWIDTH, height: 189))
            // Fallback on earlier versions
        }
        
        scrollerView.addSubview(coinsView)
        
        topUPView = TopUPView.init(frame: CGRect.init(x: 0, y: 138, width: SCREENWIDTH, height: 58 + 47 + AnimationTouchViewHeight * 2 + AnimationTouchViewMarginItemY + 60))
        topUPView.backgroundColor = App_Theme_FFFFFF_Color
        setMutiBorderRoundingCorners(topUPView, corner: 15, byRoundingCorners: [UIRectCorner.topLeft,UIRectCorner.topRight])
        scrollerView.addSubview(topUPView)
        
        
        warningLabel = YYLabel.init(frame: CGRect.init(x: 17, y: topUPView.frame.maxY, width: SCREENWIDTH - 17 * 2, height: 100))
        warningLabel.textAlignment = .left
        warningLabel.numberOfLines = 0
        warningLabel.font = App_Theme_PinFan_R_12_Font
        warningLabel.textColor = App_Theme_B5B5B5_Color
        warningLabel.text = "温馨提示\n1. 兑换比例：1元=1M币2. 兑换比例：1元=1M币2. 兑换比例：1元=1M币2. 兑换比例：1元=1M币2. 兑换比例：1元=1M币2. 兑换比例：1元=1M币2. 兑换比例：1元=1M币2. 兑换比例：1元=1M币3. 兑换比例：1元=1M币4. 兑换比例：1元=1M币"
        scrollerView.addSubview(warningLabel)
        
        
    }
    
    override func bindViewModelLogic() {
        self.bindViewModel(viewModel: touUpViewModel, controller: self)
        self.touUpViewModel.getAccount()
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
