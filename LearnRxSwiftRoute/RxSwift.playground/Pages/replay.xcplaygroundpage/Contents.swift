//: Playground - noun: a place where people can play

import UIKit
import RxCocoa
import RxSwift


var str = "Hello, playground"
let dispose = DisposeBag()

Observable
    .of(1,2,3,4,5)
    .scan(0, accumulator: +)
    .subscribe(onNext: { (sum) in
        print(sum)
    })
    .disposed(by: dispose)

let numbers = Observable.of(2, 3, 4)
// 2
let observable = numbers.startWith(1)
observable.subscribe(onNext: { value in
    print(value)
}).disposed(by: dispose)
