import Foundation
import RxSwift

let disposeBag = DisposeBag()

// 配列に変換し、取得する
Observable.of(1,2,3,4,5)
    .toArray()
    // toArrayの場合は[onNext:]が使えず、
    // [onSuccess:]でハンドリングする
    .subscribe(onSuccess: {
        print($0) // [1,2,3,4,5]
    }).disposed(by: disposeBag)

