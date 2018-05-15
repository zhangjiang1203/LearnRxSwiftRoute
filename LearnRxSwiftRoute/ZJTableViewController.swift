//
//  ZJTableViewController.swift
//  LearnRxSwiftRoute
//
//  Created by zitang on 2018/5/3.
//  Copyright © 2018年 张江. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxAlamofire
import RxDataSources
import MJRefresh

class ZJTableViewController: ZJBaseViewController {

    var myTableView :UITableView?
    let pickerView = UIPickerView()
    
    //定义一个pickerView的接受者
    let pickerAdapter = RxPickerViewStringAdapter<[String]>(
        components: [],
        numberOfComponents:{ _,_,_  in 1},
        numberOfRowsInComponent:{ _,_,items,_ in
            return items.count
            },
        titleForRow: {(_,_,items,row,_) -> String? in
            return items[row]
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setMyTableView()
        
//        addPickerView()
//        alamofireRequestTest()
    }
    
    //MARK:添加显示的pickerView
    func addPickerView()  {
        let width = UIScreen.main.bounds.size.width
        
        pickerView.frame = CGRect.init(x: 0, y: 64, width: width, height: 200)
        self.view.addSubview(pickerView)
        
        //添加显示的数据
        Observable.just(["zhang","wang","li","zhao"])
            .bind(to: pickerView.rx.items(adapter: pickerAdapter))
            .disposed(by: disposeBag)
        //pickview的滚动选中事件订阅
        pickerView.rx.itemSelected.asDriver().drive(onNext: { (row,component) in
            print("开始选中==\(row)===\(component)")
        }).disposed(by: disposeBag)
    }
    
    func alamofireRequestTest()  {
        
        let request = RequestForm.getRequest("", parameters: nil, header: nil);
        ZJRxAlamofire.request(requestBody: request)
        
        //创建URL对象
//        let urlString = "https://www.douban.com/j/app/radio/channels"
//        let url = URL(string:urlString)
//        //创建请求对象
//        let request = URLRequest(url: url!)
        
        //获取列表数据
//        URLSession.shared.rx.json(request: request)
//            .mapObject(type: DouBanModel.self)
//            .subscribe(onNext: { (model) in
//                model.channels.map({ (channnel) in
//                    print(channnel.description)
//                })
//            }).disposed(by: disposeBag)

//        requestJSON(.get, url!)
//            .map({$1})
//            .mapObject(type:DouBanModel.self)
//            .subscribe(onNext: { (model) in
//                print(model)
//            }).disposed(by: disposeBag)
        
//        json(.get, url!)
////            .map({$0})
//            .mapObject(type:DouBanModel.self)
//            .subscribe(onNext: { (model) in
//                print(model)
//            }).disposed(by: disposeBag)

    }
    
    func setMyTableView() {
        self.myTableView = UITableView.init(frame: self.view.bounds, style: .plain)
        self.myTableView?.backgroundColor = UIColor.white
        self.myTableView?.register(UITableViewCell.self, forCellReuseIdentifier: "systemCell")
        self.myTableView?.showsVerticalScrollIndicator = false
        self.myTableView?.showsHorizontalScrollIndicator = false
        self.view.addSubview(self.myTableView!)
        
        //设置头部刷新控件
        myTableView?.mj_header = MJRefreshNormalHeader()
        
        //初始化ViewModel
        let viewModel = ZJShowDataModel.init(headerRefresh: (self.myTableView?.mj_header.rx.refreshing.asDriver())!)
        
        
        viewModel.tableData
            .drive((myTableView?.rx.items)!){ (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "systemCell")!
                cell.textLabel?.text = "\(row+1)、\(element)"
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.endHeaderRefresh.drive(onNext: { (refresh) in
            self.myTableView?.mj_header.endRefreshing()
        }).disposed(by: disposeBag)
        
//        viewModel.endHeaderRefresh
//            .drive(self.myTableView?.mj_header.rx.endRefreshing)
    }

}

extension Reactive where Base : UILabel {
    //MARK: 添加对UILabel的字体大小修改的属性
    public var fontSize:Binder<CGFloat> {
        return Binder(self.base){ label,fontsize in
            label.font = UIFont.systemFont(ofSize: fontsize)
        }
    }
}


extension ZJTableViewController{
    //获取随机数据
    func getRandomResult() -> Driver<[String]> {
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

























