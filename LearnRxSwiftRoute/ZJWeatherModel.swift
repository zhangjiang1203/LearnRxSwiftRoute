//
//  ZJWeatherModel.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/4/28.
//  Copyright © 2018年 张江. All rights reserved.
//

import UIKit
import RxSwift

private let weatherKey = "aef56cb6b267ba31763b60a83bfb1daf"
var apiInstance:APIWeather = APIWeather()

struct ZJWeatherModel {

    var cityName :String
    var temp:Int
    var icon:String
    var humidity:Int
    
    }

class APIWeather {
    
    class var share : APIWeather {
        return apiInstance
    }

    
    ///获取当前的天气
    func currentWeather(_ cityName:String) -> Observable<ZJWeatherModel>  {
        return Observable.just(
            ZJWeatherModel(
                cityName: "shanghai",
                temp: 23,
                icon:"http://www.baidu.com/",
                humidity:90
            )
        )
    }
    

}
