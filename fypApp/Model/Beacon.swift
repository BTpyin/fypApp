//
//  Beacon.swift
//  fypApp
//
//  Created by Bowie Tso on 21/9/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Beacon: Object, Mappable{
    
    @objc dynamic var uuid : UUID?
    @objc dynamic var major : String?
    @objc dynamic var minor : String?
    @objc dynamic var classroomId : String?
    @objc dynamic var remarks : String?
    
    required convenience init?(map: Map) {
      self.init()
    }
    
    func mapping(map: Map) {
        uuid <- map["uuid"]
        major <- map["major"]
        minor <- map["minor"]
        classroomId <- map["classroomId"]
        remarks <- map["remarks"]
    }
}
