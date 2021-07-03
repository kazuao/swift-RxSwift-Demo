import Foundation
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

struct Student {
    var score: BehaviorRelay<Int>
}

let john = Student(score: BehaviorRelay(value: 75))
let mary = Student(score: BehaviorRelay(value: 95))

let student = PublishSubject<Student>()

student.asObservable()
    .flatMapLatest { $0.score.asObservable() }
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

student.onNext(john)
john.score.accept(100)

student.onNext(mary) // 最後に登録したもののみ追跡する
mary.score.accept(80)

john.score.accept(43) // 出力されない
