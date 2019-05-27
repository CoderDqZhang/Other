//
//  TopUpViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/5/27.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class CoinsView: UIView {
    var backImageView:UIImageView!
    var titleLabel:YYLabel!
    var coinsLabel:YYLabel!
    var withDrawButton:AnimationButton!
    
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
        
        withDrawButton = AnimationButton.init(type: .custom)
        withDrawButton.setTitle("提现", for: .normal)
        withDrawButton.cornerRadius = 11
        withDrawButton.layer.masksToBounds = true
        withDrawButton.titleLabel?.font = App_Theme_PinFan_M_14_Font
        withDrawButton.backgroundColor = App_Theme_FFAC1B_Color
        
        self.addSubview(withDrawButton)
        
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
        
        withDrawButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(coinsLabel.snp.bottom).offset(0)
            make.size.equalTo(CGSize.init(width: 85, height: 23))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

var AnimationTouchViewMarginItemX:CGFloat =  20
var AnimationTouchViewMarginItemY:CGFloat =  15
var AnimationTouchViewMarginLeft:CGFloat =  30
var AnimationTouchViewLineCount = 3
var AnimationTouchViewAllCount = 6
var AnimationTouchViewWidth = (SCREENWIDTH - AnimationTouchViewMarginLeft * 2  - CGFloat((AnimationTouchViewLineCount - 1 )) * AnimationTouchViewMarginItemX) / CGFloat(AnimationTouchViewLineCount)
var AnimationTouchViewHeight = AnimationTouchViewWidth * 72 / 92

class TopUPView: UIView {
    
