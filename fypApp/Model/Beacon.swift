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
    
    @objc dynamic var uuid : String?
    @objc dynamic var major : String?
    @objc dynamic var minor : String?
    @objc dynamic var classroomId : String?
    @objc dynamic var remarks : String?
    
//    override static func primaryKey() -> String? {
//      return "uuid"
//    }
    
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
    
    func demoBeacon(major :String, minor:String, classroomId: String)->Beacon{
        var b=Beacon()
        b.uuid = Global.beaconUUID
        b.major = major
        b.minor = minor
        b.classroomId = classroomId
        return b
    }
}

class BeaconPayload : Mappable{
  var beaconList: [Beacon]?
//  var downloadToken: String?

  required init?(map: Map) {

  }

  func mapping(map: Map) {
    beaconList <- map["Beacons"]
//    downloadToken <- map["downloadToken"]
    
  }
}

