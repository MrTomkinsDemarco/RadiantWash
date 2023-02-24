//
//  AtomicQueue.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

@propertyWrapper
class Atomic<Value> {
  private let queue = DispatchQueue(label: "Atomic serial queue", attributes: .concurrent)
  
  private var _value: Value
  
  init(wrappedValue value: Value) {
    self._value = value
  }
  
  var wrappedValue: Value {
    get { return queue.sync { _value } }
    set { queue.async(flags: .barrier) { self._value = newValue } }
  }
}
