//
//  CompressingSection.swift
//  RadiantWash
//
//  Created by Mac Mini on 17.02.2023.
//

import Foundation
import Photos

struct CompressingSection {
  
  let cells: [ComprssionModel]
  let headerTitle: String?
  let headerHeight: CGFloat?
  let compressingPHAsset: PHAsset?
  
  init(cells: [ComprssionModel], compressingPHAsset: PHAsset? = nil, headerTitle: String? = nil, headerHeight: CGFloat? = nil) {
    self.cells = cells
    self.compressingPHAsset = compressingPHAsset
    self.headerTitle = headerTitle
    self.headerHeight = headerHeight
  }
}
