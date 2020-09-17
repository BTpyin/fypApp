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
    
    required convenience init?(map: Map) {
      self.init()
    }
    
    func mapping(map: Map) {
        studentId <- map["studentId"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        displayName <- map["displayName"]
        program <- map["program"]
        major <- map["major"]
        scheduleLink <- map["scheduleLink"]
    }
    

}
