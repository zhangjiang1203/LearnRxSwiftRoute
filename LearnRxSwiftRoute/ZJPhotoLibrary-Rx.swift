//
//  ZJPhotoLibrary-Rx.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/4/25.
//  Copyright © 2018年 张江. All rights reserved.
//

import UIKit
import Photos
import RxSwift

//添加PHPhoto对权限的判断
extension  PHPhotoLibrary {
    static var authorized:Observable<Bool>{
        return Observable.create({ (observer) -> Disposable in
            DispatchQueue.main.async {
                if authorizationStatus() == .authorized{
                    observer.onNext(true)
                    observer.onCompleted()
                }else{
                    observer.onNext(false)
                    requestAuthorization({ (newState) in
                        observer.onNext(newState == .authorized)
                        observer.onCompleted()
                    })
                }
            }
            return Disposables.create()
        })
    }
}
