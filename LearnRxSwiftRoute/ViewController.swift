//
//  ViewController.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/4/24.
//  Copyright © 2018年 zitang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: ZJBaseViewController {

    @IBOutlet weak var myHeaderImageView: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    private let images = Variable<[UIImage]>([])
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMyLateUI()
        
}
    
    
    func setUpMyLateUI()  {
//        self.show(message: "现在开始点击我", title: "提示")
//            .take(5.0, scheduler: MainScheduler.instance)
//            .subscribe(onNext: { (index) in
//            print("点击了确定按钮" + "\(index)")
//        }).disposed(by: disposeBag)
        
        clearBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in
            //跳转到操作符操作界面
                print("开始操作清除按钮")
                
//                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//                let operateVC = storyBoard.instantiateViewController(withIdentifier: "ZJOperateViewController") as! ZJOperateViewController
//                operateVC.title = "操作符"
//                self?.navigationController?.pushViewController(operateVC, animated: true)
                let tableVC = ZJTableViewController()
                self?.navigationController?.pushViewController(tableVC, animated: true)
            
        }).disposed(by: disposeBag)
        
        saveBtn.rx.tap.subscribe(onNext: { [weak self]_ in
            //保存图片
            guard let image = self?.myHeaderImageView.image else {return}
            ZJPhotoWrite.saveImage(image:image).asObservable().subscribe(onError: { (error) in
                print("保存文件失败" + error.localizedDescription)
            }, onCompleted: {
                print("保存文件成功")
            }).disposed(by: (self?.disposeBag)!)
        }).disposed(by: disposeBag)
    }
    
    
    @IBAction func pushMyNextViewController(_ sender: UIBarButtonItem) {
    
        let addVC = storyboard?.instantiateViewController(withIdentifier: "addPhotoVC") as! ZJAddPhotoViewController
        addVC.selectPhoto.subscribe(onNext: { (showStr) in
            print("代理传回来的信息" + showStr)
        }, onCompleted: {
            print("完成释放")
        }).disposed(by: disposeBag)
        navigationController?.pushViewController(addVC, animated: true)
    }
}

