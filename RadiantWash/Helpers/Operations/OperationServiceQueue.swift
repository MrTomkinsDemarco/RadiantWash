//
//  OperationServiceQueue.swift
//  RadiantWash
//
//  Created by Mac Mini on 19.02.2023.
//

import Foundation

class OperationServiceQueue: OperationQueue {
  
  override init() {
    super.init()
    qualityOfService = .background
    
    maxConcurrentOperationCount = 10
  }
  
  override public func addOperation(_ operation: Operation) {
    let lastIndex = operations.count - 1
    
    if operations.count > 1 {
      for i in 0..<operations.count {
        if !operations[i].isCancelled && i != lastIndex {
          operations[i].cancel()
        }
      }
    }
    super.addOperation(operation)
  }
}
