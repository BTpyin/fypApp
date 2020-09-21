//
//  Classroom.swift
//  fypApp
//
//  Created by Bowie Tso on 21/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Classroom: Object, Mappable{
    
    @objc dynamic var classroomId : String?
    @objc dynamic var classroomName : String?
    @objc dynamic var currentCourse : CourseBriefObject?
    @objc dynamic var currentTeacherId: String?
    @objc dynamic var currentTeacher : String?
    @objc dynamic var currentStudentList : [Student]?
    
    
    required convenience init?(map: Map) {
      self.init()
    }
    
    func mapping(map: Map) {
        classroomId <- map["classroomId"]
        classroomName <- map["classroomName"]
        currentCourse <- map["currentCourse"]
        currentStudentList <- map["currentStudentList"]
        currentTeacher <- map["currentTeacher"]
        currentTeacherId <- map["currentTeacherId"]
    }
}
