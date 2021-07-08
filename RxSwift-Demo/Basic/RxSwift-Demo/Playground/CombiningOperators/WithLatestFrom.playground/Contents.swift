import Foundation
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// 発火のイベントを待って、最新の値を出力する
let button = PublishSubject<Void>()
let textField = PublishSubject<String>()

let observable = button.withLatestFrom(textField)
let disposable = observable.subscribe(onNext: {
    print($0)
})

textField.onNext("Swi")
textField.onNext("Swif")
textField.onNext("Swift")

button.onNext(()) // Swift
button.onNext(()) // Swift

// buttonを押して際に最新を取得するので、
// 常に最新の値で処理を行える


