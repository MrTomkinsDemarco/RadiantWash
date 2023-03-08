//
//  PHAssetLocationGridDataSource.swift
//  RadiantWash
//
//  Created by Mac Mini on 22.02.2023.
//

import UIKit
import Photos

protocol PHAssetLocationGridDelegate {
  func share(phasset: PHAsset)
  func removeLocation(at asset: PHAsset)
}

class PHAssetLocationGridDataSource: NSObject {
  
  private var phassetLocationViewModel: PHAssetLocationViewModel
  
  public var mediaType: PhotoMediaType
  public var contentType: MediaContentType
  public var collectionView: UICollectionView
  private var prefetchCacheImageManager = PhotoManager.shared.prefetchManager
  public var thumbnailSize: CGSize = .zero
  
  public var didSelectDeleteLocation: ((_ phassets:  [PHAsset]?) -> Void)?
  public var didSelectedPhassets: ((_ phassets:  [PHAsset]?) -> Void)?
  public var delegate: PHAssetLocationGridDelegate?
  
  init(phassetLocationViewModel: PHAssetLocationViewModel, mediaType: PhotoMediaType, contentType: MediaContentType, collectionView: UICollectionView) {
    self.phassetLocationViewModel = phassetLocationViewModel
    self.mediaType = mediaType
    self.contentType = contentType
    self.collectionView = collectionView
  }
  
  private func setup(cell: PhotoCell, at indexPath: IndexPath) {
    
    guard let phasset = self.phassetLocationViewModel.getPhasset(at: indexPath) else { return }
    
    cell.setupSelectButton(by: self.mediaType)
    cell.indexPath = indexPath
    cell.tag = indexPath.section * 1000 + indexPath.row
    cell.cellMediaType = self.mediaType
    cell.cellContentType = self.contentType
    cell.collectionType = .single
    if self.thumbnailSize.equalTo(CGSize.zero) {
      self.thumbnailSize = self.collectionView.collectionViewLayout.layoutAttributesForItem(at: indexPath)!.size.toPixel()
    }
    
    cell.loadThumbnail(phasset, imageManager: self.prefetchCacheImageManager, size: thumbnailSize)
    cell.setupUI()
    cell.setupAppearance()
    
    if let path = self.collectionView.indexPathsForSelectedItems, path.contains([indexPath]) {
      cell.isSelected = true
    } else {
      cell.isSelected = false
    }
    cell.checkIsSelected()
  }
  
  private func setup(header: LocationHeaderCollectionReusableView, at indexPath: IndexPath) {
    
    guard let phasset = self.phassetLocationViewModel.getPhasset(at: indexPath) else { return }
    
    header.delegate = self
    
    let dateCompoenents = self.phassetLocationViewModel.getDateComponent(at: indexPath.section)
    header.configureHeader(with: phasset.location, dateComponents: dateCompoenents, section: indexPath.section)
  }
  
  private func checkSelectedHeaderView(for indexPath: IndexPath, headerView: GroupedAssetsReusableHeaderView) {}
  
