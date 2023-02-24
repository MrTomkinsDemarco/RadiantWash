//
//  PHAssetExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Photos

extension PHAsset {
  
  var imageSize: Int64 {
    
    let resources = PHAssetResource.assetResources(for: self)
    var fileDiskSpace: Int64 = 0
    
    if let resource = resources.first {
      if let unsignedInt64 = resource.value(forKey: "fileSize") as? CLong {
        fileDiskSpace = Int64(bitPattern: UInt64(unsignedInt64))
      }
    }
    return fileDiskSpace
  }
  
  func getPhassetURL(completionHandler: @escaping ((_ responseURL: URL?) -> Void)) {
    
    switch self.mediaType {
    case .image:
      let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
      options.canHandleAdjustmentData = { (photoAdjustmentData: PHAdjustmentData) -> Bool in
        return true
      }
      
      self.requestContentEditingInput(with: options) { contentEditingInput, info in
        completionHandler(contentEditingInput?.fullSizeImageURL as URL?)
      }
    case .video:
      let options: PHVideoRequestOptions = PHVideoRequestOptions()
      options.version = .original
      PHImageManager.default().requestAVAsset(forVideo: self, options: options) { asset, audioMix, info in
        if let urlAsset = asset as? AVURLAsset {
          let assetURL: URL = urlAsset.url as URL
          completionHandler(assetURL)
        } else {
          completionHandler(nil)
        }
      }
    default:
      completionHandler(nil)
    }
  }
  
  var isPortrait: Bool {
    
    if let image = self.getImage {
      return image.size.height > image.size.width
    } else {
      return self.pixelHeight > self.pixelHeight
    }
  }
}
