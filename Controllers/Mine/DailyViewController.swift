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
        scrollowView.backgroundColor = .red
        self.view.addSubview(scrollowView)
        scrollowView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        let backImage = UIImageView.init()
        let image = UIImage.init(named: "signin")
        backImage.image = image
        backImage.backgroundColor = .blue
        scrollowView.addSubview(backImage)
        let imageHeight = SCREENWIDTH * (image?.size.height)! / (image?.size.width)!
        backImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalTo(-NAV_HEIGHT)
            } else {
                make.top.equalTo(-44)
                // Fallback on earlier versions
            }
            make.size.equalTo(CGSize.init(width: SCREENWIDTH, height: imageHeight))
        }
        
        
        let inveterView = UIView.init()
        inveterView.backgroundColor = .clear
        inveterView.tag = 1000
        self.view.addSubview(inveterView)
        inveterView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.height.equalTo(415 + TABBAR_HEIGHT)
            } else {
                // Fallback on earlier versions
                make.height.equalTo(415)
            }
        }
        
        
        let backView = UIView.init()
        backView.backgroundColor = App_Theme_F65449_Color
        inveterView.addSubview(backView)
        backView.tag = 2000
        backView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(inveterView.snp.top).offset(0)
        }
        
        
        let inveterBtn = AnimationButton.init(type: .custom)
        inveterBtn.setBackgroundImage(UIImage.init(named: "daily"), for: .normal)
        inveterView.addSubview(inveterBtn)
        inveterView.bringSubviewToFront(inveterBtn)
        
        
        
        inveterBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 194, height: 62))
            make.centerX.equalToSuperview()
            make.bottom.equalTo(backImage.snp.bottom).offset(-40)
        }
        
        let numberView = self.createDailyNumber(frame: CGRect.init(x: 15, y: backImage.frame.maxY - 20, width: SCREENWIDTH - 30, height: 115))
        inveterView.addSubview(numberView)
        
        numberView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: SCREENWIDTH - 30, height: 115))
            make.centerX.equalToSuperview()
            make.top.equalTo(inveterBtn.snp.bottom).offset(5)
        }
        
    }
    
    func createDailyNumber(frame:CGRect)->UIView{
        let dailyView = UIView.init(frame: frame)
        dailyView.layer.cornerRadius = 15
        dailyView.backgroundColor = App_Theme_FFFFFF_Color
        dailyView.layer.masksToBounds = true
        
        let detailLabel = YYLabel.init()
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
            make.width.equalTo(100)
            make.top.equalTo(detailLabel.snp.bottom).offset(5)
        }
        
        let numberLabel1 = YYLabel.init()
        numberLabel1.textAlignment = .center
        numberLabel1.font = App_Theme_PinFan_M_10_Font
        numberLabel1.textColor = App_Theme_B5B5B5_Color
        numberLabel1.text = "300"
        dailyView.addSubview(numberLabel1)
        
        numberLabel1.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.right.equalTo(dailyView.snp.right).offset(0)
            make.top.equalTo(detailLabel.snp.bottom).offset(5)
        }
        
        let image = UIImage.init(color: App_Theme_FFD512_Color!, size: CGSize.init(width: 23, height: 23))
        let textImage = UIImage.circleImage(withName:   UIImage.init(text: "20", textFont: 10, textColor: App_Theme_FFFFFF_Color!, textFrame: CGRect.init(x: 5, y: 5, width: 23, height: 23), originImage: image, imageLocationViewFrame: CGRect.init(x: 0, y: 0, width: 23, height: 23)), borderWidth: 1, borderColor: UIColor.clear)
        
        let slidView = UISlider.init(frame: CGRect.init(x: 15, y: 69, width: frame.size.width - 30, height: 4))
        slidView.maximumValue = 70
        slidView.minimumValue = 0
        slidView.value = 50
        slidView.minimumTrackTintColor = App_Theme_E34D31_Color
        slidView.maximumTrackTintColor = App_Theme_EDEDED_Color
        slidView.setThumbImage(textImage, for: .normal)
        dailyView.addSubview(slidView)
        
        for i in 0...7 {
            let numberLabel1 = YYLabel.init(frame: CGRect.init(x: 30 + CGFloat(i) * (SCREENWIDTH - 60) / 7, y: 90, width: 40, height: 20))
            numberLabel1.textAlignment = .center
            numberLabel1.font = App_Theme_PinFan_M_10_Font
            numberLabel1.textColor = App_Theme_B5B5B5_Color
            numberLabel1.text = "\(i + 1)天"
            dailyView.addSubview(numberLabel1)
        }
        
        return dailyView
    }
    
    func createSubView(frame:CGRect) -> UIView{
        let dailyView = UIView.init(frame: frame)
        dailyView.layer.cornerRadius = 15
        dailyView.backgroundColor = App_Theme_FFFFFF_Color
        dailyView.layer.masksToBounds = true
        
        let detailLabel = YYLabel.init()
        detailLabel.textAlignment = .center
        detailLabel.text = "每日任务"
        detailLabel.font = App_Theme_PinFan_M_15_Font
        detailLabel.textColor = App_Theme_06070D_Color
        dailyView.addSubview(detailLabel)
        
        detailLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(20)
            make.top.equalTo(dailyView.snp.top).offset(14)
        }
        
        let imageView = UIImageView.init(image: UIImage.init(named: "daily_mode"))
        dailyView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(dailyView.snp.top).offset(15)
            make.right.equalTo(detailLabel.snp.left).offset(9)
        }
        
        let lineLabel = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: frame.size.width - 30, height: 1))
        dailyView.addSubview(lineLabel)
        
        lineLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: frame.size.width - 30, height: 1))
        }
        
        let numberLabel = YYLabel.init()
        numberLabel.textAlignment = .right
        numberLabel.font = App_Theme_PinFan_M_10_Font
        numberLabel.textColor = App_Theme_B5B5B5_Color
        numberLabel.text = "100"
        dailyView.addSubview(numberLabel)
        
        numberLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.top.equalTo(detailLabel.snp.bottom).offset(5)
        }
        
        let lineLabel1 = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: frame.size.width - 30, height: 1))
        dailyView.addSubview(lineLabel1)
        
        lineLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: frame.size.width - 30, height: 1))
        }
        
        let numberLabel1 = YYLabel.init()
        numberLabel1.textAlignment = .center
        numberLabel1.font = App_Theme_PinFan_M_10_Font
        numberLabel1.textColor = App_Theme_B5B5B5_Color
        numberLabel1.text = "300"
        dailyView.addSubview(numberLabel1)
        
        numberLabel1.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.right.equalTo(dailyView.snp.right).offset(0)
            make.top.equalTo(detailLabel.snp.bottom).offset(5)
        }
        
        let lineLabel2 = GloableLineLabel.createLineLabel(frame: CGRect.init(x: 0, y: 0, width: frame.size.width - 30, height: 1))
        dailyView.addSubview(lineLabel2)
        
        lineLabel2.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: frame.size.width - 30, height: 1))
        }
        
        let image = UIImage.init(color: App_Theme_FFD512_Color!, size: CGSize.init(width: 23, height: 23))
        let textImage = UIImage.circleImage(withName:   UIImage.init(text: "20", textFont: 10, textColor: App_Theme_FFFFFF_Color!, textFrame: CGRect.init(x: 5, y: 5, width: 23, height: 23), originImage: image, imageLocationViewFrame: CGRect.init(x: 0, y: 0, width: 23, height: 23)), borderWidth: 1, borderColor: UIColor.clear)
        
        let slidView = UISlider.init(frame: CGRect.init(x: 15, y: 69, width: frame.size.width - 30, height: 4))
        slidView.maximumValue = 70
        slidView.minimumValue = 0
        slidView.value = 50
        slidView.minimumTrackTintColor = App_Theme_E34D31_Color
        slidView.maximumTrackTintColor = App_Theme_EDEDED_Color
        slidView.setThumbImage(textImage, for: .normal)
        dailyView.addSubview(slidView)
        
        for i in 0...7 {
            let numberLabel1 = YYLabel.init(frame: CGRect.init(x: 30 + CGFloat(i) * (SCREENWIDTH - 60) / 7, y: 90, width: 40, height: 20))
            numberLabel1.textAlignment = .center
            numberLabel1.font = App_Theme_PinFan_M_10_Font
            numberLabel1.textColor = App_Theme_B5B5B5_Color
            numberLabel1.text = "\(i + 1)天"
            dailyView.addSubview(numberLabel1)
        }
        
        return dailyView
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
