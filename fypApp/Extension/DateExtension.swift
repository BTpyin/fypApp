//
//  DateExtension.swift
//  fypApp
//
//  Created by Bowie Tso on 2/11/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import Foundation

extension Date {

    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }

    func endOfDay() -> Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay())!
    }
  func lastMonth() -> Date {
    return Calendar(identifier: .gregorian).date(byAdding: .year, value: -2, to: self) ?? self
  }
  
  func nextMonth() -> Date {
    return Calendar(identifier: .gregorian).date(byAdding: .month, value: 1, to: self) ?? self
  }
  
  func startOfMonth() -> Date {
    return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
  }
  
  func endOfMonth() -> Date {
    return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
  }
  
  func startOfYear()-> Date {
    return Calendar.current.date(byAdding: DateComponents(month: -11, day: -30), to: self.endOfYear())!
  }
  
  func endOfYear()-> Date {
    return Calendar.current.date(bySetting:.month, value: 12, of: self.startOfMonth())!.endOfMonth()
  }
}
