import Foundation
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// 二つのObservableを同時に監視し、
// 到着順に一つのObservableとして処理する
let left = PublishSubject<Int>()
let right = PublishSubject<Int>()

// あらかじめsourceとしてまとめておく
let source = Observable.of(left.asObserver(), right.asObserver())

// mergeする
let observable = source.merge()

observable
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

left.onNext(5)
right.onNext(7)
left.onNext(9)
left.onNext(1)
left.onNext(99)
// 5,7,9,1,99
