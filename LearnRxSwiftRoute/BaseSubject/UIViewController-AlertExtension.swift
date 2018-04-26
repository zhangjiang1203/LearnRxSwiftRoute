//
//  UIViewController-AlertExtension.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/4/24.
//  Copyright © 2018年 张江. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

extension UIViewController {
     func show(message:String,title:String) -> Observable<NSInteger>{
        return Observable.create({ (observer) in
            //添加alert
            let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            let dismissAc = UIAlertAction.init(title: "确定", style: .default, handler: { (alert) in
                observer.onNext(1)
            })
            alertVC.addAction(dismissAc)
            self.present(alertVC, animated: true, completion: nil)
            return Disposables.create()
        })
    }
}

extension UIViewController {
    
    /// 获取当前的视图控制器
    func getCurrentViewController() {
        
    }
}
