//
//  PhassetGroup.swift
//  RadiantWash
//
//  Created by Mac Mini on 17.02.2023.
//

import Foundation
import Photos

class PhassetGroup {
  var name: String
  var assets: [PHAsset]
  var creationDate: Date?
  
  init(name: String, assets: [PHAsset], creationDate: Date?) {
    self.name = name
    self.assets = assets
    self.creationDate = creationDate
  }
}
