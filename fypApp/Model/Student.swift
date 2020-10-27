//
//  Student.swift
//  fypApp
//
//  Created by Bowie Tso on 17/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Student: Object, Mappable{
    
    @objc dynamic var studentId : String?
    @objc dynamic var firstName : String?
    @objc dynamic var lastName : String?
    @objc dynamic var displayName : String?
    @objc dynamic var program : String?
    @objc dynamic var major : String?
    @objc dynamic var scheduleLink : String?
    var weekRecord = List<Class>()
    
    required convenience init?(map: Map) {
      self.init()
    }
    
    func mapping(map: Map) {
        studentId <- map["studentId"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        displayName <- map["display_name"]
        program <- map["program"]
        major <- map["major"]
        scheduleLink = "https://img.eservice-hk.net/upload/2017/09/01/173055_b87ec340704d636378db12dfeaf8a970.png"
        var weekRecord: [Class]?
        weekRecord <- map["weekRecord"]
        if let weekRecord = weekRecord {
          for weekRecord in weekRecord {
            self.weekRecord.append(weekRecord)
          }
        }
    }
    
    func demoStudent()->Student{
        var demo = Student()
        demo.studentId = "33334444"
        demo.firstName = "Bow"
        demo.lastName = "demo"
        demo.displayName = "BOWJai123"
        demo.major = "INFE"
        demo.program = "EE"
        demo.scheduleLink = "https://img.eservice-hk.net/upload/2017/09/01/173055_b87ec340704d636378db12dfeaf8a970.png"
        return demo
    }
    

}
