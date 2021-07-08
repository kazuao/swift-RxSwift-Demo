import Foundation
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// 渡される値を利用し処理ができる
let source = Observable.of(1,2,3)

// seed: 初期値
// accumulator: 処理の内容（四則演算？）
source.reduce(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
// 6

// 上と書き方違い
source
    .reduce(0, accumulator: { summary, newValue in
        return summary + newValue
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
