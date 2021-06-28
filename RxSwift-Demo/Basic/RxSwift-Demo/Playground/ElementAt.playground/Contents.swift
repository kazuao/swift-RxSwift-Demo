import Foundation
import RxSwift
import PlaygroundSupport

let disposeBag = DisposeBag()

// filterで操作できる
Observable.of(1,2,3,4,5,6,7)
    .filter { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
// 2,4,6
