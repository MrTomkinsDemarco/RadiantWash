//
//  PhotoLibraryPermissions.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation
import Photos

class PhotoLibraryPermissions: Permission {
  
  override var permissionType: Permission.PermissionType {
    return .photolibrary
  }
  
  public override var status: Permission.Status {
    switch PHPhotoLibrary.authorizationStatus() {
      case .authorized:
        return .authorized
      case .denied:
        return .denied
      case .notDetermined:
        return .notDetermined
      case .restricted:
        return .denied
      case .limited:
        return .authorized
      default:
        return .denied
    }
  }
  
  public override func requestForPermission(completionHandler: @escaping (Bool, Error?) -> Void) {
    PHPhotoLibrary.requestAuthorization { status in
      DispatchQueue.main.async {
        completionHandler(status == .authorized, nil)
        SettingsManager.permissions.photoPermissionSavedValue = status == .authorized
      }
    }
  }
}
