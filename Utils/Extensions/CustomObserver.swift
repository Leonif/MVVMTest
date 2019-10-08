public class Observer<A> {
  
  public var update: ((_ value: A) -> Void)? = nil
  
  public init() {}
  
  public func notify(value: A) {
    update?(value)
  }
}

public class Subject<Value> {
  private var observers: [Observer<Value>] = []
  public var value: Value? = nil {
    didSet { notify() }
  }
  
  public var isHasSubscribers: Bool {
    return !observers.isEmpty
  }
  
  public static func create(_ s : (Subject<Value>) -> Void) -> Subject<Value> {
    let subject = Subject<Value>()
    s(subject)
    return subject
  }
  
  public init() {
  
  }
  
  public init(state: Value) {
    value = state
  }
  
  @discardableResult
  public func subscribe(_ observer: Observer<Value> = Observer()) -> Observer<Value> {
    observers.append(observer)
    return observer
  }
  
  
  public func subscribe(_ observer: Observer<Value> = Observer(), completed: @escaping (Value) -> Void) {
    observers.append(observer)
    observer.update = { val in
      completed(val)
    }
  }
  
  private func notify() {
    guard let value = value else { return }
    
    if !isHasSubscribers {
      DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(1)) {
        self.observers.forEach { $0.notify(value: value) }
      }
    } else {
      observers.forEach { $0.notify(value: value)}
    }
  }
  
  public func unsubscribeAll() { observers.removeAll() }
}


class Variable<Value> {
  
  var update: ((_ value: Value) -> Void)? = nil
  var value: Value? = nil { didSet { notify() } }
  
  func notify() {
    guard let value = value else { return }
    update?(value)
  }
}