  private func handleSelectedPhassets(at indexPath: IndexPath) {
    let selectedIndexPaths = self.collectionView.indexPathsForSelectedItems
    if let selectedIndexPaths = selectedIndexPaths {
      var phassets: [PHAsset] = []
      selectedIndexPaths.forEach {
        if let phasset = self.phassetLocationViewModel.getPhasset(at: $0) {
          phassets.append(phasset)
        }
      }
      self.didSelectedPhassets?(phassets)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    guard let asset = self.phassetLocationViewModel.getPhasset(at: indexPath) else { return nil}
    let identifier = IndexPath(item: indexPath.item, section: indexPath.section) as NSCopying
    
    return UIContextMenuConfiguration(identifier: identifier) {
      return AssetContextPreviewController(asset: asset)
    } actionProvider: { _ in
      return self.createCellContextMenu(for: asset, at: indexPath)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
    
    guard let indexPath = configuration.identifier as? IndexPath,  let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell else { return nil}
    
    let targetPreview = UITargetedPreview(view: cell.photoThumbnailImageView)
    targetPreview.parameters.backgroundColor = .clear
    targetPreview.view.backgroundColor = .clear
    return targetPreview
  }
  
  func collectionView(_ collectionView: UICollectionView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
    guard let indexPath = configuration.identifier as? IndexPath, let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell else { return nil}
    
    let targetPreview = UITargetedPreview(view: cell.photoThumbnailImageView)
    targetPreview.parameters.backgroundColor = .clear
    targetPreview.view.backgroundColor = .clear
    return targetPreview
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplayContextMenu configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
    DispatchQueue.main.async {
      if let window = U.application.windows.first {
        if let view = Utils.Manager.viewByClassName(view: window, className: "_UICutoutShadowView") {
          view.isHidden = true
        }
        if let view = Utils.Manager.viewByClassName(view: window, className: "_UIPortalView") {
          view.backgroundColor = .clear
        }
        if let view = Utils.Manager.viewByClassName(view: window, className: "_UIPlatterTransformView") {
          view.backgroundColor = .clear
        }
        if let view = Utils.Manager.viewByClassName(view: window, className: "_UIPlatterClippingView") {
          view.backgroundColor = .clear
        }
        if let view = Utils.Manager.viewByClassName(view: window, className: "_UIPlatterTransformView") {
          view.backgroundColor = .clear
        }
      }
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, willEndContextMenuInteraction configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
    
    DispatchQueue.main.async {
      if let window = U.application.windows.first {
        if let view = Utils.Manager.viewByClassName(view: window, className: "_UICutoutShadowView") {
          view.isHidden = true
        }
        if let view = Utils.Manager.viewByClassName(view: window, className: "_UIPortalView") {
          view.backgroundColor = .clear
        }
        if let view = Utils.Manager.viewByClassName(view: window, className: "_UIPlatterTransformView") {
          view.backgroundColor = .clear
        }
        if let view = Utils.Manager.viewByClassName(view: window, className: "_UIPlatterClippingView") {
          view.backgroundColor = .clear
        }
        if let view = Utils.Manager.viewByClassName(view: window, className: "_UIPlatterTransformView") {
          view.backgroundColor = .clear
        }
      }
    }
  }
  
  private func createCellContextMenu(for asset: PHAsset, at indexPath: IndexPath) -> UIMenu {
    
    let shareVideoActionImage = I.systemItems.defaultItems.share
    let _ = UIAction(title: LocalizationService.Buttons.getButtonTitle(of: .share), image: shareVideoActionImage) { _ in
      self.delegate?.share(phasset: asset)
    }
    
    let removeLocationActionImage = I.location.slashPin
    let removeLocationAction = UIAction(title: LocalizationService.Buttons.getButtonTitle(of: .removeLocation), image: removeLocationActionImage, attributes: .destructive) { _ in
      self.delegate?.removeLocation(at: asset)
    }
    return UIMenu(title: "", children: [removeLocationAction])
  }
}

extension PHAssetLocationGridDataSource: LocationHeaderCollectionDelegate {
  
  func removeLocation(at section: Int) {
    let phassets = self.phassetLocationViewModel.getPhassets(at: section)
    self.didSelectDeleteLocation?(phassets)
  }
}

extension PHAssetLocationGridDataSource: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return self.phassetLocationViewModel.numberOfSection()
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.phassetLocationViewModel.numberOfRows(at: section)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.identifiers.cells.photoSimpleCell, for: indexPath) as! PhotoCell
    self.setup(cell: cell, at: indexPath)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.handleSelectedPhassets(at: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    self.handleSelectedPhassets(at: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    switch kind {
      
    case UICollectionView.elementKindSectionHeader:
      
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: C.identifiers.views.locationHeader, for: indexPath)
      
      guard let sectionHeader = headerView as? LocationHeaderCollectionReusableView else { return headerView}
      
      self.setup(header: sectionHeader, at: indexPath)
      
      return sectionHeader
      
    default:
      assert(false, "invalid")
    }
    return UICollectionReusableView()
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
    
    guard let _ = view as? LocationHeaderCollectionReusableView else { return }
    
    collectionView.collectionViewLayout.finalLayoutAttributesForDisappearingSupplementaryElement(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: 55)
  }
}
  

