//
//  ZJOperateViewController.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/4/25.
//  Copyright © 2018年 张江. All rights reserved.
//

import UIKit
import Photos
import RxSwift
import RxCocoa


class ZJOperateViewController: ZJBaseViewController {

    @IBOutlet weak var cityNameField: UITextField!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var shiduLabel: UILabel!
    
    @IBOutlet weak var showImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
    }
    
    //测试蓝牙功能
    func testMyBlueTooth()  {
//        let manager = CentralManager(queue: .main)
//        manager.scanForPeripherals(withServices: serviceIds)
//            .subscribe(onNext: { scannedPeripheral in
//                let advertisementData = scannedPeripheral.advertisementData
//            })

    }
    
    ///设置显示的内容
    func setOrignalWeather() {
        APIWeather.share
            .currentWeather("shanghai")
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self](model) in
                print(model)
                self?.tempLabel.text = "\(model.temp)° C"
                self?.shiduLabel.text = "\(model.humidity)%"
            }).disposed(by: disposeBag)
        
        //绑定输入框
        let textInput = cityNameField.rx.text.orEmpty
            .filter{ $0.count > 0}
            .flatMap { (city) in
                return APIWeather.share.currentWeather(city)
            }.observeOn(MainScheduler.instance)
            .share(replay: 1)
        
        textInput.map { "\($0.temp)° C"}.bind(to: self.tempLabel.rx.text).disposed(by: disposeBag)
        textInput.map { "\($0.humidity)%"}.bind(to: self.shiduLabel.rx.text).disposed(by: disposeBag)

    }
    
    /// 获取权限
    func authorRequest()  {
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
    
    
    /// 请求显示数据
    func requestMyGithubData() {
        
        
//        let form = 
        
        let response = Observable.from(["ReactiveX/RxSwift"])
            .map { urlString -> URL in
                return URL(string: "https://api.github.com/repos/\(urlString)/events")!}
            .map { (url) -> URLRequest in
                return URLRequest.init(url:url )}
            .flatMap { (request) in
                return URLSession.shared.rx.response(request: request)
            }.share(replay: 1)
        
        response.filter { (response,data) -> Bool in
            return 200..<300 ~= response.statusCode
            }.map { (response,data) -> [[String:Any]] in
                
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),let result = jsonObject as? [[String:Any]] else {
                    return []
                    
                }
                return result
            }.filter { (count) -> Bool in
                return count.count > 0
            }.subscribe(onNext: { (objects) in
                print("返回的请求信息===%@",objects)
            }).disposed(by: disposeBag)
    }
}
