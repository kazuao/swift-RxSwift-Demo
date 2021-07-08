import Foundation
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// 二つのObservableを結合できる
let first = Observable.of(1,2,3)
let second = Observable.of(9,8,7)

let observable = Observable.concat([first, second])

observable
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
// 1,2,3,9,8,7
