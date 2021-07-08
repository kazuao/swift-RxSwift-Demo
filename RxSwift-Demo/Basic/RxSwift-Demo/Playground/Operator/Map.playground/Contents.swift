import Foundation
import RxSwift

let disposeBag = DisposeBag()

// すべての数値にアクセスする
Observable.of(1,2,3,4,5)
    .map { $0 * 2 }
    .subscribe(onNext: {
        print($0) // 2,4,6,8,10
    }).disposed(by: disposeBag)
 
