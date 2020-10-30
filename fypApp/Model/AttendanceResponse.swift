//
//  AttendanceResponse.swift
//  fypApp
//
//  Created by Bowie Tso on 30/10/2020.
//  Copyright © 2020 Bowie Tso. All rights reserved.
//
import Foundation
import RealmSwift
import ObjectMapper

class AttendanceResponse: Object, Mappable{
    
    @objc dynamic var message : String?
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        message <- map["message"]

        
    }
    
    
}
