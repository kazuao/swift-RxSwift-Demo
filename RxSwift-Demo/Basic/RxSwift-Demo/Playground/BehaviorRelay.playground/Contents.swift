import Foundation
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

let relay = BehaviorRelay(value: "Initial Value")

relay.asObservable().subscribe {
    print($0)
}

// valueを書き換える
// relay.valueはgetterなので、置き換えできない
relay.accept("Hello World")

let relay2 = BehaviorRelay(value: ["Item 0"])

relay2.asObservable().subscribe {
    print($0)
}

// 文字列と同じように書き換えると上書きになってしまう
//relay2.accept(["Item 1"])

// 追加方法1: +で追加
relay2.accept(relay2.value + ["Item 2"])
// ["Item 0", "Item 2"]

// 追加方法2: 一度変数に待避する
var value = relay2.value
value.append("Item 3")
value.append("Item 4")
relay2.accept(value)
// ["Item 0", "Item 2", "Item 3", "Item 4"]
