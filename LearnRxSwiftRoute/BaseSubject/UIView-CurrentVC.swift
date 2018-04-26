//
//  UIView-CurrentVC.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/4/25.
//  Copyright © 2018年 张江. All rights reserved.
//

import Foundation
import UIKit

    
extension UIView {
    
    func findController() -> UIViewController! {
        return self.findControllerWithClass(UIViewController.self)
    }
    
    func findNavigator() -> UINavigationController! {
        return self.findControllerWithClass(UINavigationController.self)
    }
    
    /// 处理泛型 获取当前的视图控制器或者导航栏控制器
    ///
    /// - Parameter clzz: 泛型 控制器或者导航栏
    /// - Returns: viewController或者navigationController
    func findControllerWithClass<T>(_ clzz: AnyClass) -> T? {
        var responder = self.next
        while(responder != nil) {
            if (responder!.isKind(of: clzz)) {
                return responder as? T
            }
            responder = responder?.next
        }
        return nil
    }
}


