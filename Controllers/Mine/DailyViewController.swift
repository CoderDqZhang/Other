//
//  DailyViewController.swift
//  Touqiu
//
//  Created by Zhang on 2019/6/11.
//  Copyright © 2019 com.touqiu.touqiu. All rights reserved.
//

import UIKit

class DailyViewController: BaseViewController {

    var gloableNavigationBar:GLoabelNavigaitonBar!
    let dailyViewModel = DailyViewModel.init()
    var scrollowView:UIScrollView!
    
    var inveterBtn:AnimationButton!
    var detailLabel:YYLabel!
    var slidView:UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        
        if #available(iOS 11.0, *) {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: -NAV_HEIGHT/2, width: SCREENWIDTH, height: 64 + NAV_HEIGHT), title: "", rightButton: nil, click: { (type) in
                if type == .backBtn{
                    self.navigationController?.popViewController()
                }
            })
        } else {
            gloableNavigationBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 64), title: "", rightButton: nil, click: { (type) in
                if type == .backBtn{
                    self.navigationController?.popViewController()
                }
            })
            // Fallback on earlier versions
        }
        
        self.view.addSubview(gloableNavigationBar)
    }
    

    override func setUpView() {
        self.bindViewModel(viewModel: dailyViewModel, controller: self)

        scrollowView = UIScrollView.init()
        self.view.addSubview(scrollowView)
        scrollowView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalTo(-NAV_HEIGHT)
            } else {
                make.top.equalTo(-44)
                // Fallback on earlier versions
            }
            make.bottom.equalToSuperview()
        }
        
        let backImage = UIImageView.init()
        let image = UIImage.init(named: "signin")
        backImage.image = image
        backImage.isUserInteractionEnabled = true
        scrollowView.addSubview(backImage)
        let imageHeight = SCREENWIDTH * (image?.size.height)! / (image?.size.width)!
        backImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.top.equalTo(self.view.snp.top).offset(-20)
            make.size.equalTo(CGSize.init(width: SCREENWIDTH, height: imageHeight))
        }
        
        
        let layerView = UIView()
        layerView.frame = CGRect(x: 0, y: imageHeight - 40, width: SCREENWIDTH, height: SCREENHEIGHT - imageHeight + 40)
        // layerFillCode
        let layer = CALayer()
        layer.frame = layerView.bounds
        layer.backgroundColor = UIColor(red: 0.95, green: 0.65, blue: 0.25, alpha: 1).cgColor
        layerView.layer.addSublayer(layer)
        // gradientCode
        let gradient1 = CAGradientLayer()
        gradient1.colors = [UIColor(red: 0.95, green: 0.65, blue: 0.25, alpha: 1).cgColor,UIColor(red: 0.97, green: 0.85, blue: 0.29, alpha: 1).cgColor]
        gradient1.locations = [0, 1]
        gradient1.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient1.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient1.frame = layerView.bounds
        layerView.layer.addSublayer(gradient1)
        scrollowView.addSubview(layerView)
        
        
        let inveterView = UIView.init()
        if #available(iOS 11.0, *) {
            inveterView.frame = CGRect.init(x: 0, y: SCREENHEIGHT - (455 + TABBAR_HEIGHT), width: SCREENWIDTH, height: 455 + TABBAR_HEIGHT)
        } else {
            inveterView.frame = CGRect.init(x: 0, y: SCREENHEIGHT - 455, width: SCREENWIDTH, height: 455)
            // Fallback on earlier versions
        }
        inveterView.tag = 1000
        inveterView.isUserInteractionEnabled = true
        scrollowView.addSubview(inveterView)




        inveterBtn = AnimationButton.init(type: .custom)
        inveterBtn.setBackgroundImage(UIImage.init(named: "sigin_button"), for: .normal)
        inveterBtn.reactive.controlEvents(.touchUpInside).observeValues { (button) in
            self.dailyViewModel.getDailyNet()
        }

        scrollowView.addSubview(inveterBtn)
        inveterView.bringSubviewToFront(inveterBtn)

        inveterBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 194, height: 62))
            make.centerX.equalToSuperview()
            make.bottom.equalTo(backImage.snp.bottom).offset(-40)
        }

        let numberView = self.createDailyNumber(frame: CGRect.init(x: 15, y: backImage.frame.maxY, width: SCREENWIDTH - 30, height: 115))
        inveterView.addSubview(numberView)

        numberView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: SCREENWIDTH - 30, height: 115))
            make.centerX.equalToSuperview()
            make.top.equalTo(inveterBtn.snp.bottom).offset(15)
        }
        // MARK: 签到规则暂时不用
        /*
        let signTitleRuleLabel = YYLabel.init()
        signTitleRuleLabel.frame = CGRect.init(x: 0, y: imageHeight + 127, width: SCREENWIDTH, height: 20)
        signTitleRuleLabel.textAlignment = .center
        signTitleRuleLabel.font = App_Theme_PinFan_R_15_Font
        signTitleRuleLabel.textColor = App_Theme_FFFFFF_Color
        signTitleRuleLabel.text = "签到规则"
        scrollowView.addSubview(signTitleRuleLabel)
        
        let imgView:UIImageView = UIImageView(frame: CGRect(x: 15, y: signTitleRuleLabel.frame.maxY + 11, width: SCREENWIDTH - 30, height: 1))
        scrollowView.addSubview(imgView)
        UIGraphicsBeginImageContext(imgView.frame.size) // 位图上下文绘制区域
        imgView.image?.draw(in: imgView.bounds)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setLineCap(CGLineCap.square)
        let lengths:[CGFloat] = [5,15] // 绘制 跳过 无限循环
        context.setStrokeColor(App_Theme_FFFFFF_Color!.cgColor)
        context.setLineWidth(10)
        context.setLineDash(phase: 0, lengths: lengths)
        context.move(to: CGPoint(x: 0, y: 3))
        context.addLine(to: CGPoint(x: SCREENWIDTH, y: 1))
        context.strokePath()
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        let signRuleLabel = YYLabel.init()
        signRuleLabel.textAlignment = .left
        signRuleLabel.font = App_Theme_PinFan_R_12_Font
        signRuleLabel.numberOfLines = 0
        signRuleLabel.textColor = App_Theme_FFFFFF_Color
        signRuleLabel.frame = CGRect.init(x: 15, y: signTitleRuleLabel.frame.maxY + 21, width: SCREENWIDTH - 30, height: 55)
        signRuleLabel.text = "签到规则签到规则签到规则签到规则签到规则签到规则签到规则签到规则签到规则签到规则签到规则签到规则签到规则签到规则签到规则签到规则签到规则签到规则签到规则签到规则签到规则签到规则"
        scrollowView.addSubview(signRuleLabel)
         */
        
    }
    
    func createDailyNumber(frame:CGRect)->UIView{
        let dailyView = UIView.init(frame: frame)
        dailyView.layer.cornerRadius = 15
        dailyView.backgroundColor = App_Theme_FFFFFF_Color
        dailyView.layer.masksToBounds = true
        
        detailLabel = YYLabel.init()
        detailLabel.textAlignment = .center
        let nsStr = NSMutableAttributedString.init(string: "已累计签到0天")
        nsStr.addAttributes([NSAttributedString.Key.font : App_Theme_PinFan_M_18_Font!,NSAttributedString.Key.foregroundColor:App_Theme_06070D_Color!], range: NSRange.init(location: 0, length: 5))
        nsStr.addAttributes([NSAttributedString.Key.font : App_Theme_PinFan_M_18_Font!,NSAttributedString.Key.foregroundColor:App_Theme_F2A541_Color!], range: NSRange.init(location: 5, length: 1))
        nsStr.addAttributes([NSAttributedString.Key.font : App_Theme_PinFan_M_18_Font!,NSAttributedString.Key.foregroundColor:App_Theme_06070D_Color!], range: NSRange.init(location: 6, length: 1))
        detailLabel.attributedText = nsStr
        dailyView.addSubview(detailLabel)
        
        detailLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(dailyView.snp.top).offset(14)
        }
        
        let numberLabel = YYLabel.init()
        numberLabel.textAlignment = .right
        numberLabel.font = App_Theme_PinFan_M_10_Font
        numberLabel.textColor = App_Theme_B5B5B5_Color
        numberLabel.text = "100"
        dailyView.addSubview(numberLabel)
        
        numberLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(70)
            make.top.equalTo(detailLabel.snp.bottom).offset(5)
        }
        
        let numberLabel1 = YYLabel.init()
        numberLabel1.textAlignment = .center
        numberLabel1.font = App_Theme_PinFan_M_10_Font
        numberLabel1.textColor = App_Theme_B5B5B5_Color
        numberLabel1.text = "300"
        dailyView.addSubview(numberLabel1)
        
        numberLabel1.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.right.equalTo(dailyView.snp.right).offset(0)
            make.top.equalTo(detailLabel.snp.bottom).offset(5)
        }
        
        let image = UIImage.init(color: App_Theme_FFAC1B_Color!, size: CGSize.init(width: 23, height: 23))
        let textImage = UIImage.circleImage(withName:   UIImage.init(text: "20", textFont: 10, textColor: App_Theme_FFFFFF_Color!, textFrame: CGRect.init(x: 5, y: 5, width: 23, height: 23), originImage: image, imageLocationViewFrame: CGRect.init(x: 0, y: 0, width: 23, height: 23)), borderWidth: 1, borderColor: UIColor.clear)
        
        slidView = UISlider.init(frame: CGRect.init(x: 15, y: 69, width: frame.size.width - 30, height: 4))
        slidView.maximumValue = 70
        slidView.minimumValue = 0
        slidView.isEnabled = false
        slidView.value = 50
        slidView.minimumTrackTintColor = App_Theme_FFD512_Color
        slidView.maximumTrackTintColor = App_Theme_EDEDED_Color
        slidView.setThumbImage(textImage, for: .normal)
        dailyView.addSubview(slidView)
        
        for i in 0...7 {
            let numberLabel1 = YYLabel.init(frame: CGRect.init(x: ((frame.size.width - 30) / 7) - 10 + CGFloat(i) * ((frame.size.width - 30) / 7), y: 90, width: (frame.size.width - 30) / 7, height: 20))
            numberLabel1.textAlignment = .center
            numberLabel1.font = App_Theme_PinFan_M_10_Font
            numberLabel1.textColor = App_Theme_B5B5B5_Color
            numberLabel1.text = "\(i + 1)天"
            dailyView.addSubview(numberLabel1)
        }
        
        return dailyView
    }
    
