//
//  SimpleSelectableAssetsDelegate.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation
import Photos

protocol SimpleSelectableAssetsDelegate: AnyObject {
  func didSelect(selectedIndexPath: [IndexPath], phasstsColledtion: [PHAsset])
}
