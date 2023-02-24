//
//  SegmentDatePickerDelegate.swift
//  RadiantWash
//
//  Created by Mac Mini on 20.02.2023.
//

import Foundation

protocol SegmentDatePickerDelegate {
  
  func datePicker(_ segmentDatePicker: SegmentDatePicker, didSelect row: Int, in component: Int)
}
