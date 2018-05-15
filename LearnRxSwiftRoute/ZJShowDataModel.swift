//
//  ZJShowDataModel.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/5/4.
//  Copyright © 2018年 张江. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ZJShowDataModel {
    
    let tableData :Driver<[String]>
    let endHeaderRefresh : Driver<Bool>
    
    init(headerRefresh:Driver<Void>) {
        
        self.tableData = headerRefresh.startWith(())
            .flatMapLatest({_ in NetworkService.getRandomResult() })
        
        self.endHeaderRefresh = self.tableData.map({ _ in true })
    }
    
}


//网络请求服务
class NetworkService {
    
    //获取随机数据
    class func getRandomResult() -> Driver<[String]> {
        print("正在请求数据......")
        let items = (0 ..< 15).map {_ in
            "随机数据\(Int(arc4random()))"
        }
        let observable = Observable.just(items)
        return observable
            .delay(1, scheduler: MainScheduler.instance)
            .asDriver(onErrorDriveWith: Driver.empty())
    }
}
