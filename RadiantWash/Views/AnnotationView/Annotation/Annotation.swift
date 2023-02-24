//
//  Annotation.swift
//  RadiantWash
//
//  Created by Mac Mini on 20.02.2023.
//

import MapKit
import Photos

class Annotation: MKPointAnnotation {
  
  public var phasset: PHAsset = PHAsset()
  public var annotationID: String?
  public var image: UIImage?
  
  public convenience init(coordinate: CLLocationCoordinate2D) {
    self.init()
    self.coordinate = coordinate
  }
}
