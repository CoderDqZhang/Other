//
//  UITapGestureRecognizer+Extention.swift
//  CatchMe
//
//  Created by Zhang on 20/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

typealias TapGestureRecognizerClouse = ()->Void

class UITapGestureRecognizerManager: NSObject {
    
    var tapGestureRecognizerClouse:TapGestureRecognizerClouse!
    
    override init() {
        super.init()
    }
    
    static let shareInstance = UITapGestureRecognizerManager()
    
    func initTapGestureRecognizer(tapGestureRecognizer:@escaping TapGestureRecognizerClouse) -> UITapGestureRecognizer{
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(UITapGestureRecognizerManager.tapSelector))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1

        self.tapGestureRecognizerClouse = tapGestureRecognizer
        return singleTap
    }

    @objc func tapSelector(){
        self.tapGestureRecognizerClouse()
    }
}
