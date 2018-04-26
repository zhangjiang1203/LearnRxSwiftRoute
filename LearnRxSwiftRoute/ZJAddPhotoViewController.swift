//
//  ZJAddPhotoViewController.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/4/24.
//  Copyright © 2018年 张江. All rights reserved.
//

import UIKit
import RxSwift

class ZJAddPhotoViewController: ZJBaseViewController {
    @IBOutlet weak var changeBtn: UIButton!
    
    fileprivate let selectSubject = PublishSubject<String>()
    var selectPhoto:Observable<String> {
        return selectSubject.asObservable()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.selectSubject.onCompleted()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeBtn.rx.tap.subscribe(onNext: { [weak self](_) in
            //代理传值
            self?.selectSubject.onNext("nihao")
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
    }


}
