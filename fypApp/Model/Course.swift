//
//  Course.swift
//  fypApp
//
//  Created by Bowie Tso on 17/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//
//Model of Course + Course Brief + Class

import Foundation
import RealmSwift
import ObjectMapper

class Course: Object, Mappable{
    
    @objc dynamic var courseCode : String?
    @objc dynamic var name : String?
    @objc dynamic var credit : Int = 0
    var classes = List<Class>()

    
    required convenience init?(map: Map) {
      self.init()
    }
    
    func mapping(map: Map) {
        courseCode <- map["courseCode"]
        name <- map["name"]
        credit <- map["credit"]
        var classes: [Class]?
        classes <- map["classes"]
        if let classes = classes {
          for classes in classes {
            self.classes.append(classes)
          }
        }
    }
    

}

class CourseBriefObject: Object, Mappable{
    
    @objc dynamic var courseCode : String?
    @objc dynamic var name : String?
    @objc dynamic var credit : Int = 0


    
    required convenience init?(map: Map) {
      self.init()
    }
    
    func mapping(map: Map) {
        courseCode <- map["courseCode"]
        name <- map["name"]
        credit <- map["credit"]

    }
    

}

class  Class: Object, Mappable{
    
    @objc dynamic var courseCode : String?
    @objc dynamic var classId : String?
    @objc dynamic var name : String?
    @objc dynamic var credit : Int = 0
    @objc dynamic var type : String?
    @objc dynamic var date = 0.0
    @objc dynamic var duration : Int = 0
    @objc dynamic var venue : String?
    @objc dynamic var teacher : String?
    
    
    required convenience init?(map: Map) {
      self.init()
    }
    
    func mapping(map: Map) {
        courseCode <- map["courseCode"]
        classId <- map["classId"]
        name <- map["name"]
        credit <- map["credit"]
        type <- map["type"]
        date <- map["date"]
        duration <- map["duration"]
        venue <- map["venue"]
        teacher <- map["teacher"]
        
    }
}
