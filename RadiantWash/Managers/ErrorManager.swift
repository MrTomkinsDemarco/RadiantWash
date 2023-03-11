//
//  ErrorManager.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import UIKit

class ErrorManager {
  
  static let shared: ErrorManager = {
    let instance = ErrorManager()
    return instance
  }()
  
  enum errorTitle: Error {
    case error
    case fatalError
    case attention
    case notice
    
    var rawValue: String {
      switch self {
      case .error:
        return Localization.ErrorsHandler.Title.error
      case .fatalError:
        return Localization.ErrorsHandler.Title.fatalError
      case .attention:
        return Localization.ErrorsHandler.Title.atention
      case .notice:
        return Localization.ErrorsHandler.Title.notice
      }
    }
  }
}

extension ErrorManager {
  
  enum NetworkError: Error {
    case networkError
    
    var alertDescription: AlertDescription {
      return LocalizationService.Alert.Networking.alertDescription(for: self)
    }
  }
  
  public func showNetworkErrorAlert(_ errorType: NetworkError, at viewController: UIViewController) {
    switch errorType {
    case .networkError:
      A.showNetworkError(with: errorType.alertDescription, at: viewController)
    }
  }
}

//  MARK: - Permission Access Restricted Errors -
extension ErrorManager {
  
  enum AccessRestrictedError: Error {
    case contactsRestrictedError
    case photoLibraryRestrictedError
    
    var alertDescription: AlertDescription {
      return LocalizationService.Alert.Permissions.restrictedPermissionDescription(for: self)
    }
  }
  
  public func showRestrictedErrorAlert(_ errorType: AccessRestrictedError, at viewController: UIViewController, completionHandler: @escaping () -> Void) {
    switch errorType {
    case .contactsRestrictedError:
      A.showPermissionAlert(of: .restrictedContacts, at: viewController)
      completionHandler()
    case .photoLibraryRestrictedError:
      A.showPermissionAlert(of: .restrictedPhotoLibrary, at: viewController)
      completionHandler()
    }
  }
}

//  MARK: - Empty Search Results Errors -
extension ErrorManager {
  
  enum EmptyResultsError: Error {
    case photoLibrararyIsEmpty
    case videoLibrararyIsEmpty
    case similarPhotoIsEmpty
    case duplicatedPhotoIsEmpty
    case screenShotsIsEmpty
    case similarSelfiesIsEmpty
    case photoWithLocationIsEmpty
    case livePhotoIsEmpty
    case similarLivePhotoIsEmpty
    case largeVideoIsEmpty
    case duplicatedVideoIsEmpty
    case similarVideoIsEmpty
    case screenRecordingIsEmpty
    case contactsIsEmpty
    case emptyContactsIsEmpty
    case duplicatedNamesIsEmpty
    case duplicatedNumbersIsEmpty
    case duplicatedEmailsIsEmpty
    case deepCleanResultsIsEmpty
  }
  
  public func showEmptySearchResultsFor(_ error: EmptyResultsError, completionHandler: (() -> Void)? = nil) {
    let errorDescription = LocalizationService.Errors.getEmptyErrorForKey(error)
    A.presentErrorAlert(with: errorDescription) {
      completionHandler?()
    }
  }
}

extension ErrorManager {
  
  enum ShareError: Error {
    case errorSavedFile
    case errorBackupFile
  }
}

extension ErrorManager {
  
  enum CompressionError: Error {
    case cantLoadFile
    case compressionFailed
    case resolutionIsBigger
    case errorSavedFile
    case noVideoFile
    case removeAudio
    case operationIsCanceled
  }
  
  public func showCompressionError(_ compressionError: CompressionError,_ error: Error? = nil , completionHandler: (() -> Void)? = nil) {
    let errorDescription = LocalizationService.Errors.getCompressionErrorDescriptionForKey(compressionError, error: error)
    A.presentErrorAlert(with: errorDescription) {
      completionHandler?()
    }
  }
}

extension ErrorManager {
  
  enum DeepCleanProcessingError: Error {
    case error
  }
  
  public func showDeepCleanErrorForkey(_ error: DeepCleanProcessingError, completionHandler: (() -> Void)? = nil) {
    let errorDescription = LocalizationService.Errors.getDeepCleanDescriptionForKey(error)
    A.presentErrorAlert(with: errorDescription) {
      completionHandler?()
    }
  }
}

extension ErrorManager {
  
  enum DeleteError: Error {
    case errorDeleteContacts
    case errorDeletePhoto
    case errorDeleteVideo
    
    var errorDescription: ErrorDescription {
      return LocalizationService.Errors.deleteErrorDescription(self)
    }
  }
  
  public func deleteErrorForKey(_ error: DeleteError) -> String {
    switch error {
    case .errorDeleteContacts:
      return Localization.ErrorsHandler.DeleteError.deleteContactsError
    case .errorDeletePhoto:
      return Localization.ErrorsHandler.DeleteError.deletePhotoError
    case .errorDeleteVideo:
      return Localization.ErrorsHandler.DeleteError.deleteVideoError
    }
  }
}

extension ErrorManager {
    
  enum MeergeError: Error {
        case errorMergeContacts
        case mergeWithErrors
    
    var errorDescription: ErrorDescription {
      return LocalizationService.Errors.mergeErrorDescription(self)
    }
    }
  
  public func mergeErrorForKey(_ error: MeergeError) -> String {
    switch error {
      case .errorMergeContacts:
        return Localization.ErrorsHandler.MergeError.errorMergeContact
      case .mergeWithErrors:
        return Localization.ErrorsHandler.MergeError.mergeContactsError
    }
  }
}

extension ErrorManager {
  
  enum LoadError: Error {
    case errorLoadContacts
    case errorCreateExportFile
    
    var errorDescription: ErrorDescription {
      return LocalizationService.Errors.leadErrorDescription(self)
    }
  }
  
  public func loadErrorForKey(_ error: LoadError) -> String {
    switch error {
    case .errorLoadContacts:
      return Localization.ErrorsHandler.Errors.errorLoadContact
    case .errorCreateExportFile:
      return Localization.ErrorsHandler.Errors.errorCreateExpoert
    }
  }
}

extension ErrorManager {
  
  enum FatalError: Error {
    case datePickerMinimumDateError
    
    var errorRawValue: String {
      switch self {
        case .datePickerMinimumDateError:
          return Localization.ErrorsHandler.Errors.minimumPickerError
      }
    }
    
    var errorDescription: ErrorDescription {
      return LocalizationService.Errors.fatalErrorDescription(self)
    }
  }

  public func fatalErrorForKey(_ error: FatalError) -> String {
    switch error {
      case .datePickerMinimumDateError:
        return error.errorRawValue
    }
  }
}

extension ErrorManager {
  
  public func showDeleteAlertError(_ errorType: DeleteError) {
    A.presentErrorAlert(with: errorType.errorDescription)
  }
  
  public func showLoadAlertError(_ errorType: LoadError) {
    A.presentErrorAlert(with: errorType.errorDescription)
  }
  
  public func showMergeAlertError(_ errorType: MeergeError, compltionHandler: (() -> Void)? = nil) {
    A.presentErrorAlert(with: errorType.errorDescription) {
      compltionHandler?()
    }
  }
  
  public func showFatalErrorAlert(_ errorType: FatalError) {
    A.presentErrorAlert(with: errorType.errorDescription)
  }
}
