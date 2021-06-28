import Foundation
import RxSwift

let strikes = PublishSubject<String>()

let disposeBag = DisposeBag()

// このタイミングでは呼ばれない
strikes.ignoreElements().subscribe { _ in
    print("[Subscription is called]")
}

// 呼ばれる
strikes.onNext("A")
strikes.onNext("B")
strikes.onNext("C")

// ここでようやく呼ばれる
strikes.onCompleted() // [Subscription is called]
