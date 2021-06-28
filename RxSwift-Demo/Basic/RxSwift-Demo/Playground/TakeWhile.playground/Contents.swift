import Foundation
import RxSwift
import PlaygroundSupport

let disposeBag = DisposeBag()

// 条件が満たされるまで出力する
// 条件が満たされたあとは、通常通り動作する
Observable.of(2,2,3,4,4)
    .skip(while: { $0 % 2 == 0 })
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
// 3,4,4
 
