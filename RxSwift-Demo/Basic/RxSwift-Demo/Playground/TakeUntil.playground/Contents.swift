import Foundation
import RxSwift
import PlaygroundSupport

let disposeBag = DisposeBag()

// 条件が満たされるまでスキップする
// 条件が満たされたあとは、停止する
let subject = PublishSubject<String>()
let trigger = PublishSubject<String>()

subject.take(until: trigger)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

subject.onNext("A")
subject.onNext("B")

trigger.onNext("X") // triggerを引く

subject.onNext("C") // ここから呼ばれる
// A,B
