import Foundation
import RxSwift

let disposeBag = DisposeBag()

// 初期値を設定できる
let subject = BehaviorSubject(value: "Initial Value")

// subscribe前にonNextを呼ぶと、Initial Valueが上書きされる
//subject.onNext("Last Issue")

subject.subscribe { event in
    print(event)
}

subject.onNext("Issue 1")


