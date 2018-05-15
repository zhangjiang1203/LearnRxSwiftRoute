//
//  RxHandyJSON.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/5/4.
//  Copyright © 2018年 张江. All rights reserved.
//

import Foundation
import RxSwift
import HandyJSON
import ObjectMapper

fileprivate enum RxObjectMapperError : Error{
    case parsingError
}

//MARK: json转模型的映射
extension Observable where Element : Any{
    
    func mapObject<T>(type:T.Type) -> Observable<T> where T :HandyJSON  {
        
        return self.map { (element) -> T in
            guard let mapperElement = JSONDeserializer<T>.deserializeFrom(dict: element as? [String:Any]) else {
                throw RxObjectMapperError.parsingError
            }
            return mapperElement
        }
    }
    
    //MARK:JSON转数组
    func mapperArray<T>(type:T.Type) -> Observable<[T]> where T:HandyJSON {
        return self.map({ (element) -> [T] in
            guard let arrayElement =         JSONDeserializer<T>.deserializeModelArrayFrom(json: element as? String) else {
                throw RxObjectMapperError.parsingError
            }
            return arrayElement as! [T]
        })
        
    }
}
