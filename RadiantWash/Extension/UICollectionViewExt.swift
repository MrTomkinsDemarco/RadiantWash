//
//  UICollectionViewExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import UIKit

extension UICollectionView {
  
  func selectAllItems(in section: Int, first itemIndex: Int = 0, animated: Bool) {
    (itemIndex..<numberOfItems(inSection: section)).compactMap({ (item) -> IndexPath? in
      return IndexPath(item: item, section: section)
    }).compactMap({ $0}).forEach { (indexPath) in
      selectItem(at: indexPath, animated: animated, scrollPosition: [])
    }
  }
  
  func deselectAllItems(in section: Int, first itemIndex: Int = 0, animated: Bool) {
    (itemIndex..<numberOfItems(inSection: section)).compactMap({ (item) -> IndexPath? in
      return IndexPath(item: item, section: section)
    }).compactMap({ $0}).forEach { (indexPath) in
      deselectItem(at: indexPath, animated: animated)
    }
  }
  
  func getAllIndexPathsInSection(section : Int) -> [IndexPath] {
    let count = self.numberOfItems(inSection: section)
    return (0..<count).map({IndexPath(item: $0, section: section)})
  }
  
  func indexPathsForElements(in rect: CGRect) -> [IndexPath] {
    let allLayoutAttributes = collectionViewLayout.layoutAttributesForElements(in: rect)!
    return allLayoutAttributes.filter({ $0.representedElementCategory == .cell }).map { $0.indexPath }
  }
  
  func scrollToNextItem() {
    let contentOffset = CGFloat(floor(self.contentOffset.x + self.bounds.size.width))
    self.moveToFrame(contentOffset: contentOffset)
  }
  
  func scrollToPreviousItem() {
    let contentOffset = CGFloat(floor(self.contentOffset.x - self.bounds.size.width))
    self.moveToFrame(contentOffset: contentOffset)
  }
  
  func moveToFrame(contentOffset : CGFloat) {
    self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
  }
  
  func reloadDataWitoutAnimation() {
    
    UIView.performWithoutAnimation {
      reloadData()
    }
  }
  
  func reloadDataWithotAnimationKeepSelect(at indexPath: [IndexPath]) {
    UIView.performWithoutAnimation {
      reloadSelectedItems(at: indexPath)
    }
  }
  
  func reloadDataWithotAnimation(in section: IndexSet) {
    
    UIView.performWithoutAnimation {
      reloadSections(section)
    }
  }
  
  func smoothReloadData(completionHandler: (() -> Void)? = nil) {
    
    UIView.transition(with: self, duration: 0.35, options: .transitionCrossDissolve) {
      self.reloadData()
    } completion: { _ in
      completionHandler?()
    }
  }
  
  func reloadSelectedItems(at indexPaths: [IndexPath]) {
    
    let selectedItems = indexPathsForSelectedItems
    reloadItems(at: indexPaths)
    if let selectedItems = selectedItems {
      for selectedItem in selectedItems {
        if indexPaths.contains(selectedItem) {
          selectItem(at: selectedItem, animated: false, scrollPosition: [])
        }
      }
    }
  }
}
