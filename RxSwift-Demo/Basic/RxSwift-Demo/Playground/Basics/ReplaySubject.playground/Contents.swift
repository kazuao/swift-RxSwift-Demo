import Foundation
import RxSwift

let disposeBag = DisposeBag()

// 何回発行するかを定義できる
let subject = ReplaySubject<String>.create(bufferSize: 2)

subject.onNext("Issue 1")
subject.onNext("Issue 2")
subject.onNext("Issue 3")

// 登録した最後から数えて、bufferSizeの回数だけ出力する
subject.subscribe {
    print($0)
    // next("Issue 2"), next("Issue 3")
}

// その後に登録したものは順次出ていく
subject.onNext("Issue 4")
subject.onNext("Issue 5")
subject.onNext("Issue 6")

print("[Subscription 2]")

subject.subscribe {
    print($0)
    // next("Issue 5"), next("Issue 6")
}
