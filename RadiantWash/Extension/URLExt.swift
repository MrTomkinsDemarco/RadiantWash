//
//  URLExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

extension URL {
  
  var attributes: [FileAttributeKey : Any]? {
    do {
      return try FileManager.default.attributesOfItem(atPath: path)
    } catch let error as NSError {
      print("FileAttribute error: \(error)")
    }
    return nil
  }
  
  var fileSize: UInt64 {
    return attributes?[.size] as? UInt64 ?? UInt64(0)
  }
}
