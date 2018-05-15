//
//  DouBanModel.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/5/4.
//  Copyright © 2018年 张江. All rights reserved.
//

import Foundation
import HandyJSON

struct DouBanModel:HandyJSON {
    
    var channels = [Channel]()
    
}

struct Channel:HandyJSON {
    var name: String = ""
    var name_en:String = ""
    var channel_id: String = ""
    var seq_id: Int = 0
    var abbr_en: String = ""
}

extension Channel: CustomStringConvertible {
    var description: String {
        return "{" + "\n" + "name:" + name + "," + "\n" + "name_en:" + name_en + "," + "\n" + "channel_id:" + channel_id + "," + "\n" + "seq_id:" + "\(seq_id)" + "," + "\n" + "abbr_en:" + abbr_en + "\n" + "}"
    }
}

