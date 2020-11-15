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

class CourseInClass: Object, Mappable{
    @objc dynamic var courseCode : String?
    @objc dynamic var name : String?
    @objc dynamic var credit : Int = 0
    
    required convenience init?(map: Map) {
      self.init()
    }
    
    func mapping(map: Map) {
        courseCode <- map["course_code"]
        name <- map["name"]
        credit <- map["credit"]
    }
}

class  Class: Object, Mappable{
    
//    @objc dynamic var courseCode : String?
    @objc dynamic var classId : String?
    @objc dynamic var name : String?
//    @objc dynamic var credit : Int = 0
    @objc dynamic var type : String?
    @objc dynamic var date : Date?
    @objc dynamic var duration : Date?
//    @objc dynamic var venue : String?
    @objc dynamic var teacher : String?
    @objc dynamic var course : CourseInClass?
    @objc dynamic var classroom: Classroom?
    var classroomId:String?
    
    required convenience init?(map: Map) {
      self.init()
    }
    
//    override static func primaryKey() -> String? {
//      return "classId"
//    }
    
    func mapping(map: Map) {
        var dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
        var durationFormatterGet = DateFormatter()
        durationFormatterGet.dateFormat = "HH:mm:ss"
//        courseCode <- map["course_code"]
        classId <- map["classId"]
        name <- map["name"]
//        credit <- map["credit"]
        type <- map["class_type"]
        var s:String?
        s <- map["date"]
        date = dateFormatterGet.date(from: s!)
        var d:String?
        d <- map["duration"]
        duration = durationFormatterGet.date(from: d!)
        //date = Calendar.current.date(byAdding: .hour, value: 0, to: date!)
//        venue <- map["classroomId"]
        teacher <- map["teacher"]
        course <- map["course"]
        classroom <- map["classroom"]
        classroomId = classroom?.classroomId
        
    }
}
