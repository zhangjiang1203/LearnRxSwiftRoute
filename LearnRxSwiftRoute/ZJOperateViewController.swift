//
//  ZJOperateViewController.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/4/25.
//  Copyright © 2018年 张江. All rights reserved.
//

import UIKit
import Photos

class ZJOperateViewController: ZJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let authorized = PHPhotoLibrary.authorized.share()
        authorized
            .skipWhile{$0 == false}
            .take(1)
            .subscribe(onNext: { _ in
                print("获取了相册的权限")
            }).disposed(by: disposeBag)
        
        authorized
            .skip(1)
            .filter{$0 == false}
            .takeLast(1)
            .subscribe(onNext: { (_) in
              print("获取权限之后")
            }).disposed(by: disposeBag)
    }
}
