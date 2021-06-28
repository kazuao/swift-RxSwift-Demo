import Foundation
import RxSwift
import PlaygroundSupport

let strikes = PublishSubject<String>()
let disposeBag = DisposeBag()

// 引数2が存在したら動作する
strikes.element(at: 2).subscribe(onNext: { _ in
    print("You are Out!")
})

strikes.onNext("X")
strikes.onNext("X")
strikes.onNext("X")
