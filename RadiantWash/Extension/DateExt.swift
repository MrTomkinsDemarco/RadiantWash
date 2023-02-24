//
//  DateExt.swift
//  RadiantWash
//
//  Created by Mac Mini on 18.02.2023.
//

import Foundation

extension Date {
  
  static func getCurrentDate() -> Double {
    let date = Date()
    return date.timeIntervalSince1970
  }
}

extension Date {
  
  func startOfMonth() -> Date {
    return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
  }
  
  func endOfMonth() -> Date {
    return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
  }
}

extension Date {
  
  func globalTimeFromUTCConver() -> Date {
    let timezone = TimeZone.current
    let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
    return Date(timeInterval: seconds, since: self)
  }
  
  func localTimeFromUTCConvert() -> Date {
    let timezoneOffset = TimeZone.current.secondsFromGMT()
    let epochDate = self.timeIntervalSince1970
    let timezoneEpochOffset = (epochDate + Double(timezoneOffset))
    return Date(timeIntervalSince1970: timezoneEpochOffset)
  }
  
  func secondsFromBeginningOfTheDay() -> TimeInterval {
      let calendar = Calendar.current
      let dateComponents = calendar.dateComponents([.hour, .minute, .second], from: self)
      let dateSeconds = dateComponents.hour! * 3600 + dateComponents.minute! * 60 + dateComponents.second!
      return TimeInterval(dateSeconds)
  }

  func timeOfDayInterval(toDate date: Date) -> TimeInterval {
      let date1Seconds = self.secondsFromBeginningOfTheDay()
      let date2Seconds = date.secondsFromBeginningOfTheDay()
      return date2Seconds - date1Seconds
  }
  
  func convertDateFormatterFromDate(date: Date, format: String) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = format
      dateFormatter.timeZone = .current
      let timeZoneOffset = TimeZone.current.secondsFromGMT()
      let epochDate = date.timeIntervalSince1970
      let timeZoneEpochOffset = (epochDate + Double(timeZoneOffset))
      let timeZoneOffsetDate = Date(timeIntervalSince1970: timeZoneEpochOffset).endOfDay
      return dateFormatter.string(from: timeZoneOffsetDate)
  }
  
  func convertDateFormatterFromSrting(stringDate: String) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = C.dateFormat.dateFormat
      dateFormatter.timeZone = .current
      if let date = dateFormatter.date(from: stringDate) {
          dateFormatter.dateFormat = C.dateFormat.fullDmy
          let timeZoneOffset = TimeZone.current.secondsFromGMT()
          let epochDate = date.timeIntervalSince1970
          let timeZoneEpochOffset = (epochDate + Double(timeZoneOffset))
          let timeZoneOffsetDate = Date(timeIntervalSince1970: timeZoneEpochOffset)
          dateFormatter.string(from: timeZoneOffsetDate)
          return dateFormatter.string(from: timeZoneOffsetDate)
      } else {
          return stringDate
      }
  }
  
  func convertDateFormatterToDisplayString(stringDate: String) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = C.dateFormat.fullDmy
      dateFormatter.timeZone = .current
      if let date = dateFormatter.date(from: stringDate) {
          dateFormatter.dateFormat = C.dateFormat.dateFormat
          return dateFormatter.string(from: date)
      } else {
          return stringDate
      }
  }
  
  func getDateFromString(stringDate: String, format: String = C.dateFormat.fullDmy) -> Date? {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = format
      dateFormatter.timeZone = .current
      
      if let str = dateFormatter.date(from: stringDate) {
          let timeZoneOffset = TimeZone.current.secondsFromGMT()
          let epochDate = str.timeIntervalSince1970
          let timeZoneEpochOffset = (epochDate + Double(timeZoneOffset))
          let timeZoneOffsetDate = Date(timeIntervalSince1970: timeZoneEpochOffset).endOfDay
          return timeZoneOffsetDate
      } else {
          return nil
      }
  }
  
  var startOfDay : Date {
      let calendar = Calendar.current
      let unitFlags = Set<Calendar.Component>([.year, .month, .day])
      let components = calendar.dateComponents(unitFlags, from: self)
      return calendar.date(from: components)!
 }

  var endOfDay : Date {
      var components = DateComponents()
      components.day = 1
      let date = Calendar.current.date(byAdding: components, to: self.startOfDay)
      return (date?.addingTimeInterval(-1))!
  }
  
  func stringMonth() -> String {
    
      let df = DateFormatter()
      df.setLocalizedDateFormatFromTemplate("MMM")
      return df.string(from: self)
  }
}

extension Date {
  
  func isGreaterThanDate(dateToCompare: Date) -> Bool {
      //Declare Variables
    var isGreater = false
    
      //Compare Values
    if self.compare(dateToCompare) == .orderedDescending {
      isGreater = true
    }
    
      //Return Result
    return isGreater
  }
  
  func isLessThanDate(dateToCompare: Date) -> Bool {
      //Declare Variables
    var isLess = false
    
      //Compare Values
    if self.compare(dateToCompare) == .orderedAscending {
      isLess = true
    }
    
      //Return Result
    return isLess
  }
  
  func equalToDate(dateToCompare: Date) -> Bool {
      //Declare Variables
    var isEqualTo = false
    
      //Compare Values
    if self.compare(dateToCompare) == .orderedSame {
      isEqualTo = true
    }
    
      //Return Result
    return isEqualTo
  }
}

extension Date {
  
  func getHour() -> Int {
    return Calendar.current.component(.hour, from: self)
  }
  
  func getSeconds() -> Int {
    return Calendar.current.component(.second, from: self)
  }
  
  func getMinute() -> Int {
    return Calendar.current.component(.minute, from: self)
  }
  
  func getDay() -> Int {
    return Calendar.current.component(.day, from: self)
  }
  
  func getMonth() -> Int {
    return Calendar.current.component(.month, from: self)
  }
  
  func getYear() -> Int {
    return Calendar.current.component(.year, from: self)
  }
}
