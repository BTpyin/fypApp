//
//  Attendance.swift
//  fypApp
//
//  Created by Bowie Tso on 30/10/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import Foundation
import RealmSwift

class Attendance:Object{
    @objc dynamic var classId :String?
    @objc dynamic var attended: Bool = false
    
    override static func primaryKey() -> String? {
      return "classId"
    }
    
    func setAttendance(id : String, attend: Bool) -> Attendance{
        var a = Attendance()
        a.classId = id
        a.attended = attend
        return a
    }
}
