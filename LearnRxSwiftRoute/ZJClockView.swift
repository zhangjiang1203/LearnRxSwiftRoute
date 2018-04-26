//
//  ZJClockView.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/4/25.
//  Copyright © 2018年 张江. All rights reserved.
//

import UIKit

class ZJClockView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        clockUI(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clockUI(frame:CGRect) {
        
        let hour = CALayer()
        hour.backgroundColor = UIColor.white.cgColor
        
        hour.frame = CGRect.init(x: 0, y: 0, width: 1, height: frame.size.height/2.0)
        hour.position = CGPoint.init(x: frame.size.width/2.0, y: frame.size.height/2.0)
        hour.anchorPoint = CGPoint.init(x: 1, y: 1)
        
        self.layer.addSublayer(hour)
        
        
    }

}