//    func createSubView(frame:CGRect) -> UIView{
//        let dailyView = UIView.init(frame: frame)
//        dailyView.layer.cornerRadius = 15
//        dailyView.backgroundColor = App_Theme_FFFFFF_Color
//        dailyView.layer.masksToBounds = true
//
//        let detailLabel = YYLabel.init()
//        detailLabel.textAlignment = .center
//        detailLabel.text = "每日任务"
//        detailLabel.font = App_Theme_PinFan_M_15_Font
//        detailLabel.textColor = App_Theme_06070D_Color
//        dailyView.addSubview(detailLabel)
//
//        detailLabel.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview().offset(20)
//            make.top.equalTo(dailyView.snp.top).offset(14)
//        }
//
//        let imageView = UIImageView.init(image: UIImage.init(named: "daily_mode"))
//        dailyView.addSubview(imageView)
//        imageView.snp.makeConstraints { (make) in
//            make.top.equalTo(dailyView.snp.top).offset(15)
//            make.right.equalTo(detailLabel.snp.left).offset(9)
//        }
//
//        let lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: frame.size.width - 30, height: 1))
//        dailyView.addSubview(lineLabel)
//
//        lineLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(imageView.snp.bottom).offset(6)
//            make.centerX.equalToSuperview()
//            make.size.equalTo(CGSize.init(width: frame.size.width - 30, height: 1))
//        }
//
//        let numberLabel = YYLabel.init()
//        numberLabel.textAlignment = .right
//        numberLabel.font = App_Theme_PinFan_M_10_Font
//        numberLabel.textColor = App_Theme_B5B5B5_Color
//        numberLabel.text = "100"
//        dailyView.addSubview(numberLabel)
//
//        numberLabel.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.width.equalTo(100)
//            make.top.equalTo(detailLabel.snp.bottom).offset(5)
//        }
//
//        let lineLabel1 = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: frame.size.width - 30, height: 1))
//        dailyView.addSubview(lineLabel1)
//
//        lineLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(imageView.snp.bottom).offset(6)
//            make.centerX.equalToSuperview()
//            make.size.equalTo(CGSize.init(width: frame.size.width - 30, height: 1))
//        }
//
//        let numberLabel1 = YYLabel.init()
//        numberLabel1.textAlignment = .center
//        numberLabel1.font = App_Theme_PinFan_M_10_Font
//        numberLabel1.textColor = App_Theme_B5B5B5_Color
//        numberLabel1.text = "300"
//        dailyView.addSubview(numberLabel1)
//
//        numberLabel1.snp.makeConstraints { (make) in
//            make.width.equalTo(100)
//            make.right.equalTo(dailyView.snp.right).offset(0)
//            make.top.equalTo(detailLabel.snp.bottom).offset(5)
//        }
//
//        let lineLabel2 = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: frame.size.width - 30, height: 1))
//        dailyView.addSubview(lineLabel2)
//
//        lineLabel2.snp.makeConstraints { (make) in
//            make.top.equalTo(imageView.snp.bottom).offset(6)
//            make.centerX.equalToSuperview()
//            make.size.equalTo(CGSize.init(width: frame.size.width - 30, height: 1))
//        }
//
//        let image = UIImage.init(color: App_Theme_FFD512_Color!, size: CGSize.init(width: 23, height: 23))
//        let textImage = UIImage.circleImage(withName:   UIImage.init(text: "20", textFont: 10, textColor: App_Theme_FFFFFF_Color!, textFrame: CGRect.init(x: 5, y: 5, width: 23, height: 23), originImage: image, imageLocationViewFrame: CGRect.init(x: 0, y: 0, width: 23, height: 23)), borderWidth: 1, borderColor: UIColor.clear)
//
//        let slidView = UISlider.init(frame: CGRect.init(x: 15, y: 69, width: frame.size.width - 30, height: 4))
//        slidView.maximumValue = 70
//        slidView.minimumValue = 0
//        slidView.value = 50
//        slidView.minimumTrackTintColor = App_Theme_E34D31_Color
//        slidView.maximumTrackTintColor = App_Theme_EDEDED_Color
//        slidView.setThumbImage(textImage, for: .normal)
//        dailyView.addSubview(slidView)
//
////        for i in 0...7 {
////            let numberLabel1 = YYLabel.init(frame: CGRect.init(x: 30 + CGFloat(i) * ((frame.size.width - 30) / 7), y: 90, width: (frame.size.width - 30) / 7, height: 20))
////            numberLabel1.backgroundColor = i % 2 == 0 ? .red : .blue
////            numberLabel1.textAlignment = .center
////            numberLabel1.font = App_Theme_PinFan_M_10_Font
////            numberLabel1.textColor = App_Theme_B5B5B5_Color
////            numberLabel1.text = "\(i + 1)天"
////            dailyView.addSubview(numberLabel1)
////        }
//
//        let numberLabel2 = YYLabel.init(frame: CGRect.init(x: 30, y: 90, width: (frame.size.width - 30) / 7, height: 20))
//        numberLabel2.backgroundColor = .red
//        numberLabel2.textAlignment = .center
//        numberLabel2.font = App_Theme_PinFan_M_10_Font
//        numberLabel2.textColor = App_Theme_B5B5B5_Color
//        numberLabel2.text = "7天"
//        dailyView.addSubview(numberLabel2)
//
//        return dailyView
//    }
    
    
    func updateDailyModel(model:DailyModel){
        if model.status == 1 {
            inveterBtn.isEnabled = false
            inveterBtn.setBackgroundImage(UIImage.init(), for: .normal)
            inveterBtn.setTitle("今日已签到", for: .normal)
            inveterBtn.setTitleColor(App_Theme_FFFFFF_Color, for: .normal)
            inveterBtn.titleLabel?.font = App_Theme_PinFan_M_21_Font
        }else{
            inveterBtn.isEnabled = true
        }
        
        let image = UIImage.init(color: App_Theme_FFD512_Color!, size: CGSize.init(width: 23, height: 23))
        let textImage = UIImage.circleImage(withName:   UIImage.init(text: model.points, textFont: 10, textColor: App_Theme_FFFFFF_Color!, textFrame: CGRect.init(x: 5, y: 5, width: 23, height: 23), originImage: image, imageLocationViewFrame: CGRect.init(x: 0, y: 0, width: 23, height: 23)), borderWidth: 1, borderColor: UIColor.clear)
        slidView.setThumbImage(textImage, for: .normal)
        slidView.value = (model.signIn * 10).float
        
        let nsStr = NSMutableAttributedString.init(string: "已累计签到\(model.signIn ?? 0)天")
        nsStr.addAttributes([NSAttributedString.Key.font : App_Theme_PinFan_M_18_Font!,NSAttributedString.Key.foregroundColor:App_Theme_06070D_Color!], range: NSRange.init(location: 0, length: 5))
        nsStr.addAttributes([NSAttributedString.Key.font : App_Theme_PinFan_M_18_Font!,NSAttributedString.Key.foregroundColor:App_Theme_F2A541_Color!], range: NSRange.init(location: 5, length: 1))
        nsStr.addAttributes([NSAttributedString.Key.font : App_Theme_PinFan_M_18_Font!,NSAttributedString.Key.foregroundColor:App_Theme_06070D_Color!], range: NSRange.init(location: 6, length: 1))
        detailLabel.attributedText = nsStr
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
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
