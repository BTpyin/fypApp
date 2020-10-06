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
    var currentStudentList = List<Student>()
    
    
    required convenience init?(map: Map) {
      self.init()
    }
    
    func mapping(map: Map) {
        classroomId <- map["classroomId"]
        classroomName <- map["classroomName"]
        currentCourse <- map["currentCourse"]
        currentTeacher <- map["currentTeacher"]
        currentTeacherId <- map["currentTeacherId"]
        
        var currentStudentList: [Student]?
        currentStudentList <- map["currentStudentList"]
        if let currentStudentList = currentStudentList {
          for currentStudentList in currentStudentList {
            self.currentStudentList.append(currentStudentList)
          }
        }
    }
}
