/*:
 > # IMPORTANT: To use **Rx.playground**:
 1. Open **Rx.xcworkspace**.
 1. Build the **RxSwift-macOS** scheme (**Product** → **Build**).
 1. Open **Rx** playground in the **Project navigator**.
 1. Show the Debug Area (**View** → **Debug Area** → **Show Debug Area**).
 ----
 [Previous](@previous) - [Table of Contents](Table_of_Contents)
 */
import RxSwift
/*:
 # Mathematical and Aggregate Operators
 Operators that operate on the entire sequence of items emitted by an `Observable`.
 ## `toArray`
 Converts an `Observable` sequence into an array, emits that array as a new single-element `Observable` sequence, and then terminates. [More info](http://reactivex.io/documentation/operators/to.html)
 ![](http://reactivex.io/documentation/operators/images/to.c.png)
 */
example("toArray") {
    let disposeBag = DisposeBag()
    
    Observable.range(start: 1, count: 10)
        .toArray()
        .subscribe { print($0) }
        .addDisposableTo(disposeBag)
}
/*:
 ----
 ## `reduce`
 Begins with an initial seed value, and then applies an accumulator closure to all elements emitted by an `Observable` sequence, and returns the aggregate result as a single-element `Observable` sequence. [More info](http://reactivex.io/documentation/operators/reduce.html)
 ![](https://raw.githubusercontent.com/kzaher/rxswiftcontent/master/MarbleDiagrams/png/reduce.png)
 */
example("reduce") {
    let disposeBag = DisposeBag()
    
    Observable.of(10, 100, 1000)
        .reduce(1, accumulator: +)
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}
/*:
 ----
 ## `concat`
 Joins elements from inner `Observable` sequences of an `Observable` sequence in a sequential manner, waiting for each sequence to terminate successfully before emitting elements from the next sequence. [More info](http://reactivex.io/documentation/operators/concat.html)
 ![](https://raw.githubusercontent.com/kzaher/rxswiftcontent/master/MarbleDiagrams/png/concat.png)
 */
example("concat") {
    let disposeBag = DisposeBag()
    
    let subject1 = BehaviorSubject(value: "🍎")
    let subject2 = BehaviorSubject(value: "🐶")
    
    let variable = Variable(subject1)
    
    variable.asObservable()
        .concat()
        .subscribe { print($0) }
        .addDisposableTo(disposeBag)
    
    subject1.onNext("🍐")
    subject1.onNext("🍊")
    
    variable.value = subject2
    
    subject2.onNext("I would be ignored")
    // 第一个subject的onCompleted调用前的 另一个 subject 的值会被当做初始值
    subject2.onNext("这个会不会被忽略掉呢？")
    subject1.onCompleted()
    subject2.onNext("🐱")
    
    
    
    subject2.onNext("🐭")
}

//: [Next](@next) - [Table of Contents](Table_of_Contents)
