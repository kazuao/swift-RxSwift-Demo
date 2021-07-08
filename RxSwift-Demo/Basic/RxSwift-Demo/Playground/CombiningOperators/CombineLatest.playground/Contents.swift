import Foundation
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// 二つのObservableを同時に監視し、
// 両方の最新を常に処理する
let left = PublishSubject<Int>()
let right = PublishSubject<Int>()

// あらかじめ、最新が到着した際の処理を明記する
let observable = Observable
    .combineLatest(left, right, resultSelector: { lastLeft, lastRight in
        "\(lastLeft) : \(lastRight)"
    })

let disposable = observable
    .subscribe(onNext: { value in
        print(value)
    })
//    .disposed(by: disposable) // disposeBagはいらない 

left.onNext(45)
right.onNext(1)
left.onNext(30)
right.onNext(3)
right.onNext(2)
// 45 : 1
// 30 : 1
// 30 : 3
// 30 : 2
