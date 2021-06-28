import Foundation
import RxSwift
import PlaygroundSupport

let disposeBag = DisposeBag()

// Observerの中の先頭から指定の数取り出す
Observable.of(1,2,3,4,5,6)
    .take(3)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
// 1,2,3
