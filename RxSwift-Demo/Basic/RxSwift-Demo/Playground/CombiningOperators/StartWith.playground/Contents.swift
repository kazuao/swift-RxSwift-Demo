import Foundation
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// 開始したい数値を指定できる
let numbers = Observable.of(2,4,3)

let observable = numbers.startWith(1)

observable
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
// 1,2,4,3


