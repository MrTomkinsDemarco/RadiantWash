//
//  AVURLAssetExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import AVFoundation

extension AVURLAsset {
  
  var fileSize: Int? {
    let keys: Set<URLResourceKey> = [.totalFileSizeKey, .fileSizeKey]
    let resourceValues = try? url.resourceValues(forKeys: keys)

    return resourceValues?.fileSize ?? resourceValues?.totalFileSize
  }
}
