//
// Created by Leonid Nifantyev on 2019-06-16.
// Copyright (c) 2019 Nifantyev. All rights reserved.
//

public typealias TimeStamp = Double

public extension TimeStamp {
  var timePassedCaption: String? {
    let diff: Int = (Date().millisecondsSince1970 - self).int
    let seconds = diff / 1000
    let minutes = seconds / 60
    let hours = minutes / 60
    let days = hours / 24
    
    if days > 0 && days < 28 {
      return "\(days) days ago"
    }
    
    if hours > 0 && hours < 24 {
      return "\(hours) hours ago"
    }
    
    if minutes > 0 && minutes < 60 {
      return "\(minutes) min ago"
    }
    if seconds > 0 && seconds < 60 {
      return "\(seconds) sec ago"
    }
  
    let future = (days: -days,hours: -hours,minutes: -minutes, seconds: -seconds)
  
    if future.days > 0 && future.days < 28 {
      return "\(days) days"
    }
  
    if future.hours > 0 && future.hours < 24 {
      return "\(future.hours) hours"
    }
  
    if future.minutes > 0 && future.minutes < 60 {
      return "\(future.minutes) min"
    }
    if future.seconds > 0 && future.seconds < 60 {
      return "\(future.seconds) sec"
    }
    
    return .none
  }
  
  var whenHappen: String? {
    let diff: Double = (self - Date().millisecondsSince1970)
    let seconds = (diff / 1000).int
    let minutes = seconds / 60
    let hours = minutes / 60
    let days = hours / 24
  
    if days > 0 && days < 28 {
      return "\(days) days"
    }
  
    if hours > 0 && hours < 24 {
      let m = minutes - hours * 60
      let s = seconds - minutes * 60
      
      return "\(hours.decade):\(m.decade):\(s.decade)"
    }
  
    if minutes > 0 && minutes < 60 {
      
      let sec = seconds - minutes * 60
      
      return "00:\(minutes.decade):\(sec.decade)"
    }
    if seconds > 0 && seconds < 60 {
      return "00:00:\(seconds.decade)"
    }
    
    return .none
  }
  
  
  var whenSeconds: Int {
    let diff: Int = (self - Date().millisecondsSince1970).int
    return diff / 1000
  }
  
  
  var string: String {
    return String(self)
  }
  
  var localDate: Date {
    return Date(timeIntervalSince1970: self.timeInterval)
  }
  
  var timeInterval: TimeInterval {
    return TimeInterval(self) / 1000
  }
}


public extension Int {
  var decade: String {
    return self < 10 ? "0\(self)" : "\(self)"
  }
}

public extension Date {
  var millisecondsSince1970: TimeStamp {
    return Double((self.timeIntervalSince1970 * 1000.0).rounded())
  }
  
  var timeStamp: TimeStamp {
    return (self.timeIntervalSince1970 * 1000).timestamp
  }
  
  func string(with format: String) -> String {
    let fmt = DateFormatter()
    fmt.dateFormat = format
    fmt.timeZone = .current
    return fmt.string(from: self)
  }
}
