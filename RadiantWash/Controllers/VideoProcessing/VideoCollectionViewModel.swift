//
//  VideoCollectionViewModel.swift
//  RadiantWash
//
//  Created by Mac Mini on 22.02.2023.
//

import Foundation
import Photos

class VideoCollectionViewModel {
  
  public let phassets: [PHAsset]
  
  init(phassets: [PHAsset]) {
    self.phassets = phassets
  }
  
  public func numberOfSection() -> Int {
    return 1
  }
  
  public func numberOfRows(at section: Int) -> Int {
    return phassets.count
  }
  
  public func getPhasset(at indexPath: IndexPath) -> PHAsset {
    return phassets[indexPath.row]
  }
}
