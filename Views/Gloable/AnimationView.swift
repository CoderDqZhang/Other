//
//  AnimationView.swift
//  CatchMe
//
//  Created by Zhang on 13/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import pop

class AnimationView: UIView {
}

typealias TouchClickClouse = () -> Void
class AnimationTouchView: UIView, UIGestureRecognizerDelegate {
    
    var touchClickClouse:TouchClickClouse!
    init(frame: CGRect, click:@escaping TouchClickClouse) {
        super.init(frame: frame)
        self.touchClickClouse = click
        let longPressGestureRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(self.longPress(longPress:)))
        longPressGestureRecognizer.delegate = self
        longPressGestureRecognizer.minimumPressDuration = 0.0001
        self.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func longPress(longPress:UILongPressGestureRecognizer) {
        if longPress.state == .began {
            self.scaleToSmall()
        }else if longPress.state == .ended {
            self.viewPress()
            self.touchClickClouse()
            self.scleToDefault()
        }
    }
    
    func scaleToSmall(){
        let scaleAnimation = POPBasicAnimation.init(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation?.duration = 0.00001
        scaleAnimation?.toValue = NSValue.init(cgSize: CGSize.init(width: 0.90, height: 0.90))
        self.layer.pop_add(scaleAnimation, forKey: "layerScaleSmallAnimation")
    }
    
    @objc func scalAnimation(){
        let scaleAnimation = POPSpringAnimation.init(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation?.velocity = NSValue.init(cgSize: CGSize.init(width: 3, height: 3))
        scaleAnimation?.toValue = NSValue.init(cgSize: CGSize.init(width: 1, height: 1))
        scaleAnimation?.springBounciness = 18
        scaleAnimation?.springSpeed = 20
        self.layer.pop_add(scaleAnimation, forKey: "layerScaleSpringAnimation")
    }
    
    func viewPress(){
        
    }
    
    func scleToDefault(){
        let scaleAnimation = POPBasicAnimation.init(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation?.toValue = NSValue.init(cgSize: CGSize.init(width: 1, height: 1))
        scaleAnimation?.duration = 0.1
        self.layer.pop_add(scaleAnimation, forKey: "layerScaleDefaultAnimation")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
}

class AnimationButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.adjustsImageWhenDisabled = false
        self.addTarget(self, action: #selector(self.scaleToSmall), for: [.touchDown, .touchDragEnter])
        self.addTarget(self, action: #selector(self.scalAnimation), for: .touchUpInside)
        self.addTarget(self, action: #selector(self.scleToDefault), for: .touchDragExit)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func scaleToSmall(){
        self.next?.becomeFirstResponder()
        let scaleAnimation = POPBasicAnimation.init(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation?.toValue = NSValue.init(cgSize: CGSize.init(width: 0.90, height: 0.90))
        scaleAnimation?.duration = 0.00001
        self.layer.pop_add(scaleAnimation, forKey: "layerScaleSmallAnimation")
    }
    
    @objc func scalAnimation(){
        self.next?.becomeFirstResponder()
        let scaleAnimation = POPSpringAnimation.init(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation?.velocity = NSValue.init(cgSize: CGSize.init(width: 3, height: 3))
        scaleAnimation?.toValue = NSValue.init(cgSize: CGSize.init(width: 1, height: 1))
        scaleAnimation?.springBounciness = 18
        scaleAnimation?.springSpeed = 200
        self.layer.pop_add(scaleAnimation, forKey: "layerScaleSpringAnimation")
    }
    
    @objc func scleToDefault(){
        self.next?.becomeFirstResponder()
        let scaleAnimation = POPBasicAnimation.init(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation?.toValue = NSValue.init(cgSize: CGSize.init(width: 1, height: 1))
        scaleAnimation?.duration = 0.00001
        self.layer.pop_add(scaleAnimation, forKey: "layerScaleDefaultAnimation")
    }
}
