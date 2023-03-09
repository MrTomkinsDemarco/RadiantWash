//
//  VideoCompressionErrorManager.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

enum VideoCompressionErrorManager: Error, LocalizedError {
  
  case noVideoFile
  case compressedFailed(_ error: Error)
  case errorRemoveAudioComponent
  case operationIsCanceled
  
  public func showErrorAlert(completionHandler: @escaping () -> Void) {
    switch self {
      case .noVideoFile:
      ErrorManager.shared.showCompressionError(.noVideoFile) {
          completionHandler()
        }
      case .compressedFailed(let error):
      ErrorManager.shared.showCompressionError(.compressionFailed, error) {
          completionHandler()
        }
      case .errorRemoveAudioComponent:
      ErrorManager.shared.showCompressionError(.removeAudio) {
          completionHandler()
        }
      case .operationIsCanceled:
      ErrorManager.shared.showCompressionError(.operationIsCanceled) {
          completionHandler()
        }
    }
  }
}
