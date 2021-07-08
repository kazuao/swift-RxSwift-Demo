import Foundation
import RxSwift

let disposeBag = DisposeBag()

// 中身は空でいい
let subject = PublishSubject<String>()

//subject.onNext("Issue 1") // 呼ばれない

subject.subscribe { event in
    print(event) // subscribe前に`onNext`したものは購読されない
    // Issus 2
}

subject.onNext("Issus 2")
subject.onNext("Issus 3")

//subject.dispose()
//subject.onNext("Issus 4") // disposeのあとは呼ばれない

//subject.onCompleted()
//subject.onNext("Issus 5") // onCompletedのあとは呼ばれない
