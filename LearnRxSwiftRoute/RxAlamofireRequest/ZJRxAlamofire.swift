//
//  ZJRxAlamofire.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/5/15.
//  Copyright © 2018年 张江. All rights reserved.
//

import UIKit
import RxAlamofire
import RxSwift

class ZJRxAlamofire {

    ///网络请求
    static func request(requestBody:RequestFormConvertible) -> Observable<(HTTPURLResponse, Any)> {
        return requestJSON(requestBody.method, requestBody.url, parameters: requestBody.parameters, encoding: requestBody.encoding, headers: requestBody.header)
    }
    
    
}