    var lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: 100, height: 1))
    var lineLabel1 = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: 100, height: 1))
    var descLable:YYLabel!
    
    var touUpAnimation:AnimationButton!
    var titleStrs = ["10M币","10M币","10M币","10M币","10M币","10M币"]
    var munberStrs = ["￥10","￥10","￥10","￥10","￥10","￥10"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        descLable = YYLabel.init()
        descLable.textAlignment = .center
        descLable.font = App_Theme_PinFan_R_14_Font
        descLable.textColor = App_Theme_B5B5B5_Color
        descLable.text = "请选择充值金额"
        self.addSubview(descLable)
        
        self.addSubview(lineLabel)
        self.addSubview(lineLabel1)
        
        lineLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(56)
            make.top.equalTo(self.snp.top).offset(31)
            make.right.equalTo(descLable.snp.left).offset(-10)
        }
        
        lineLabel1.snp.makeConstraints { (make) in
            make.left.equalTo(descLable.snp.right).offset(10)
            make.top.equalTo(self.snp.top).offset(31)
            make.right.equalTo(self.snp.right).offset(-56)
        }
        
        descLable.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.top).offset(25)
        }
        
        var maxY:CGFloat = 0
        for index in 0...AnimationTouchViewAllCount - 1 {
            let touchView = AnimationTouchView.init(frame: CGRect.init(x: AnimationTouchViewMarginLeft + (AnimationTouchViewWidth + AnimationTouchViewMarginItemX) * CGFloat(index % AnimationTouchViewLineCount), y: CGFloat((index / AnimationTouchViewLineCount)) * (AnimationTouchViewHeight + AnimationTouchViewMarginItemY) + 58, width: AnimationTouchViewWidth, height: AnimationTouchViewHeight), tag:index) {
                self.changeTouchStatus(selectIndex: index + 1000)
            }
            touchView.tag = index + 1000
            self.setUpTitleLableAndMuch(titleL: titleStrs[index], number: munberStrs[index], view: touchView)
            maxY = touchView.frame.maxY
            self.addSubview(touchView)
            touchView.borderWidth = 2
            touchView.layer.masksToBounds = true
            touchView.cornerRadius = 8
            touchView.backgroundColor = App_Theme_F6F6F6_Color
            touchView.borderColor = App_Theme_E9E9E9_Color
        }
        
        self.changeTouchStatus(selectIndex: 1001)

        
        touUpAnimation = AnimationButton.init(type: .custom)
        touUpAnimation.setTitle("确认充值", for: .normal)
        touUpAnimation.cornerRadius = 24
        touUpAnimation.layer.masksToBounds = true
        touUpAnimation.titleLabel?.font = App_Theme_PinFan_M_15_Font
        touUpAnimation.backgroundColor = App_Theme_FFD512_Color
        touUpAnimation.addAction({ (button) in
            
        }, for: .touchUpInside)
        self.addSubview(touUpAnimation)
        
        touUpAnimation.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.right.equalTo(self.snp.right).offset(-15)
            make.height.equalTo(47)
            make.top.equalTo(self.snp.top).offset(maxY + 20)
        }
    }
    
    func changeTouchStatus(selectIndex:Int){
        for index in 0...AnimationTouchViewAllCount - 1 {
            let touchView = self.viewWithTag(index + 1000)! as! AnimationTouchView
            if index + 1000 == selectIndex {
                touchView.borderWidth = 2
                touchView.layer.masksToBounds = true
                touchView.cornerRadius = 8
                touchView.backgroundColor = App_Theme_FFF8D5_Color
                touchView.borderColor = App_Theme_FFD512_Color
                self.changeColor(textColor: App_Theme_06070D_Color!, view: touchView)
            }else{
                touchView.borderWidth = 2
                touchView.layer.masksToBounds = true
                touchView.cornerRadius = 8
                touchView.backgroundColor = App_Theme_F6F6F6_Color
                touchView.borderColor = App_Theme_E9E9E9_Color
                self.changeColor(textColor: App_Theme_666666_Color!, view: touchView)
            }
        }
        
    }
    
    func changeColor(textColor:UIColor,view:AnimationTouchView){
        let titleLabel = view.viewWithTag(10) as! YYLabel
        titleLabel.textColor = textColor
        
        let muchLabel = view.viewWithTag(11) as! YYLabel
        muchLabel.textColor = textColor
    }
    
    func setUpTitleLableAndMuch(titleL:String,number:String,view:AnimationTouchView){
        let titleLable = YYLabel.init()
        let nsstring = NSMutableAttributedString.init(string: titleL)
        nsstring.addAttributes([NSAttributedString.Key.font : App_Theme_PinFan_M_21_Font!], range: NSRange.init(location: 0, length: nsstring.length - 2))
        nsstring.addAttributes([NSAttributedString.Key.font : App_Theme_PinFan_R_10_Font!], range: NSRange.init(location: nsstring.length - 2, length: 2))
        titleLable.font = App_Theme_PinFan_R_12_Font
        titleLable.textColor = App_Theme_999999_Color
        titleLable.attributedText = nsstring
        titleLable.tag = 10
        titleLable.textAlignment = .center
        view.addSubview(titleLable)
        
        let muchLabel = YYLabel.init()
        muchLabel.tag = 11
        muchLabel.textAlignment = .center
        muchLabel.font = App_Theme_PinFan_R_12_Font
        muchLabel.textColor = App_Theme_999999_Color
        muchLabel.text = number
        view.addSubview(muchLabel)
        
        titleLable.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.centerY.equalTo(view.snp.centerY).offset(-10)
        }
        
        muchLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.centerY.equalTo(view.snp.centerY).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TopUpViewController: BaseViewController {

    var scrollerView:UIScrollView!
    
    var coinsView:CoinsView!
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
            coinsView = CoinsView.init(frame: CGRect.init(x: 0, y: -20 - NAV_HEIGHT, width: SCREENWIDTH, height: 189 + NAV_HEIGHT))
        } else {
            coinsView = CoinsView.init(frame: CGRect.init(x: 0, y: -20 , width: SCREENWIDTH, height: 189))
            // Fallback on earlier versions
        }
        coinsView.withDrawButton.addAction({ (button) in
            NavigationPushView(self, toConroller: WithdrawViewController())
        }, for: .touchUpInside)
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
