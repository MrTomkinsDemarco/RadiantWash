//
//  VideoCompressionErrorHandler.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

enum VideoCompressionErrorHandler: Error, LocalizedError {
  
  case noVideoFile
  case compressedFailed(_ error: Error)
  case errorRemoveAudioComponent
  case operationIsCanceled
  
  public func showErrorAlert(completionHandler: @escaping () -> Void) {
    switch self {
      case .noVideoFile:
        ErrorHandler.shared.showCompressionError(.noVideoFile) {
          completionHandler()
        }
      case .compressedFailed(let error):
        ErrorHandler.shared.showCompressionError(.compressionFailed, error) {
          completionHandler()
        }
      case .errorRemoveAudioComponent:
        ErrorHandler.shared.showCompressionError(.removeAudio) {
          completionHandler()
        }
      case .operationIsCanceled:
        ErrorHandler.shared.showCompressionError(.operationIsCanceled) {
          completionHandler()
        }
    }
  }
}
