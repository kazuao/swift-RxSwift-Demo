import Foundation
import RxSwift
import PlaygroundSupport

let disposeBag = DisposeBag()

// 条件が満たされるまで取得する
Observable.of(2,4,6,7,8,10)
    .take(while: { $0 % 2 == 0 })
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
// 2,4,6
