import Foundation
import RxSwift
import PlaygroundSupport

let disposeBag = DisposeBag()

// triggerが引かれるまで、動作しない
let subject = PublishSubject<String>()
let trigger = PublishSubject<String>()

subject.skip(until: trigger)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

subject.onNext("A")
subject.onNext("B")

trigger.onNext("X") // triggerを引く

subject.onNext("C") // ここから呼ばれる
// C
