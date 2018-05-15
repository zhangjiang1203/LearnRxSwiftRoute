//
//  ZJGetCurrentVC.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/4/25.
//  Copyright © 2018年 张江. All rights reserved.
//

import Foundation
import UIKit

protocol ZJGetCurrentVCProtocol {
    
    var target:UIView { get }
    
    func findController() -> UIViewController
  
    func findNavController() -> UINavigationController
    
}

extension ZJGetCurrentVCProtocol {
    
    /// 获取视图控制器
    ///
    /// - Returns: 返回视图控制器
    func findController() -> UIViewController{
        return self.findControllerWithClass(UIViewController.self)!
    }
    
    /// 获取当前导航控制器
    ///
    /// - Returns: 返回当前导航控制器
    func findNavController() -> UINavigationController
    {
        return self.findControllerWithClass(UINavigationController.self)!
    }
    
    /// 获取当前显示的控制器
    ///
    /// - Parameter class: 传入的类
    /// - Returns: 返回的控制器
    fileprivate func findControllerWithClass<T>(_ cls:AnyClass) -> T?{
        var responder = self.target.next
        while(responder != nil) {
            if (responder!.isKind(of: cls)) {
                return responder as? T
            }
            responder = responder?.next
        }
        return nil
    }
}


extension ZJGetCurrentVCProtocol where Self:UIView{
    var target: UIView {
        get{
            return self
        }
    }
}

extension ZJGetCurrentVCProtocol where Self:UIViewController{
    var target: UIView {
        get{
            return self.view
        }
    }
}

extension UIViewController:ZJGetCurrentVCProtocol{}

extension UIView:ZJGetCurrentVCProtocol{}
