import Foundation
import RxSwift

// just: 値を一つ渡すのに向いている
// 一つの観測できる値
let observable = Observable.just(1)
 
// of: 値を複数渡す、もしくは配列ママ扱いたい場合に向いている
// 複数の観測できる値
let observable2 = Observable.of(1,2,3)

// 配列の観測できる値
let observable3 = Observable.of([1,2,3])

// from: 配列を渡し、複数の値として使用したいときに向いている
// 複数の観測できる値
let observable4 = Observable.from([1,2,3,4,5])

//observable3.subscribe { event in
////    print(event) // next([1, 2, 3])
//    if let element = event.element {
//        print(element)
//        // [1, 2, 3]
//    }
//}
//
//observable4.subscribe { event in
//    if let element = event.element {
//        print(element)
//        // 1, 2, 3, 4, 5
//    }
//}

// element直接出力できる
observable4.subscribe(onNext: { element in
    print(element)
})
