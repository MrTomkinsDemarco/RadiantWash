//
//  BenchTimer.swift
//  RadiantWash
//
//  Created by Mac Mini on 19.02.2023.
//

import CoreFoundation

class BenchTimer {
  
  let startTime: CFAbsoluteTime
  var endTime: CFAbsoluteTime?

  init() {
    startTime = CFAbsoluteTimeGetCurrent()
  }

  func stop() -> CFAbsoluteTime {
    endTime = CFAbsoluteTimeGetCurrent()

    return duration!
  }

  var duration: CFAbsoluteTime? {
    if let endTime = endTime {
      return endTime - startTime
    } else {
      return nil
    }
  }
}
