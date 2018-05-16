//
//  ZJRequestForm.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/5/15.
//  Copyright © 2018年 张江. All rights reserved.
//

import Foundation
import Alamofire

//MARK:request请求体参数
protocol RequestFormConvertible {
    var url : URLConvertible { get }
    var method : HTTPMethod { get }
    var parameters : Parameters? { get }
    var encoding : ParameterEncoding { get }
    var header :HTTPHeaders? { get }
    ///显示指示器
    var hud:Bool? {get}
    
}

struct RequestForm : RequestFormConvertible{
    
    var url : URLConvertible
    var method : HTTPMethod = .get
    var parameters : Parameters?
    var encoding : ParameterEncoding = URLEncoding.default
    var header : HTTPHeaders?
    var hud: Bool?
    
    
    //添加默认值
    static var defaultHeaders:HTTPHeaders {
        get{
            let alamofireHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//            if let token == "12345" {
//                //添加参数
//                alamofireHeaders["token"] = token;
//            }
            return alamofireHeaders
        }
    }
    
    /// 便利构造
    init(url:URLConvertible,method:HTTPMethod,parameters:Parameters?,encoding:ParameterEncoding,header:HTTPHeaders?,hud:Bool?) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.encoding = encoding
        self.header = header ?? RequestForm.defaultHeaders
        self.hud = hud
    }
    
    /// encoding 为JSON
    static func jsonRequest(_ url:URLConvertible,method:HTTPMethod,parameters:Parameters? = nil,header:HTTPHeaders? = nil,hud:Bool? = false) -> RequestForm {
        return self.init(url: url, method: method, parameters: parameters, encoding: JSONEncoding.default, header:header,hud: hud)
    }
    
    /// get请求 编码默认为JSON
    static func getRequest(_ url:URLConvertible,parameters:Parameters? = nil,header:HTTPHeaders? = nil,hud:Bool? = false) -> RequestForm {
        return self.init(url: url, method: .get, parameters: parameters, encoding: JSONEncoding.default, header:header,hud: hud)
    }
    /// post请求 编码默认为JSON
    static func postRequest(_ url:URLConvertible,parameters:Parameters? = nil,header:HTTPHeaders? = nil,hud:Bool? = false) -> RequestForm {
        return self.init(url: url, method: .post, parameters: parameters, encoding: JSONEncoding.default, header:header,hud: hud)
    }
}
