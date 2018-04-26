//
//  ZJPhotoWrite.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/4/24.
//  Copyright © 2018年 张江. All rights reserved.
//

import UIKit
import RxSwift


class ZJPhotoWrite {
    
    typealias CallBack = (NSError?)->()
    
    private var callBack:CallBack
    private init(callBack:@escaping CallBack) {
        self.callBack = callBack
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?,
               contextInfo: UnsafeRawPointer) {
        callBack(error!)
    }
    
    static func saveImage(image:UIImage?) -> Observable<Void>{
        return Observable.create({ (observer) -> Disposable in
            let writer = ZJPhotoWrite(callBack: { (error) in
                if let error1:NSError = error{
                    observer.onError(error1)
                }else{
                    observer.onCompleted()
                }
            })
            UIImageWriteToSavedPhotosAlbum(image!, writer, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            
            return Disposables.create()
        })
    }
}
