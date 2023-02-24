//
//  DeepCleanSelectableAssetsDelegate.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation
import Photos

protocol DeepCleanSelectableAssetsDelegate: AnyObject {
   
   func didSelect(assetsListIds: [String], contentType: PhotoMediaType, updatableGroup: [PhassetGroup], updatableAssets: [PHAsset], updatableContactsGroup: [ContactsGroup])
}
