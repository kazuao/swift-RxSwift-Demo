import Foundation
import RxSwift
import PlaygroundSupport

let disposeBag = DisposeBag()

// 指定の数分、スキップする
Observable.of("A", "B", "C", "D", "E", "F")
    .skip(3)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
// D, E, F
