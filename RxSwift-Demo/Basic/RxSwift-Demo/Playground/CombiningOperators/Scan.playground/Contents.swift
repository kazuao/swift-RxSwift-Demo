import Foundation
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// 渡される値を利用し、都度処理をできる
// Reduceとの違いは、最終的な値を出すのではなく、
// 都度、値を出力する
let source = Observable.of(1,2,3,5,6)

source
    .scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
// 1,3,6,11,17


