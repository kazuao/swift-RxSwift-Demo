import Foundation
import RxSwift

// subscribeの破棄用
let disposeBag = DisposeBag()

// ざっくりなdisposeBagの使い方
//Observable.of("A", "B", "C").subscribe {
//    print($0)
//}.disposed(by: disposeBag)

// 作成関数
Observable<String>.create { observer in
    
    observer.onNext("A")   // onbservableに値を追加する
    observer.onCompleted() // observableへの変更を完了する
    observer.onNext("?")   // `onCompleted`のあとに`onNext`を定義しても呼ばれない
    
    return Disposables.create() // 必ず呼ぶ
    
// subscribeする、各項目はそこに入ったときの処理
}.subscribe(onNext: { print($0) },
            onError: { print($0) },
            onCompleted: { print("Completed") },
            onDisposed: { print("Disposed") }
            
// 最後に破棄する
).disposed(by: disposeBag)
 
